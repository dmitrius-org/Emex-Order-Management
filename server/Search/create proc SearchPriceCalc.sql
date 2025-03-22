if OBJECT_ID('SearchPriceCalc', 'P') is not null
    drop proc SearchPriceCalc     
go
/* --------------------------------------------------------
  SearchPriceCalc - расчет цены 
-------------------------------------------------------- */
create proc SearchPriceCalc
              @ProfilesCustomerID  numeric(18, 0)  
             ,@DetailNum           nvarchar(40)          
as
set nocount on;

declare @Kurs          float
       ,@RetVal       int

-- курс доллара
select @Kurs = dbo.GetCurrencyRate('840', null)
      ,@RetVal = 0

if OBJECT_ID('tempdb..#Price') is not null drop table #Price
create table #Price 
      (
       ID                  numeric(18,0)  --  
      ,Brand               varchar(60)    --
      ,DetailNum           varchar(30)    -- Номер детали 
      ,DetailPrice         float          -- Цена
      ,FinalPrice          float          -- Цена
      ,DetailName           varchar(255)   -- Название
      ,PriceLogo           varchar(30)    -- Название прайса 
      ,Quantity            int            -- Количество
      ,PackQuantity        int            -- Количество в упаковке

      ,WeightKG            float          -- Вес физический кг 
      ,VolumeKG            float          -- Вес объемный кг  

      ,TPrice              float          -- тип цены, например: MOSA, MOSC, KIRG
      ,TDel                float          -- номинал стоимости за доставку
      ,TDetPrice           float          -- номинал цены детали со скидкой
      ,TCom                float          -- номинал комиссии 
      ,TMarg               float          -- номинал наценки на товар
      ,TFinPrice           float
      ,Term                int            -- срок доставки
      ,TFinPriceKurs       money      
       --
      ,Margin               float
      ,Kurs                   float
      ,ExtraKurs           float
      ,Commission           float  -- Комиссия эквайера
      ,Discount               float  -- Скидка
      ,Reliability         float  -- Вероятность поставки
      ,PDWeightKG           float
      ,PDVolumeKG          float
       -- данные с профиля поставщика
      ,ProfilesCustomerID  numeric(18, 0)  
      ,ProfilesDeliveryID  numeric(18, 0)
      ,DestinationLogo     nvarchar(10)
      ,Delivery            int
      ,GuaranteedDay       int    -- дополнительный срок поставки с поставщика
      ,FragileSign         bit    default 0-- признак Хрункий на детали
      ,Fragile             float  default 0-- величина процента с направления доставки 
      ,NLA                 bit default 0--No longer available Более недоступно

      ,RetVal              int
      )

-- для получения даных с таблицы tPrice
declare @Num as table
       (DetailNum nvarchar(40)
       ,Make      nvarchar(40));

Update p
   set p.WeightGr  = isnull((Select max(pp.WeightGr)  from pFindByNumber pp with (nolock index=ao3) where pp.Spid = @@Spid and pp.make = p.Make and pp.DetailNum = p.DetailNum), 0)  
      ,p.VolumeAdd = isnull((Select max(pp.VolumeAdd) from pFindByNumber pp with (nolock index=ao3) where pp.Spid = @@Spid and pp.make = p.Make and pp.DetailNum = p.DetailNum), 0)  
  from pFindByNumber p with (updlock index=ao1)
 where p.Spid = @@Spid

declare  @Price  table
       ( DetailNum   nvarchar(40)
        ,MakeLogo    nvarchar(40)
        ,WeightKGF   float
        ,VolumeKGf   float
        ,FragileSign bit
        ,NLA         bit
        ,DetailName  nvarchar(256));

insert @Num (DetailNum, Make)
select distinct p.DetailNum, p.Make
  from pFindByNumber p with (nolock index=ao2)
 where p.Spid = @@spid
   and p.DetailNum = @DetailNum

insert @Price
       (DetailNum, 
        MakeLogo, 
        WeightKGF, 
        VolumeKGf,
        FragileSign,
        NLA,
        DetailName)
