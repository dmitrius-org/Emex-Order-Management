drop proc if exists OrdersCustomerDeliveryTermRecalc
/*
  OrdersCustomerDeliveryTermRecalc - расчет сроков доставки клиента :
                     

*/
go
create proc OrdersCustomerDeliveryTermRecalc
       
as
SET NOCOUNT ON;
SET DATEFIRST 1 ;  

declare @r int = 0

Update o
   set o.DeliveryTermToCustomer    = pc.DeliveryTermCustomer  -- Срок поставки клиенту
      ,o.DeliveryDateToCustomer    = iif(pc.DeliveryTermCustomer is not null, cast( dateadd(dd, pc.DeliveryTermCustomer, o.OrderDate) as date ), null)-- Дата поставки клиенту
	  ,o.DeliveryRestToCustomer    = pc.DeliveryTermCustomer  -- Остаток срока до поставки клиенту
	  ,o.DaysInWork                = 0
  from tOrders o (nolock)
 inner join tProfilesCustomer pc with (nolock index=PK_tProfilesCustomer_ProfilesCustomerID)
         on pc.ProfilesCustomerID = o.ProfilesCustomerID
 where o.DeliveryTermToCustomer is null


Update o
   set o.DaysInWork = DATEDIFF(dd, o.OrderDate, getdate())  --Дней в работе
      ,o.DeliveryRestToCustomer    = o.DeliveryTermToCustomer - DATEDIFF(dd, o.OrderDate, getdate())  -- Остаток срока до поставки клиенту
  from tOrders o (nolock)
 inner join tNodes n (nolock)
         on n.NodeID = o.StatusID
        and n.Flag&4>0 --Останавливаем счетчик когда статус переходит на Готовим к выдаче в РФ
 where isnull(o.isCancel, 0) = 0
   and o.DeliveryTermToCustomer is not null

  
 exit_:

 return @r
go
  grant exec on OrdersCustomerDeliveryTermRecalc to public
go
exec setOV 'OrdersCustomerDeliveryTermRecalc', 'P', '20250227', '3'
go
  

