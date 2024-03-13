if OBJECT_ID('CloneOrders2') is not null
    drop proc CloneOrders2
/*
  CloneOrders2 - 
*/
go

Create proc CloneOrders2
as
 declare @r int = 0
 declare @ID as table (OrderID  numeric(18, 0)
                      ,ParentID numeric(18, 0)
					  ,StateID  numeric(18, 0)
					  ,ID       numeric(18, 0)
					  )

INSERT INTO [tOrders]
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
      ,Commission-- Комиссия от продажи	 
      ,ClientOrderNum
      ,CommissionAmount
      ,Taxes
      ,WeightKGAmount
      ,VolumeKGAmount
      ,ExtraKurs
	  ,Reliability
	  ,ID)	  
OUTPUT INSERTED.OrderID, INSERTED.ParentID, INSERTED.StatusID, inserted.ID
  INTO  @ID (OrderID, ParentID, StateID, ID)
select o.ClientID
      ,o.OrderDate
      ,o.OrderNum
      ,o.StatusID -- проставляем состояние разбиваемого заказа, состояние измениться в процедуре синхронизации
      ,o.isCancel
      ,o.isCancelToClient
      ,o.Manufacturer
      ,o.CustomerPriceLogo
      ,o.PriceLogo
      ,o.DetailNumber
      ,o.DetailName
      ,o.MakeLogo
      ,o.DetailID
      ,p.Quantity-- o.Quantity
      ,o.Price
      ,p.Quantity * o.Price --o.Amount
      ,o.PricePurchase
      ,o.PricePurchaseOrg
      ,p.Quantity * o.PricePurchase -- o.AmountPurchase
      ,o.Discount
      ,o.PricePurchaseF
      ,p.Quantity * o.PricePurchaseF --o.AmountPurchaseF
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
      ,p.PriceSale-- o.ReplacementPrice
      ,o.OrderID
      ,o.Invoice
      ,o.FileDate      
      ,o.DestinationLogo
      ,o.Commission-- Комиссия от продажи	
      ,o.ClientOrderNum
      ,o.CommissionAmount
      ,o.Taxes
      ,o.WeightKGAmount
      ,o.VolumeKGAmount
      ,o.ExtraKurs
	  ,o.Reliability
	  ,p.ID
  from pMovement p (nolock)
 inner join pMovement pp (nolock)
         on pp.Spid          = @@Spid
		and pp.OrderNumber   = p.OrderNumber
		and pp.DetailNum     = p.DetailNum   
        and pp.CustomerSubId = p.CustomerSubId-- CustomerSubId для уникальности не хватает !!
		and pp.Reference     = p.Reference  
        and pp.N             = 1
        and pp.OrderID  is not null
 inner join tOrders o  (nolock)
         on o.OrderID = pp.OrderID
 inner join tNodes n (nolock)
         on n.EID = p.StatusId
where p.Spid    = @@SPID
  and p.OrderID is null
order by p.DetailNum

Update p
   set p.OrderID = i.OrderID
  from pMovement p (updlock)
 inner join @ID i
         on i.ID = p.ID
 --inner join tOrders o (nolock) 
 --        on o.OrderID = i.OrderID
 where p.Spid = @@SPID

--копирование протоколов для новых записей
insert tProtocol 
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

-- меняем данные по заказу, который был разбит на части
Update o
   set o.Quantity       = p.Quantity
      ,o.Amount         = p.Quantity * o.Price  
	  ,o.AmountPurchase	= p.Quantity * o.PricePurchase
	  ,o.AmountPurchaseF= p.Quantity * o.PricePurchaseF
  from @ID i
 inner join tOrders o (rowlock) 
         on o.OrderID = i.ParentID
 inner join pMovement p (nolock)
         on p.Spid    = @@Spid
		and p.OrderID = o.OrderID
  exit_:

  return @r
GO
grant exec on CloneOrders2 to public
go
exec setOV 'CloneOrders2', 'P', '20240101', '0'
go
 