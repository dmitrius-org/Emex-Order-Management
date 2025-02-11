if OBJECT_ID('vOrdersDeliveryCustomer') is not null
    drop view vOrdersDeliveryCustomer
go
/* **********************************************************
vOrdersDeliveryCustomer - 
********************************************************** */
create view vOrdersDeliveryCustomer
as

select o.OrderID
      --,o.ProfilesDeliveryID -- ссылка на профиль доставки
      ,o.ClientID
      ,coalesce(od.DeliveryTermToCustomer, o.DeliveryTermToCustomer) as DeliveryTermToCustomer     
      ,coalesce(od.DeliveryDateToCustomer, o.DeliveryDateToCustomer) as DeliveryDateToCustomer
      ,coalesce(od.DeliveryRestToCustomer, o.DeliveryRestToCustomer) as DeliveryRestToCustomer
  from tOrders o with(nolock index=ao1)
  left join tOrdersDeliveryCustomer od with (nolock index=PK_tOrdersDeliveryCustomer_OrderID)
         on od.OrderID = o.OrderID   

go
grant all on vOrdersDeliveryCustomer to public
go
exec setOV 'vOrdersDeliveryCustomer', 'V', '20250211', '1'
go
Select * from vOrdersDeliveryCustomer
