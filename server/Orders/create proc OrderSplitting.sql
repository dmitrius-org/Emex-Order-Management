if OBJECT_ID('OrderSplitting') is not null
    drop proc OrderSplitting
go
/*
  OrderSplitting - 
*/
Create proc OrderSplitting
              @OrderID     numeric(18, 0)
             --,@StateID  numeric(18, 0)
             ,@Quantity    int
             ,@NewOrderID  numeric(18, 0)  = null out

as
 declare @r int = 0
        ,@AuditComment nvarchar(256)
        ,@AuditID      numeric(18,0)

 declare @ID as table (OrderID  numeric(18, 0)
                      ,ParentID numeric(18, 0) -- OrderID
                      ,StateID  numeric(18, 0)
                      ,ID       numeric(18, 0)
                      )

INSERT INTO [tOrders] with (rowlock)
      (
       ClientID
      ,OrderDate
      ,OrderNum
      ,StatusID
      ,isCancel
      ,isCancelToClient
      ,Manufacturer
      ,CustomerPriceLogo
      ,PriceLogo
      ,PriceLogoOrg
      ,DetailNumber
      ,DetailName
      ,MakeLogo
      ,DetailID
      ,Quantity
      ,Price
      ,Amount
      ,PricePurchase
      ,PricePurchaseOrg
      ,AmountPurchase
      ,Discount
      ,PricePurchaseF
      ,AmountPurchaseF
      ,WeightKG
      ,VolumeKG
      ,Margin
      ,MarginF
      ,Profit
      ,Income
      ,IncomePRC -- Доход %    
      ,DeliveryPlanDateSupplier
      ,DeliveryRestTermSupplier
      ,DeliveredDateToSupplier
      ,ProfilesDeliveryID
      ,DeliveryDaysReserve
      ,DeliveryNextDate
      ,DeliveryNextDate2
      ,DeliveryDateToCustomer
      ,DeliveryTermToCustomer
      ,DeliveryRestToCustomer
      ,ReplacementMakeLogo
      ,ReplacementDetailNumber
      ,PriceID
      ,BasketId
      ,EmexOrderID
      ,CustomerSubId
      ,OrderDetailSubId
      ,Reference
      ,EmexQuantity
      ,OverPricing
      ,Warning
      ,Flag
      ,UserID
      ,inDatetime
      ,updDatetime
      ,ReplacementPrice
      ,ParentID
      ,Invoice
      ,FileDate      
      ,DestinationLogo
      ,DestinationName
      ,Commission-- Комиссия от продажи     
      ,ClientOrderNum
      ,CommissionAmount
      ,Taxes
      ,WeightKGAmount
      ,VolumeKGAmount
      ,ExtraKurs
      ,Reliability
      ,DateDeparture
      ,DaysInWork  
      ,DeliveryTerm
      ,SuppliersID
      ,Kurs
      ,Fragile
      ,PercentSupped
      ,Comment2   
      ,ID)     
       --                         o.OrderID                  
OUTPUT INSERTED.OrderID, INSERTED.ParentID, INSERTED.StatusID
  INTO @ID (OrderID, ParentID, StateID)
