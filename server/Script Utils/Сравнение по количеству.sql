select count( m.OrderNumber) , count(o.EmexOrderID), count( m.OrderNumber) - count(o.EmexOrderID)
  from tMovement m (nolock)
left join tOrders o (nolock)
        on o.DetailNumber = m.DetailNum
	and o.CustomerSubId = m.CustomerSubId
	and o.Reference = m.Reference
 where 1=1--OrderID is null
 --and m.OrderNumber = '1759'





select m.OrderNumber,cast(m.OrderNumber as int),  m.OrderNumberC, o.OrderNumberC
from 
(
 select m.OrderNumber, count( m.OrderNumber)  OrderNumberC
   from tMovement m (nolock)
  where 1=1
  group by  m.OrderNumber
) m

left join (
select m.EmexOrderID OrderNumber, count( m.EmexOrderID)  OrderNumberC
   from tOrders m (nolock)
  where 1=1 --and EmexOrderID = '1760'
  group by  m.EmexOrderID

) o on 1=1
 
where o.OrderNumber = cast(m.OrderNumber as int)
and o.OrderNumberC <> m.OrderNumberC


order by o.OrderNumber desc
