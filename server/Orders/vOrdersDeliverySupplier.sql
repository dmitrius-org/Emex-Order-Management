if OBJECT_ID('vOrdersDeliverySupplier') is not null
    drop view vOrdersDeliverySupplier
go
/* **********************************************************						
vOrdersDeliverySupplier - 
********************************************************** */
create view vOrdersDeliverySupplier
as

select o.OrderID
      ,o.DeliveryPlanDateSupplier      
      ,o.DeliveryTermSupplier
      ,o.DeliveryRestTermSupplier
    --  ,o.DeliveredDateToSupplier

      --,o.DeliveryDateToCustomer
      --,o.DeliveryTermToCustomer
  from tOrdersDeliverySupplier o

go
grant all on vOrdersDeliverySupplier to public
go
exec setOV 'vOrdersDeliverySupplier', 'V', '20250204', '0'
go
Select * from vOrdersDeliverySupplier