select o.ClientID
      ,o.OrderDate
      ,o.OrderNum
      ,o.StatusID
      ,o.isCancel
      ,o.isCancelToClient
      ,o.Manufacturer
      ,o.CustomerPriceLogo
      ,o.PriceLogo
      ,o.PriceLogoOrg
      ,o.DetailNumber
      ,o.DetailName
      ,o.MakeLogo
      ,o.DetailID
      ,@Quantity-- Quantity
      ,o.Price
      ,@Quantity * o.Price --Amount
      ,o.PricePurchase
      ,o.PricePurchaseOrg
      ,@Quantity * o.PricePurchase -- AmountPurchase
      ,o.Discount
      ,o.PricePurchaseF
      ,@Quantity * o.PricePurchaseF --AmountPurchaseF
      ,o.WeightKG
      ,o.VolumeKG
      ,o.Margin
      ,o.MarginF
      ,o.Profit
      ,o.Income
      ,o.IncomePRC
      ,o.DeliveryPlanDateSupplier
      ,o.DeliveryRestTermSupplier
      ,o.DeliveredDateToSupplier
      ,o.ProfilesDeliveryID
      ,o.DeliveryDaysReserve
      ,o.DeliveryNextDate
      ,o.DeliveryNextDate2
      ,o.DeliveryDateToCustomer
      ,o.DeliveryTermToCustomer
      ,o.DeliveryRestToCustomer
      ,o.ReplacementMakeLogo-- ReplacementMakeLogo
      ,o.ReplacementDetailNumber-- ReplacementDetailNumber
      ,o.PriceID
      ,o.BasketId
      ,o.EmexOrderID
      ,o.CustomerSubId
      ,o.OrderDetailSubId-- OrderDetailSubId
      ,o.Reference
      ,o.EmexQuantity
      ,o.OverPricing
      ,o.Warning
      ,isnull(o.Flag, 0)| 524288 -- деталь разделена на части менеджером
      ,dbo.GetUserID()
      ,isnull(o.inDatetime, GetDate())
      ,GetDate()
      ,o.ReplacementPrice -- ReplacementPrice
      ,o.OrderID   -- ParentID
      ,o.Invoice
      ,o.FileDate      
      ,o.DestinationLogo
      ,o.DestinationName
      ,o.Commission-- Комиссия от продажи    
      ,o.ClientOrderNum
      ,o.CommissionAmount
      ,o.Taxes
      ,o.WeightKGAmount
      ,o.VolumeKGAmount
      ,o.ExtraKurs
      ,o.Reliability
      ,o.DateDeparture
      ,o.DaysInWork   
      ,o.DeliveryTerm
      ,o.SuppliersID
      ,o.Kurs
      ,o.Fragile -- Наценка за страховку tSupplierDeliveryProfiles.Fragile
      ,o.PercentSupped
      ,o.Comment2    
      ,null
  from tOrders o  with (nolock index=ao1)
 where o.OrderID = @OrderID

Select @NewOrderID = max(OrderID)
  from @ID

-- сроки доставки поставщика
insert tOrdersDeliverySupplier with (rowlock)
       (OrderID,
        DeliveryPlanDateSupplier,
        DeliveryTermSupplier,
        DeliveryRestTermSupplier)
select  i.OrderID
       ,ods.DeliveryPlanDateSupplier 
       ,ods.DeliveryTermSupplier
       ,ods.DeliveryRestTermSupplier
 from @ID i
inner join tOrdersDeliverySupplier ods (nolock)
        on ods.OrderID = i.ParentID


-- меняем данные по заказу, который был разбит на части
Update o
   set o.Quantity       = (o.Quantity  - @Quantity)
      ,o.Amount         = (o.Quantity  - @Quantity) * o.Price  
      ,o.AmountPurchase = (o.Quantity  - @Quantity) * o.PricePurchase
      ,o.AmountPurchaseF= (o.Quantity  - @Quantity) * o.PricePurchaseF
      ,o.Flag           = isnull(o.Flag, 0)| 524288 
  from tOrders o (updlock) 
 where o.OrderID = @OrderID

--копирование протоколов для новых записей
insert tProtocol with (rowlock)
      (ObjectID
      ,StateID
      ,NewStateID
      ,ActionID
      ,OperDate
      ,Comment
      ,UserID
      ,InDateTime)
Select i.OrderID
      ,p.StateID
      ,p.NewStateID
      ,p.ActionID
      ,p.OperDate
      ,p.Comment
      ,p.UserID
      ,p.InDateTime
  from @ID i
 inner join tProtocol p (nolock)
         on p.ObjectID=i.ParentID
 order by p.ProtocolID

  select @AuditComment =  'Добавлен в результате разделения заказа'


  -- аудит
  exec AuditInsert
         @AuditID          = @AuditID out         
        ,@ObjectID         = @NewOrderID
        ,@ObjectTypeID     = 3
        ,@ActionID         = 2 -- ИД выполняемое дейстие из tAction
        ,@Comment          = @AuditComment

  exit_:

  return @r
GO
grant exec on OrderSplitting to public
go
exec setOV 'OrderSplitting', 'P', '20250206', '1'
go
 