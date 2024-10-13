
/*
select top 500
       DeliveryDateToCustomer, 
       DeliveryTermToCustomer,
       DeliveryRestToCustomer,
       *
  from vOrders



select o.OrderDate, o.DestinationLogo, o.DestinationName, o.ProfilesDeliveryID, dp.Name, o.DeliveryDateToCustomer, o.DetailNumber, o.*
  from tOrders o 
  left join tSupplierDeliveryProfiles dp
         on dp.ProfilesDeliveryID = o.ProfilesDeliveryID

where o.DeliveryDateToCustomer is not null

order by o.OrderID desc



update o
set  o.DestinationName = dp.Name
  from tOrders o 
  inner join tSupplierDeliveryProfiles dp
         on dp.ProfilesDeliveryID = o.ProfilesDeliveryID
where o.DestinationLogo is not null

*/

delete
  from tOrders 
where  OrderDate = '20241011'