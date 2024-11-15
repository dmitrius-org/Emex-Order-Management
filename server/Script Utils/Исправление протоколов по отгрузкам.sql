 Select *
   from tShipments s (nolock)
cross apply (select top 1 * 
               from tShipmentsProtocol p (nolock)
              where p.ShipmentsID = s.ShipmentsID
                and p.NewStateID  = 24
             --   and p.InDateTime  = '20241114 11:30:50.903'
                and p.userID = 2

              order by p.ShipmentsProtocolID desc
              ) as p
  where s.StatusID=24


delete p
   from tShipments s (nolock)
cross apply (select top 1 * 
               from tShipmentsProtocol p (nolock)
              where p.ShipmentsID = s.ShipmentsID
                and p.NewStateID  = 24
                and p.InDateTime  ='20241114 11:30:50.903'
                and p.userID = 2

              order by p.ShipmentsProtocolID desc
              ) as p
  where s.StatusID=24



Update s
set s.StatusID = p.NewStateID
   from tShipments s (nolock)
outer apply (select top 1 * 
               from tShipmentsProtocol p (nolock)
              where p.ShipmentsID = s.ShipmentsID
              order by p.ShipmentsProtocolID desc
              ) as p
  where s.StatusID=24



  

select p.*
from tOrders o (nolock)
cross apply (select top 1 * 
               from tProtocol p (nolock)
              where p.ObjectID = o.OrderID
              and p.NewStateID  = 24
              and p.userID = 2
              and p.InDateTime  >= '20241114 11:30:52.060'
              order by p.ProtocolID desc
              ) as p
where o.StatusID=24
order by o.StatusID








delete p
from tOrders o (nolock)
cross apply (select top 1 * 
               from tProtocol p (nolock)
              where p.ObjectID = o.OrderID
              and p.NewStateID  = 24
              and p.userID = 2
              and p.InDateTime  = '2024-11-14 11:30:52.060'
              order by p.ProtocolID desc
              ) as p
where o.StatusID=24




Update o
set StatusID = p.NewStateID
from tOrders o (nolock)
cross apply (select top 1 * 
               from tProtocol p (nolock)
              where p.ObjectID = o.OrderID
              order by p.ProtocolID desc
              ) as p
where o.StatusID <> p.NewStateID

*/

select *
from tOrders o (nolock)
cross apply (select top 1 * 
               from tProtocol p (nolock)
              where p.ObjectID = o.OrderID
              order by p.ProtocolID desc
              ) as p
where o.StatusID <> p.NewStateID
