alter table tProtocol add Flag int
go
alter table tAudit add Flag int

go
Update p
set p.flag = 1
 from tOrders o
 inner join tProtocol p 
         on p.ObjectID = o.OrderID
         and p.NewStateID = 22
 where o.flag&16>0



 go

 alter table tOrders add Fragile                         float  
 go
 alter table hOrders add Fragile                         float    
 go
 alter table tBasket add Fragile                 money 

