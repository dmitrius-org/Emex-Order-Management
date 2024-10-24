if OBJECT_ID('vCustomerUpdateOrders') is not null
    drop view vCustomerUpdateOrders
go
/* **********************************************************						
vCustomerUpdateOrders - 
********************************************************** */

create view vCustomerUpdateOrders
as

SELECT o.[OrderID]
      ,o.[Comment2]
  FROM [tOrders] o (nolock)

go
grant select, update on vCustomerUpdateOrders to public
go
exec setOV 'vCustomerUpdateOrders', 'V', '20241023', '1'
go

