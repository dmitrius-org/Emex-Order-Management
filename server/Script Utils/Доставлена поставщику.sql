
select o.DeliveredDateToSupplier -- Доставлена поставщику
      ,p.OperDate
      ,*
  from tOrders o
 cross apply (
 select top 1 *
   from tProtocol p
  where p.ObjectID = o.OrderID
    and p.NewStateID in (6, 7)
    and isnull(p.OperDate, '') <> ''
    order by p.OperDate
) p
where o.DeliveredDateToSupplier is  null
and o.DetailNumber = '33449STD'


Update o
   set o.DeliveredDateToSupplier = p.OperDate
  from tOrders o
 cross apply (
 select top 1 *
   from tProtocol p
  where p.ObjectID = o.OrderID
    and p.NewStateID in (6, 7)
    and isnull(p.OperDate, '') <> ''
    order by p.OperDate
) p
where o.DeliveredDateToSupplier is  null

--and o.DetailNumber = '33449STD'


select  
      case 
         when datediff(dd, cast(getdate() as date), [DeliveryPlanDateSupplier]) > 0
         then datediff(dd, cast(getdate() as date), [DeliveryPlanDateSupplier])
         else 0
       end  [DeliveryRestTermSupplier] -- Остаток срока до поступления поставщику	
from tOrders
where DetailNumber = '33449STD'
--select *
--  from tNodes
    