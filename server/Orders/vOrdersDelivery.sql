if OBJECT_ID('vOrdersDelivery') is not null
    drop view vOrdersDelivery
go
/* **********************************************************						
vOrdersDelivery - 
********************************************************** */
create view vOrdersDelivery
as

select o.OrderID
      ,o.DeliveryPlanDateSupplier      
      ,o.DeliveryTermSupplier
      ,o.DeliveryRestTermSupplier
    --  ,o.DeliveredDateToSupplier

      --,o.DeliveryDateToCustomer
      --,o.DeliveryTermToCustomer
  from tOrdersDelivery o

go
grant all on vOrdersDelivery to public
go
exec setOV 'vOrdersDelivery', 'V', '20250204', '0'
go
Select * from vOrdersDelivery
