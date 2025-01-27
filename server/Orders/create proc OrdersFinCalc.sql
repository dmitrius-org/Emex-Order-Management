if OBJECT_ID('OrdersFinCalc') is not null
    drop proc OrdersFinCalc
/*
  OrdersFinCalc - расчет финансовых показателей

  @IsSave - сохраняет данные в tOrders
            0 - нет (по умолчанию)
            1 - да
  @IsFilled - данные для расчета уже заполнены
            0 - нет (по умолчанию)
            1 - да
  Входящий набор данных: pOrdersFinIn
  Результат расчета:     pOrdersFin
*/
go
create proc OrdersFinCalc
              @IsSave   bit = null,
              @IsFilled bit = null            
as
declare @r int = 0

select @IsFilled     = isnull(@IsFilled, 0)

if @IsFilled  = 0
begin
  delete pOrdersFin from pOrdersFin (rowlock) where spid = @@Spid

  insert pOrdersFin with (rowlock) -- Данные с заказа
        (Spid
        ,OrderID
        ,OrderDate
        ,Price  -- продажа
        ,PricePurchase
        ,WeightKG   
        ,VolumeKG 
        ,WeightKGF
        ,VolumeKGF
        ,Taxes
        ,Commission
        ,Margin     
        ,ExtraKurs  
        ,PdWeightKG 
        ,PdVolumeKG 
        ,PriceCommission -- Комиссия от продажи	
        )
  Select @@spid
        ,o.OrderID
        ,o.OrderDate
        ,o.Price                  -- цена продажи в рублях
        ,coalesce(nullif(o.PricePurchaseF, 0), nullif(o.ReplacementPrice, 0), o.PricePurchase) -- цена закупки в долларах
        ,isnull(o.WeightKG,  0)
        ,isnull(o.VolumeKG , 0)
        ,isnull(p.WeightKGF, 0)
        ,isnull(p.VolumeKGF, 0)
        ,isnull(o.Taxes, c.Taxes)            -- Комиссия + Налоги
        ,isnull(o.Commission, 0)/100         -- Комиссия за оплату  Comission ExtraKurs
        ,isnull(o.Margin, 0)/100             -- Наценка             Margin
        ,isnull(o.ExtraKurs, 0)/100          -- Комиссия на курс    ExtraKurs
        ,isnull(o.WeightKGAmount, pd.WeightKG)              -- Стоимость кг	
        ,isnull(o.VolumeKGAmount, pd.VolumeKG)              -- Стоимость vкг
        ,o.CommissionAmount       -- Комиссия от продажи	 
    from pOrdersFinIn i (nolock)
   inner join tOrders o (nolock)
           on o.OrderID = i.OrderID
   inner join tClients c (nolock)
           on c.ClientID = o.ClientID
   inner join tSupplierDeliveryProfiles pd (nolock)
           on pd.ProfilesDeliveryID = o.ProfilesDeliveryID
    left join tPrice p (nolock)
           on p.PriceID = o.PriceID
   where i.Spid = @@Spid
end

Update p
   set p.Course    = c.Value
      ,p.CourseExt = c.Value + (c.Value * p.ExtraKurs)
  from pOrdersFin p
 cross apply ( select top 1 Value
                 from tCurrencyRate with (nolock index=ao2)
                where NumCode = '840'
  		          and OnDate <= getdate()--p.OrderDate
  		        order by OnDate desc) c
 where p.Spid = @@Spid
 
Update p -- Закупка c комиссией	
   set p.Purchase = p.PricePurchase + (p.PricePurchase*p.Commission)
  from pOrdersFin p
 where p.Spid = @@Spid

--Доставка fkg с комиссией План
--=t.Orders.WeightKG*(t.ProfilesDelivery.WeightKGF+(t.ProfilesDelivery.WeightKGF*t.ProfilesCustomer.Comission))
Update pOrdersFin
   set Deliveryfkg= WeightKG * ( PdWeightKG + (  PdWeightKG * Commission) )
 where Spid = @@Spid

--Доставка fkg с комиссией Факт
--=if(OR(t.Orders.WeightKGF=0,t.Orders.WeightKGF=""),t.Orders.WeightKG,t.Orders.WeightKGF)*(t.ProfilesDelivery.WeightKGF+(t.ProfilesDelivery.WeightKGF*t.ProfilesCustomer.Comission))
Update pOrdersFin
   set DeliveryfkgF= isnull(nullif(WeightKGF, 0), WeightKG) * (PdWeightKG + (PdWeightKG*Commission))
 where Spid = @@Spid

