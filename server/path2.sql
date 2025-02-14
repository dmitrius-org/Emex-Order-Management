insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1028, 1028, 'Коробки',  'TShipmentsT.actShipmentsBoxes', 63, 1


alter table tOrders add Box numeric(18, 0)




Update o
   set o.box = SUBSTRING(p.Comment, CHARINDEX('box:', p.Comment) + LEN('box:'), LEN(p.Comment))
from tOrders o
inner join tProtocol p 
       on p.ObjectID = o.OrderID
      and p.NewStateID = 8 
