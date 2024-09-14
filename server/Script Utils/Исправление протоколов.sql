select p.*, o.DetailNumber, o.CustomerSubId, o.EmexOrderID, o.ClientID
  from tProtocol p
 --inner join tProtocol pp
 --        on pp.ObjectID    = p.ObjectID
 --       and pp.ProtocolID  > p.ProtocolID
 inner join tOrders o 
         on o.OrderID = p.ObjectID
 where 1=1--p.StateID = 32
   and p.NewStateID =32





 /*
 
--select * from tNodes
begin tran


update o
set o.StatusID = p.NewStateID
  from tProtocol p
 inner join tNodes n
         on n.NodeID = p.NewStateID
 inner join tProtocol pp
        on pp.ObjectID = p.ObjectID
                   --and pp.NewStateID <> p.NewStateID
                   and pp.ProtocolID > p.ProtocolID
 inner join tOrders o 
         on o.OrderID = pp.ObjectID
 where p.NewStateID = 32


delete pp
  from tProtocol p
 inner join tNodes n
         on n.NodeID = p.NewStateID
 inner join tProtocol pp
        on pp.ObjectID = p.ObjectID
                   --and pp.NewStateID <> p.NewStateID
                   and pp.ProtocolID > p.ProtocolID
 inner join tOrders o 
         on o.OrderID = pp.ObjectID
 where p.NewStateID = 32



 commit tran

 --**/