--Доставка vkg с комиссией План
--=IF( L6<I6, 0, (  L6-( IF(OR(K6<>"",K6<>0), K6, I6) )  )*( I12+(I12*E9) ) )
Update pOrdersFin --
   set Deliveryvkg = case 
                       when VolumeKG<WeightKG
                       then 0
                       else VolumeKG - iif( isnull(WeightKGF, 0) <> 0, WeightKGF, WeightKG ) 
                     end * (PdVolumeKG + (PdVolumeKG*Commission))
 where Spid = @@Spid

--Доставка vkg с комиссией Факт
Update pOrdersFin --
   set DeliveryvkgF = case 
                       when isnull(VolumeKGF, 0) = 0
                       then iif(VolumeKG>WeightKGF, VolumeKG-WeightKG, 0)
                       else VolumeKGF - isnull(nullif(WeightKGF, 0), WeightKG) 
                     end * (PdVolumeKG + (PdVolumeKG*Commission))
 where Spid = @@Spid

Update pOrdersFin --
   set DeliveryvkgF = iif(isnull(DeliveryvkgF, 0) < 0, 0, DeliveryvkgF) 
 where Spid = @@Spid
--Доставка План	
Update pOrdersFin 
   set Delivery = Deliveryfkg + Deliveryvkg
 where Spid = @@Spid

--Доставка Факт
Update pOrdersFin 
   set DeliveryF = isnull(DeliveryfkgF, 0) + isnull(DeliveryvkgF, 0)
 where Spid = @@Spid

Update pOrdersFin --Себестоимость	
   set CostPrice = Purchase + DeliveryF
 where Spid = @@Spid

Update pOrdersFin --	
   set Purchase    = Purchase    * CourseExt -- Закупка c комиссией
      ,Deliveryfkg = Deliveryfkg * CourseExt -- Доставка fkg с комиссией
      ,DeliveryfkgF= DeliveryfkgF* CourseExt -- Доставка fkg с комиссией Факт
      ,Deliveryvkg = Deliveryvkg * CourseExt -- Доставка fkg с комиссией
      ,DeliveryvkgF= DeliveryvkgF* CourseExt -- Доставка vkg с комиссией Факт 
      ,Delivery    = Delivery    * CourseExt -- Доставка
      ,DeliveryF   = DeliveryF   * CourseExt -- Доставка
      ,CostPrice   = CostPrice   * CourseExt -- Себестоимость
 where Spid = @@Spid

--=(Продажа*t.Clients.Taxes)-G3*t.Clients.Taxes
Update pOrdersFin --Комиссия от продажи	
   set PriceCommission = Price * Taxes -  DeliveryF * Taxes
 where Spid = @@Spid
   and PriceCommission is null
 
--=((Продажа-Доставка)/Закупка)-1
Update pOrdersFin --Наценка	 
   set MarginF    = (((Price - DeliveryF)/Purchase) - 1)*100
 where Spid = @@Spid

--=Продажа-Комиссия-Себестоимость
Update pOrdersFin --Доход	  
   set Income    = (Price-PriceCommission-CostPrice)
 where Spid = @@Spid

--=Доход/Себестоимость
Update pOrdersFin --Доход %	  
   set IncomePrc    = (Income/CostPrice)*100
 where Spid = @@Spid
 
--=Доход/Продажа
Update pOrdersFin --Рентабельность	
   set Profit    = (Income/Price)*100
 where Spid = @@Spid

if isnull(@IsSave, 0) = 1
begin
  Update o
     set o.MarginF          = p.MarginF    -- маржа факт
        ,o.Income           = p.Income	   -- доход
		,o.IncomePrc        = p.IncomePrc  -- доход в процентах
        ,o.Profit           = p.Profit     -- Рентабельность
        ,o.CommissionAmount = isnull(o.CommissionAmount, p.PriceCommission) -- Комиссия от продажи

        --,o.Kurs             = p.Course     -- курс
        --,o.ExtraKurs        = p.ExtraKurs
    from pOrdersFin p (nolock)
   inner join tOrders o with (updlock)
           on o.OrderID = p.OrderID
   where p.Spid = @@Spid
end

--select Tax, Income, ExtraCharge, Profitability, '|', Purchase, Deliveryfkg, Deliveryvkg, Delivery, CostPrice, '|', * 
--  from pOrdersFin (nolock)
-- where Spid = @@Spid

 exit_:
 return @r
go
  grant exec on OrdersFinCalc to public
go
exec setOV 'OrdersFinCalc', 'P', '20241212', '6'
go
 
 