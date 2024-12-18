if OBJECT_ID('OrderF_OrdersFinCalc') is not null
    drop proc OrderF_OrdersFinCalc
/*
  OrderF_OrdersFinCalc - расчет финансовых показателей для формы изменения данных заказа

  Результат расчета:     pOrdersFin
*/
go
create proc OrderF_OrdersFinCalc
              @OrderID   numeric(18, 0)  
             ,@WeightKGF float = null -- Вес Физический факт	
             ,@VolumeKGF float = null -- Вес Объемный факт
as
declare @r int = 0


select @WeightKGF=nullif(@WeightKGF, 0)
      ,@VolumeKGF=nullif(@VolumeKGF, 0)

delete pOrdersFin from pOrdersFin (rowlock) where spid = @@Spid
insert pOrdersFin with (rowlock)
      (Spid
      ,ID
      ,OrderDate
      ,ClientID
      ,Price  -- продажа
      ,PricePurchase
      ,WeightKG
      ,VolumeKG
      ,WeightKGF
      ,VolumeKGF
      ,Taxes
      ,Commission
      ,Margin
      ,Course
      ,ExtraKurs
      ,PdWeightKG
      ,PdVolumeKG
      ,PriceCommission -- Комиссия от продажи
      )
Select @@spid
      ,p.ID
      ,cast(getdate() as date)-- курс берем на текущую дату
      ,p.ClientID
      ,o.Price -- цена продажи в рублях c заказа
      ,p.Price -- цена закупки в долларах из АПИ
      ,isnull(o.WeightKG,  0)
      ,isnull(o.VolumeKG , 0)
      ,coalesce(@WeightKGF, p.WeightGr,  0)
      ,coalesce(@VolumeKGF, p.VolumeAdd, 0)
      ,c.Taxes    -- Комиссия + Налоги
      ,isnull(p.Commission, 0)/100 -- Комиссия за оплату  Comission ExtraKurs
      ,isnull(p.Margin, 0)/100     -- Наценка             Margin
      ,isnull(p.Kurs, o.Kurs)
      ,isnull(p.ExtraKurs, 0)/100  -- Комиссия на курс    ExtraKurs
      ,pd.WeightKG                 -- Стоимость кг
      ,pd.VolumeKG                 -- Стоимость vкг
      ,o.CommissionAmount          -- Комиссия от продажи
  from pFindByNumber p with (nolock index=ao2)
 inner join tOrders o with (nolock index=ao1)
         on o.OrderID   = @OrderID
 inner join tClients c with (nolock index=ao1)
         on c.ClientID  = o.ClientID
 outer apply ( -- для клиентов работающих через файл, профилей может быть несколько
        select top 1
                --pd.DestinationLogo, 
                --pd.Name,

                pd.WeightKG,
                pd.VolumeKG
	            --pd.ProfilesDeliveryID,
	            --pd.Delivery,

                --pc.Margin,
                --pc.Reliability,

                --pd.VolumeKG_Rate1,
                --pd.VolumeKG_Rate2,
                --pd.VolumeKG_Rate3,
                --pd.VolumeKG_Rate4,
                --pd.Fragile

        from tProfilesCustomer pc with (nolock)
        left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
                on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
        where pc.ClientID = c.ClientID
          and pd.DestinationLogo    = p.DestinationLogo   
        ) as pd
  where p.spid = @@spid

  exec OrdersFinCalc
         @IsSave   = 0,
         @IsFilled = 1


Update p
   set p.OurDelivery    = pd.DeliveryTermCustomer
      ,p.OurDeliverySTR = cast(pd.DeliveryTermCustomer as varchar)
  from tOrders o with (nolock index=ao1)
 inner join pFindByNumber p with (updlock index=ao2) 
         on p.spid = @@spid
  --inner join tClients c with (nolock index=ao1)
  --        on c.ClientID  = o.ClientID
 outer apply ( -- для клиентов работающих через файл, профилей может быть несколько
        select top 1
               pc.DeliveryTermCustomer
          from tProfilesCustomer pc with (nolock)
          left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
                 on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
         where pc.ClientID        = o.ClientID
           and pd.DestinationLogo = p.DestinationLogo   
        ) as pd
 where o.OrderID   = @OrderID
   and o.Flag&16=0
 
 exit_:
 return @r
go
  grant exec on OrderF_OrdersFinCalc to public
go
exec setOV 'OrderF_OrdersFinCalc', 'P', '20241206', '6'
go
 
 