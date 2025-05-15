drop proc if exists OrdersCustomerDeliveryTermRecalc
/*
  OrdersCustomerDeliveryTermRecalc - Пересчет сроков доставки клиента (Дней в работе, Остаток срока до поставки клиенту)
                     
  Использую в автоматических заданиях для ежедневного пересчета
*/
go
create proc OrdersCustomerDeliveryTermRecalc
       
as
SET NOCOUNT ON;

declare @r int = 0

Update o
   set o.DeliveryTermToCustomer    = pc.DeliveryTermCustomer  -- Срок поставки клиенту
      ,o.DeliveryDateToCustomer    = iif(pc.DeliveryTermCustomer is not null, cast( dateadd(dd, pc.DeliveryTermCustomer, o.OrderDate) as date ), null)-- Дата поставки клиенту
	  ,o.DeliveryRestToCustomer    = pc.DeliveryTermCustomer  -- Остаток срока до поставки клиенту
	  ,o.DaysInWork                = 0
  from tOrders o (nolock)
 inner join vClientProfilesParam pc 
         on pc.ProfilesCustomerID = o.ProfilesCustomerID
 where o.DeliveryTermToCustomer is null

Update o
   set o.DaysInWork = DATEDIFF(dd, o.OrderDate, getdate()) -- Дней в работе
      ,o.DeliveryRestToCustomer  = odc.DeliveryTermToCustomer - DATEDIFF(dd, o.OrderDate, getdate())  -- Остаток срока до поставки клиенту
  from tOrders o (nolock)
 inner join vOrdersDeliveryCustomer odc 
         on odc.OrderID=o.OrderID 
 inner join tNodes n (nolock)
         on n.NodeID = o.StatusID
        and n.Flag&4>0 --Останавливаем счетчик когда статус переходит на Готовим к выдаче в РФ
 where isnull(o.isCancel, 0) = 0
   and o.DeliveryTermToCustomer is not null


-- Дней до крайней даты отгрузки со склада в ОАЭ
update o    
   set o.LastTermShipment = datediff(dd, getdate(), o.LastDateShipment) 
  from tOrders o with (nolock index=ao1)
 inner join tNodes n (nolock)
         on n.NodeID = o.StatusID
        and n.flag&32 > 0
 where o.isCancel = 0

 exit_:
 return @r
go
  grant exec on OrdersCustomerDeliveryTermRecalc to public
go
exec setOV 'OrdersCustomerDeliveryTermRecalc', 'P', '20250515', '5'
go
  

