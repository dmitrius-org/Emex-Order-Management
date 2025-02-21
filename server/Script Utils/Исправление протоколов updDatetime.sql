

begin tran
Update o
   set o.updDatetime = p.InDateTime
  from tOrders o
 cross apply (select max(p.InDateTime) InDateTime
               from tProtocol p
              where p.ObjectID = o.OrderID
           
              ) as p


              commit tran