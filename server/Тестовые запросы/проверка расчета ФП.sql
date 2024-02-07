

delete pOrdersFinIn from pOrdersFinIn where spid = @@Spid
--delete pOrdersFinTotal from pOrdersFinTotal where spid = @@Spid



insert pOrdersFinIn
      (Spid
      ,OrderID
      )
Select @@spid
      ,o.OrderID
  from tOrders o (nolock)
 where o.OrderID=8451

exec OrdersFinCalc
 



select 't.Orders',
       
	   Price          'Продажа'
	  ,CourseExt      'Курс с комиссией'
	  ,Purchase       'Закупка c комиссией' --	Доставка fkg с комиссией	Доставка vkg с комиссией	Доставка	Себестоимость	Комиссия от продажи	Наценка	Рентабельность	Доход %	Доход P
	  ,Deliveryfkg    'Доставка fkg с комиссией' 
	  ,Deliveryvkg    'Доставка vkg с комиссией'
      ,Delivery       'Доставка итого'
      ,CostPrice      'Себестоимость'
      ,PriceCommission        'Комиссия от продажи'


      ,MarginF       'НАЦЕНКА' 
      ,Profit        'РЕНТАБЕЛЬНОСТЬ*'
      ,IncomePrc     'ДОХОД %' 
      ,Income        'ДОХОД Р' 
  from pOrdersFin (nolock)
 where Spid = @@Spid

select 't.Orders'
      ,Price               'Продажа'
      ,WeightKG            'WeightKG'
      ,WeightKGF           'WeightKGF'   
      ,VolumeKG            'VolumeKG'
	  ,VolumeKGF            'VolumeKGF'
      ,PricePurchase       'PricePurchase'
  from pOrdersFin (nolock)
 where Spid = @@Spid

select 't.ProfilesCustomer'
      ,Margin     * 100 as 'Margin'
      ,Commission * 100 as 'Comission' 
      ,ExtraKurs  * 100 as 'ExtraKurs'
  from pOrdersFin (nolock)
 where Spid = @@Spid
 
select 't.ProfilesDelivery'
      ,PdWeightKG          'Стоимость PdWeightKG'
      ,PdVolumeKG          'Стоимость PdVolumeKG'
  from pOrdersFin (nolock)
 where Spid = @@Spid

select 't.Clients'
      ,Taxes      * 100 as 'Taxes'
      ,'%'
  from pOrdersFin (nolock)
 where Spid = @@Spid

select 't.CurrencyRate', Course     as 'Курс'
  from pOrdersFin (nolock)
 where Spid = @@Spid

