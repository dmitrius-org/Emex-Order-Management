if OBJECT_ID('CustomerPriceCalc', 'P') is not null
    drop proc CustomerPriceCalc	 
go
if OBJECT_ID('SearchPriceCalc', 'P') is not null
    drop proc SearchPriceCalc	 
go
/* --------------------------------------------------------
  SearchPriceCalc - расчет цены 
-------------------------------------------------------- */
create proc SearchPriceCalc
              @DestinationLogo	nvarchar(20),
			  @DetailNum        nvarchar(40)
as
set nocount on;

declare @Kurs		  float
	   ,@RetVal       int

-- курс доллара
select @Kurs = dbo.GetCurrencyRate('840', null)

if OBJECT_ID('tempdb..#Price') is not null drop table #Price

create table #Price 
(
 ID                  numeric(18,0)  --  
--,PriceID             numeric(18, 0) -- идентификатор детали tPrice.PriceID

,Brand               varchar(60)    --
,DetailNum	         varchar(30)    -- Номер детали 
,DetailPrice         float          -- Цена
,FinalPrice          float          -- Цена
,DetailName	         varchar(255)   -- Название
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

,DestinationLogo     nvarchar(10)

,Margin		         float
,Kurs		         float
,ExtraKurs           float
,Commission	         float  -- Комиссия эквайера
,Discount	         float  -- Скидка
,Reliability         float  -- Вероятность поставки
,PDWeightKG	         float
,PDVolumeKG          float

 -- данные с профиля поставщика
,ProfilesDeliveryID  numeric(18, 0)
,Delivery            int
,GuaranteedDay       int    -- дополнительный срок поставки с поставщика

,RetVal              int
)

-- для получения даных с таблицы tPrice
declare @Num as table
       (DetailNum nvarchar(40));

Update p
   set p.WeightGr  = isnull((Select max(pp.WeightGr)  from pFindByNumber pp (nolock) where pp.Spid = @@Spid and pp.make = p.Make and pp.DetailNum = p.DetailNum), 0)  
      ,p.VolumeAdd = isnull((Select max(pp.VolumeAdd) from pFindByNumber pp (nolock) where pp.Spid = @@Spid and pp.make = p.Make and pp.DetailNum = p.DetailNum), 0)  
  from pFindByNumber p (nolock)
 where p.Spid = @@Spid

declare  @Price  table
       ( DetailNum nvarchar(40)
        ,MakeLogo  nvarchar(40)
        ,WeightKGF float
		,VolumeKGf float);

insert @Num (DetailNum)
select distinct p.DetailNum
  from pFindByNumber p with (nolock index=ao2)
 where p.Spid = @@spid
   and p.DetailNum = @DetailNum

insert @Price
       (DetailNum, 
		MakeLogo, 
		WeightKGF, 
		VolumeKGf
		)
select top 1 
       pp.DetailNum,
	   pp.MakeLogo,
	   pp.WeightKGF,
	   pp.VolumeKGf
  from @Num p 
 inner join tPrice pp with (nolock index=ao2) 
         on pp.DetailNum = p.DetailNum
order by pp.WeightKGF desc, pp.VolumeKGf desc


-- расчет цены
insert #Price
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
      ,Kurs	
      ,ExtraKurs
      ,Commission	
      ,Discount	
      ,Reliability
      ,PDWeightKG	
      ,PDVolumeKG      
      ,DestinationLogo
	  ,ProfilesDeliveryID
	  ,Delivery -- дополнительный срок поставки с поставщика
	  ,GuaranteedDay
	  )
select p.ID,
       p.MakeName, 
       p.DetailNum, 
	   p.Price,
	   p.DetailNum, 
	   p.PriceLogo,
	   1, 
	   p.Packing, 
	   0,--pt.Term,
       case
         when (p.flag&512)>0 then p.WeightGr
	     else isnull(pp.WeightKGF,p.WeightGr)
       end,

       case
         when (p.flag&512)>0 then p.VolumeAdd
	     else isnull(pp.VolumeKGf,p.VolumeAdd) 
       end	   
           * case --коэффициенты [VolumeKG]
               when isnull(p.VolumeAdd, 0) < 10                 then isnull(pd.VolumeKG_Rate1, 1) -- 1. Коэффициент на детали у которых [VolumeKG] строго меньше 10 кг
               when isnull(p.VolumeAdd, 0) between 10 and 19.99 then isnull(pd.VolumeKG_Rate2, 1) -- 2. Коэффициент на детали у которых [VolumeKG] от 10 кг включительно, но строго меньше 20 кг
               when isnull(p.VolumeAdd, 0) between 20 and 24.99 then isnull(pd.VolumeKG_Rate3, 1) -- 3. Коэффициент на детали у которых [VolumeKG] от 20 кг включительно, но строго меньше 25 кг
               when isnull(p.VolumeAdd, 0) >= 25                then isnull(pd.VolumeKG_Rate4, 1) -- 4. Коэффициент на детали у которых [VolumeKG] от 25 кг включительно
               else 1
             end,
	   p.Price,
       pc.Margin,		
       @Kurs, 	
       pc.ExtraKurs,
       pc.Commission,
       pc.Discount,	
       pc.Reliability,
       pd.WeightKG,
       pd.VolumeKG,
       pd.DestinationLogo,
	   pd.ProfilesDeliveryID,
	   pd.Delivery,
	   p.GuaranteedDay
  from pFindByNumber p (nolock)
 inner join tProfilesCustomer pc (nolock)
         on pc.ClientID = p.ClientID
 inner join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
        and pd.DestinationLogo    = @DestinationLogo
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

Update #Price set TFinPriceKurs  = TFinPrice * (Kurs + (Kurs * (isnull(ExtraKurs, 0)/100)))

Update #Price set FinalPrice = TFinPriceKurs --CEILING(TFinPriceKurs)
	  
Update f 
   set f.PriceRub        = CEILING(p.FinalPrice)
      ,f.Margin          = p.Margin
      ,f.Discount        = p.Discount
      ,f.DestinationLogo = p.DestinationLogo
	  ,f.WeightGr	     = p.WeightKG   
	  ,f.VolumeAdd       = p.VolumeKG   
  from #Price p (nolock)
 inner join pFindByNumber f (updlock)
         on f.Spid = @@Spid
        and f.ID   = p.ID

-- расчет ближайшей дата вылета
delete pDeliveryDate from pDeliveryDate (rowlock) where spid = @@spid
insert pDeliveryDate 
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
       /**/
      ,f.OurDeliverySTR = cast(f.GuaranteedDay as nvarchar) + ' + ' + cast(DATEDIFF(dd, p.OrderDate, p.DeliveryDate) as nvarchar) + ' + ' + cast(p.Delivery as nvarchar) + ' = ' + Cast(f.GuaranteedDay + DATEDIFF(dd, p.OrderDate, p.DeliveryDate) + p.Delivery as nvarchar)
  from pDeliveryDate p with (nolock index=ao1)
 inner join pFindByNumber f with (updlock index=ao1)
         on f.Spid = @@Spid
        and f.ID   = p.ID
 where p.Spid = @@Spid
    
exit_:
return @RetVal    
go
grant all on SearchPriceCalc to public
go
exec setOV 'SearchPriceCalc', 'P', '20240603', '2'
go
