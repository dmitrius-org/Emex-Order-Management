select pp.*, o.DetailNumber, o.CustomerSubId, o.EmexOrderID, o.ClientID
  from tProtocol p
 inner join tProtocol pp
         on pp.ObjectID    = p.ObjectID
        and pp.ProtocolID  > p.ProtocolID
 inner join tOrders o 
         on o.OrderID = pp.ObjectID
 where p.NewStateID = 9

 
--select * from tNodes

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
 where p.NewStateID = 9