select 
       p.DetailNum,
       p.Make,
       max(pp.WeightKGF),
       max(pp.VolumeKGf),
       max( cast(isnull(pp.Fragile, 0) as int) ),
       max( cast(isnull(pp.NLA, 0) as int) ),
       max(pp.DetailNameF)
  from @Num p 
 inner join tPrice pp with (nolock index=ao2) 
         on pp.DetailNum = p.DetailNum
        and pp.MakeLogo  = p.Make
group by p.DetailNum, p.Make

-- расчет цены
insert #Price with (rowlock)
      (ID        
      ,Brand        
      ,DetailNum      
      ,DetailPrice  
      ,DetailName      
      ,PriceLogo    
      ,Quantity     
      ,PackQuantity 
      ,Term
      ,WeightKG 
      ,VolumeKG 
      ,TPrice  
      ,Margin    
      ,Reliability
      ,Kurs    
      ,ExtraKurs
      ,Commission    
      ,Discount    
      
      ,PDWeightKG    
      ,PDVolumeKG      
      ,DestinationLogo
      ,ProfilesDeliveryID
      ,ProfilesCustomerID

      ,Delivery -- дополнительный срок поставки с поставщика
      ,GuaranteedDay
      ,FragileSign
      ,Fragile
      ,NLA
      )
select p.ID,
       p.MakeName, 
       p.DetailNum, 
       p.Price,
       case
         when (p.flag&65536)>0 then p.PartNameRus -- 65536 - Наименование изменен клиентом
         else isnull(pp.DetailName, p.PartNameRus) 
       end,-- DetailName
       p.PriceLogo,
       1, 
       p.Packing, 
       0,--pt.Term,
       case
         when (p.flag&512)>0 then p.WeightGr -- 512 - Вес изменен клиентом
         else isnull(pp.WeightKGF,p.WeightGr)
       end,
       case
         when (p.flag&512)>0 then p.VolumeAdd-- 512 - Вес изменен клиентом
         else isnull(pp.VolumeKGf,p.VolumeAdd) 
       end *       
       case --коэффициенты [VolumeKG]
         when isnull(p.VolumeAdd, 0) < 10                 then isnull(pd.VolumeKG_Rate1, 1) -- 1. Коэффициент на детали у которых [VolumeKG] строго меньше 10 кг
         when isnull(p.VolumeAdd, 0) between 10 and 19.99 then isnull(pd.VolumeKG_Rate2, 1) -- 2. Коэффициент на детали у которых [VolumeKG] от 10 кг включительно, но строго меньше 20 кг
         when isnull(p.VolumeAdd, 0) between 20 and 24.99 then isnull(pd.VolumeKG_Rate3, 1) -- 3. Коэффициент на детали у которых [VolumeKG] от 20 кг включительно, но строго меньше 25 кг
         when isnull(p.VolumeAdd, 0) >= 25                then isnull(pd.VolumeKG_Rate4, 1) -- 4. Коэффициент на детали у которых [VolumeKG] от 25 кг включительно
         else 1
       end,
       p.Price,
       pd.Margin,
       pd.Reliability,
       @Kurs, 
       s.ExtraKurs,
       s.Commission,
       --case 
       --  when p.flag&1>0 then s.Discount
       --  else 0 -- по АПИ цена приходит с учетом скидки
       --end,
       0,
       pd.WeightKG,
       pd.VolumeKG,
       pd.DestinationLogo,
       pd.ProfilesDeliveryID,
       @ProfilesCustomerID,
       isnull(pd.DeliveryTermFromSupplier, 0),
       p.GuaranteedDay,
       isnull(pp.FragileSign, 0),
       isnull(pd.Fragile, 0),
       isnull(pp.NLA, 0)
  from pFindByNumber p with (nolock index=ao1)
 inner join tClients c  with (nolock index=PK_tClients_ClientID)
         on c.ClientID = p.ClientID 
 inner join tSuppliers s  with (nolock index=ao1)
         on S.SuppliersID = c.SuppliersID

 outer apply ( -- для клиентов работающих через файл, профилей может быть несколько
      select top 1 *
        from vClientProfilesParam
       where ProfilesCustomerID = @ProfilesCustomerID
     ) as pd

 left join @Price pp
        on pp.DetailNum = p.DetailNum
       and pp.MakeLogo  = p.Make    
       
 where p.Spid = @@Spid  

