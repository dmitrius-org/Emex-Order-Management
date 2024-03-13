if OBJECT_ID('CustomerPriceCalc', 'P') is not null
    drop proc CustomerPriceCalc	 
go
/* --------------------------------------------------------
  CustomerPriceCalc - расчет цены 
-------------------------------------------------------- */
create proc CustomerPriceCalc
              @DestinationLogo	nvarchar(20)
as
set nocount on;

declare @Kurs		  float
	   ,@RetVal       int

-- курс доллара
select @Kurs = dbo.GetCurrencyRate('840', null)

if OBJECT_ID('tempdb..#Price') is not null drop table #Price

create table #Price 
(
 ID                numeric(18,0)  --  
,Brand             varchar(60)    --
,DetailNum	       varchar(30)    -- Номер детали 
,DetailPrice       float          -- Цена
,FinalPrice        float          -- Цена
,DetailName	       varchar(255)   -- Название
,PriceLogo         varchar(30)    -- Название прайса 
,Quantity          int            -- Количество
,PackQuantity      int            -- Количество в упаковке

,WeightKG          float          -- Вес физический кг 
,VolumeKG          float          -- Вес объемный кг  

,TPrice            float          -- тип цены, например: MOSA, MOSC, KIRG
,TDel              float          -- номинал стоимости за доставку
,TDetPrice         float          -- номинал цены детали со скидкой
,TCom              float          -- номинал комиссии 
,TMarg             float          -- номинал наценки на товар
,TFinPrice         float
,Term              int            -- срок доставки
,TFinPriceKurs     money

,DestinationLogo   nvarchar(10)

,Margin		       float
,Kurs		       float
,ExtraKurs         float
,Commission	       float  -- Комиссия эквайера
,Discount	       float  -- Скидка
,Reliability       float  -- Вероятность поставки
,PDWeightKG	       float
,PDVolumeKG        float

,RetVal            int
)

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
	   p.WeightGr/1000,--
	   p.VolumeAdd 
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
       pd.DestinationLogo
  from pFindByNumber p (rowlock)
 --inner join tClients c (nolock)
 --        on c.ClientID = p.ClientID
 inner join tProfilesCustomer pc (nolock)
         on pc.ClientID = p.ClientID

 inner join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
        and pd.DestinationLogo    = @DestinationLogo
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
   set f.PriceRub        = p.FinalPrice
      ,f.Margin          = p.Margin
      ,f.Discount        = p.Discount
      ,f.DestinationLogo = p.DestinationLogo
  from #Price p (rowlock)
 inner join pFindByNumber f (updlock)
         on f.Spid = @@Spid
        and f.ID   = p.ID
 --*/


exit_:
return @RetVal    
go
grant all on CustomerPriceCalc to public
go
exec setOV 'CustomerPriceCalc', 'P', '20240101', '0'
go
