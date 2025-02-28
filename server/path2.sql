--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1028, 1028, 'Коробки',  'TShipmentsT.actShipmentsBoxes', 63, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1031, 1031, 'Проставить признак: Обращение открыто',  'TOrdersT.actRequestOpen', 20, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1033, 1033, 'Протокол детали',  'TOrdersT.actPartProtocol', 20, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1034, 1034, 'Уточнить срок поставки',  'TOrdersT.actSupplierSpecifyDeliveryTime', 20, 1
--alter table tOrders add Box numeric(18, 0)

--alter table tSettings add Properties varchar(256)

--Update o
--   set o.box = SUBSTRING(p.Comment, CHARINDEX('box:', p.Comment) + LEN('box:'), LEN(p.Comment))
--from tOrders o
--inner join tProtocol p 
--       on p.ObjectID = o.OrderID
--      and p.NewStateID = 8 

alter table tBasket add ProfilesCustomerID  numeric(18, 0)  
alter table tOrders add ProfilesCustomerID  numeric(18, 0)  
alter table pFindByNumber add ProfilesCustomerID  numeric(18, 0)  
alter table tPrice add NLA  bit            -- No longer available или Более недоступно
alter table History.tPartsHistory add NLA  bit     

drop index ao1 on tSupplierDeliveryProfiles
create index ao1 on tSupplierDeliveryProfiles(SuppliersID, DestinationLogo);


Update o
set o.ProfilesCustomerID = pc.ProfilesCustomerID
  from tOrders o
  inner join tProfilesCustomer pc on  pc.ProfilesDeliveryID = o.ProfilesDeliveryID
 where isnull(o.ProfilesCustomerID, 0)= 0


 --Select o.DestinationLogo, o.ProfilesDeliveryID, *
 -- from tOrders o
 --where isnull(o.ProfilesCustomerID, 0)= 0
 --order by OrderDate desc

 --select * from tNodes where NodeID=12
 --select * 
 --from tSupplierDeliveryProfiles
 --where ProfilesDeliveryID = 7