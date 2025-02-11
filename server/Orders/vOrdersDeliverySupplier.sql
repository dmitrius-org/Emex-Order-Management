if OBJECT_ID('vOrdersDeliverySupplier') is not null
    drop view vOrdersDeliverySupplier
go
/* **********************************************************
vOrdersDeliverySupplier - 
********************************************************** */
create view vOrdersDeliverySupplier
as

select o.OrderID
      ,o.ProfilesDeliveryID -- ссылка на профиль доставки
      ,o.ClientID
      ,coalesce(od.DeliveryPlanDateSupplier, o.DeliveryPlanDateSupplier) as DeliveryPlanDateSupplier     
      ,coalesce(od.DeliveryTermSupplier,     o.DeliveryTerm)             as DeliveryTermSupplier
      ,coalesce(od.DeliveryRestTermSupplier, o.DeliveryRestTermSupplier) as DeliveryRestTermSupplier
      ,coalesce(o.DeliveryNextDate2, o.DeliveryNextDate) as DeliveryNextDate
  from tOrders o with(nolock index=ao1)
  left join tOrdersDeliverySupplier od with (nolock index=PK_tOrdersDeliverySupplier_OrderID)
         on od.OrderID = o.OrderID   

go
grant all on vOrdersDeliverySupplier to public
go
exec setOV 'vOrdersDeliverySupplier', 'V', '20250211', '1'
go
Select * from vOrdersDeliverySupplier
