if OBJECT_ID('CloneOrders') is not null
    drop proc CloneOrders
/*
  CloneOrders - 
*/
go

Create proc CloneOrders
              @N int -- номер обрабатываемой пачки в pMovement.N
as
 declare @r int = 0
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
      ,QuantityOrg
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
      ,ProfilesCustomerID
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
      ,Comment3
      ,itemKey
      ,DeliveryTermFromSupplier
      ,DeliveryTermFromSupplier2

      ,CustomerClientNum  
      ,CustomerClientSign 
      ,CustomerOrder      
	  ,ID)	 
       --                         o.OrderID                    p.ID
OUTPUT INSERTED.OrderID, INSERTED.ParentID, INSERTED.StatusID, INSERTED.ID
  INTO @ID (OrderID, ParentID, StateID, ID)
select o.ClientID
      ,o.OrderDate
      ,o.OrderNum
      ,o.StatusID -- проставляем состояние разбиваемого заказа, состояние измениться в процедуре синхронизации
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
      ,p.Quantity-- Quantity
      ,o.QuantityOrg
      ,o.Price
      ,p.Quantity * o.Price --Amount
      ,o.PricePurchase
      ,o.PricePurchaseOrg
      ,p.Quantity * o.PricePurchase -- AmountPurchase
      ,o.Discount
      ,o.PricePurchaseF
      ,p.Quantity * o.PricePurchaseF --AmountPurchaseF
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
      ,p.ReplacementMakeLogo-- ReplacementMakeLogo
      ,p.ReplacementDetailNumber-- ReplacementDetailNumber
      ,o.PriceID
      ,o.BasketId
      ,o.EmexOrderID
      ,o.CustomerSubId
      ,p.OrderDetailSubId-- OrderDetailSubId
      ,o.Reference
      ,o.EmexQuantity
      ,o.OverPricing
      ,o.Warning
      ,isnull(o.Flag, 0)|8 -- Запись добавлена в результате дробления заказа 
      ,dbo.GetUserID()
      ,isnull(o.inDatetime, GetDate())
      ,GetDate()
      ,p.PriceSale -- ReplacementPrice
      ,o.OrderID   -- ParentID
      ,o.Invoice
      ,o.FileDate      
      ,o.DestinationLogo
      ,o.DestinationName
      ,o.ProfilesCustomerID
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
      ,o.Fragile -- Наценка за страховку
      ,o.PercentSupped
      ,o.Comment2
      ,o.Comment3
      ,o.itemKey
      ,o.DeliveryTermFromSupplier
      ,o.DeliveryTermFromSupplier2
      ,o.CustomerClientNum  
      ,o.CustomerClientSign 
      ,o.CustomerOrder 
	  ,p.ID
  from pMovement p (nolock) -- тут детали, которые не найдены в нашей системе
 inner join tOrders o  (nolock)
         on o.OrderID   = p.OrderID
        and o.Quantity <> p.Quantity -- разбиваем если количество не совпадает
 inner join tNodes n (nolock)
         on n.EID = p.StatusId
where p.Spid = @@SPID
  and p.N    = @N
  and isnull(p.Flag, 0)&1 =0
order by p.DetailNum

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

-- сроки доставки поставщика
insert tOrdersDeliveryCustomer with (rowlock)
       (OrderID,
        DeliveryTermToCustomer,
        DeliveryDateToCustomer,
        DeliveryRestToCustomer)
select  i.OrderID
       ,ods.DeliveryTermToCustomer 
       ,ods.DeliveryDateToCustomer
       ,ods.DeliveryRestToCustomer
 from @ID i
inner join tOrdersDeliveryCustomer ods (nolock)
        on ods.OrderID = i.ParentID

-- меняем данные по заказу, который был разбит на части
Update o
   set o.Quantity       = (o.Quantity  - p.Quantity)
      ,o.Amount         = (o.Quantity  - p.Quantity) * o.Price  
	  ,o.AmountPurchase	= (o.Quantity  - p.Quantity) * o.PricePurchase
	  ,o.AmountPurchaseF= (o.Quantity  - p.Quantity) * o.PricePurchaseF
  from @ID i
 inner join tOrders o (updlock) 
         on o.OrderID = i.ParentID
 inner join pMovement p (nolock)
         on p.Spid    = @@Spid
		and p.OrderID = o.OrderID

-- проставляем новый ИД заказа
Update p
   set p.OrderID = i.OrderID
  from pMovement p (updlock)
 inner join @ID i
         on i.ID = p.ID
 where p.Spid = @@SPID

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

  exit_:

  return @r
GO
grant exec on CloneOrders to public
go
exec setOV 'CloneOrders', 'P', '20250408', '6'
go
 