select o.OrderDate, o.DestinationLogo, o.DestinationName, o.ProfilesDeliveryID, dp.Name, dp.DestinationLogo
  from tOrders o 
  left join tSupplierDeliveryProfiles dp
         on dp.ProfilesDeliveryID = o.ProfilesDeliveryID

where o.DestinationLogo is not null

order by o.OrderID desc



update o
set  o.DestinationName = dp.Name
  from tOrders o 
  inner join tSupplierDeliveryProfiles dp
         on dp.ProfilesDeliveryID = o.ProfilesDeliveryID
where o.DestinationLogo is not null





 