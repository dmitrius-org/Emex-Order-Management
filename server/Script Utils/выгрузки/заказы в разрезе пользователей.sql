


--select * from pFindByNumber

--select * from tBasket 

--select * from tOrders where ClientID = 31


--update tBasket 
--set InDateTime = '20240615'



--Select * from tNodes


select p.InDate, p.Brief, p.UCount 'Количество обработанных',  (Select count(*) from tOrders oo where cast(oo.inDatetime as date) = p.InDate) 'Всего заказов'
from (


select cast(p.InDateTime as date) as InDate, u.Brief, Count( u.Brief) UCount
  from tProtocol p 
 inner join tUser u
         on u.UserID = p.UserID 
 inner join tOrders o 
         on o.OrderID = p.ObjectID 
 where p.StateID    = 1
   and p.NewStateID = 2
   and p.InDateTime >= '20240601'
group by u.Brief, cast(p.InDateTime as date)

) as p
--where p.Brief in ('pp1', 'pp2', 'pp3')
order by p.InDate, p.Brief
