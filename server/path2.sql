--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1036, 1036, 'Хрупкое',  'TShipmentsT.actFrigileData', 63, 1

 alter table tOrders  add ItemKey	                     varchar(256)  null
 alter table tOrders  add Comment3                       varchar(512)  null -- Комментарий клиента к заказу


 alter table tOrders  add
     DeliveryTermFromSupplier        int            -- Срок доставки от поставщик
    ,DeliveryTermFromSupplier2       int            -- Срок доставки от поставщик после изменения
update o
   set o.DeliveryTermFromSupplier = null
  from tOrders o

    /*
update o
   set o.DeliveryTermFromSupplier = sp.Delivery
  from tOrders o
 inner join tSupplierDeliveryProfiles sp
         on sp.ProfilesDeliveryID  = o.ProfilesDeliveryID 
 where o.DeliveryTermFromSupplier is null

 update o
   set o.DeliveryTermFromSupplier = sp.DeliveryTermFromSupplier
      ,o.ProfilesDeliveryID       = sp.ProfilesDeliveryID
  from tOrders o
 inner join vClientProfilesParam sp
         on sp.ProfilesCustomerID  = o.ProfilesCustomerID 
 where o.DeliveryTermFromSupplier is null

*/








Select o.DeliveryTermFromSupplier, o.*, sp.*
from tOrders o
left join tSupplierDeliveryProfiles sp
        on sp.ProfilesDeliveryID  = o.ProfilesDeliveryID 
where o.ProfilesDeliveryID = 0
--and o.DeliveryTermFromSupplier is null
order by o.OrderDate desc