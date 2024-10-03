  begin tran
  --rollback tran
  commit tran
  -- обновление статусов связанных заказов  
  delete pAccrualAction from pAccrualAction (rowlock) where spid = @@Spid
  insert pAccrualAction 
        (Spid, ObjectID, NewStateID, ActionID, OperDate, Message, sgn)
  select @@Spid, 
         o.OrderID, 
         12,--NewStateID
         16, --ActionID
         o.updDatetime,
         '',
         10

from tOrders o
cross apply (select top 1 * 
               from tProtocol p
              where p.ObjectID = o.OrderID
              order by p.ProtocolID desc
              ) as p

where o.StatusID <> p.NewStateID
and o.StatusID = 12

 --  select * from tNodes
   exec ProtocolAdd