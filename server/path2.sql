--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1036, 1036, 'Хрупкое',  'TShipmentsT.actFrigileData', 63, 1

 alter table tOrders  add ItemKey	                     varchar(256)  null
 alter table tOrders  add Comment3                       varchar(512)  null -- Комментарий клиента к заказу