Update #Price  
   set TDel = case
                -- If "Физический вес из прайса" >= "Объемный вес из прайса", то:
                 -- Конечный вес = "Физический вес из прайса" * "Цена за физ кг"
                when WeightKG >= VolumeKG 
                  then WeightKG * (PDWeightKG)
                -- Else "Физический вес из прайса" < "Объемный вес из прайса", то:
                   -- Конечный вес = "Физический вес из прайса" * "Цена за физ кг" + ("Объемный вес из прайса" - "Физический вес из прайса") * "Цена за объем кг"   
                  else WeightKG * (PDWeightKG) + (VolumeKG-WeightKG) * (PDVolumeKG)
              end
    
--Вычисляем номинал цены детали со скидкой: TDetPrice = DetailPrice - DetailPrice*Discount
Update #Price set TDetPrice = DetailPrice- DetailPrice * (Discount/100)
 
Update #Price set TCom = TDetPrice * (Commission/100)    
-- Вычисляем номинал наценки на товар: TMarg = TDetPrice*Margin
Update #Price set TMarg = TDetPrice* (Margin/100)

Update #Price set TFinPrice = (TDetPrice + TDel + TMarg + TCom)
--Если у детали установлен пункт Fragile, считать ее сразу с этой наценкой
--Например, если мы ставим галочку во Fragile, то к себестоимости детали добавляется 3%
Update #Price 
   set TFinPrice  =  TFinPrice  + (TFinPrice * (isnull(Fragile, 0)/100))
 where isnull(FragileSign, 0) > 0

Update #Price set TFinPriceKurs  = TFinPrice * (Kurs + (Kurs * (isnull(ExtraKurs, 0)/100)))

Update #Price set FinalPrice = TFinPriceKurs
      
Update f 
   set f.PriceRub           = CEILING(p.FinalPrice)
                            
      ,f.Margin             = p.Margin
      ,f.Discount           = p.Discount
      ,f.Kurs               = p.Kurs
      ,f.ExtraKurs          = p.ExtraKurs
      ,f.Commission         = p.Commission
      ,f.Reliability        = p.Reliability
      ,f.Fragile            = p.Fragile
                            
      ,f.DestinationLogo    = p.DestinationLogo
      ,f.WeightGr           = p.WeightKG   
      ,f.VolumeAdd          = p.VolumeKG   
      ,f.PartNameRus        = p.DetailName
      ,f.Flag               = iif(p.NLA=1, f.Flag|2 /* No longer available Более недоступно */, f.Flag )
      ,f.ProfilesCustomerID = p.ProfilesCustomerID
  from #Price p (nolock)
 inner join pFindByNumber f (updlock)
         on f.Spid = @@Spid
        and f.ID   = p.ID

-- расчет ближайшей дата вылета
delete pDeliveryDate from pDeliveryDate (rowlock) where spid = @@spid
insert pDeliveryDate with (rowlock)
      (Spid, ID, OrderDate, ProfilesDeliveryID, Delivery)
select @@SPID, 
       ID, 
       DATEADD(dd, GuaranteedDay, cast(getdate() as date)),
       ProfilesDeliveryID,
       isnull(Delivery, 0) -- значение с профиля поставщика
  from #Price (nolock)

exec DeliveryDateCalc  

Update f 
   set f.OurDelivery    = f.GuaranteedDay + DATEDIFF(dd, p.OrderDate, p.DeliveryDate) + p.Delivery
      ,f.OurDeliverySTR = cast(f.GuaranteedDay as nvarchar) + ' + ' + cast(DATEDIFF(dd, p.OrderDate, p.DeliveryDate) as nvarchar) + ' + ' + cast(p.Delivery as nvarchar) + ' = ' + Cast(f.GuaranteedDay + DATEDIFF(dd, p.OrderDate, p.DeliveryDate) + p.Delivery as nvarchar)      
  from pDeliveryDate p with (nolock index=ao1)
 inner join pFindByNumber f with (updlock index=ao1)
         on f.Spid = @@Spid
        and f.ID   = p.ID
 where p.Spid = @@Spid
    
exit_:
return @RetVal    
go
grant exec on SearchPriceCalc to public
go
exec setOV 'SearchPriceCalc', 'P', '20250320', '15'
go
