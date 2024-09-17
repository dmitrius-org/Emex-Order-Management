select p.* ,o.DetailNumber, o.CustomerSubId, o.EmexOrderID, o.ClientID--, pp.*
  from tProtocol p
 inner join tProtocol pp
         on pp.ObjectID    = p.ObjectID
        and pp.ProtocolID  > p.ProtocolID
        and pp.NewStateID = 8
 --inner join tProtocol pp2
 --        on pp2.ObjectID    = pp.ObjectID
 --       and pp2.ProtocolID  > pp.ProtocolID
 --      -- and pp2.NewStateID = 8
 inner join tOrders o 
         on o.OrderID = p.ObjectID


 where 1=1--p.StateID = 32
   and p.NewStateID in ( 32)
 --and o.StatusID = 36

  -- 909130092


  select o.DetailNumber, o.CustomerSubId, o.EmexOrderID, o.ClientID--, pp.*
  from tOrders o 

 where 1=1--p.StateID = 32
and o.StatusID = 36

  -- 909130092




 
 
--select * from tNodes
begin tran


update o
set o.StatusID = p.NewStateID
  from tProtocol p
 --inner join tNodes n
 --        on n.NodeID = p.NewStateID
 --inner join tProtocol pp
 --       on pp.ObjectID = p.ObjectID
 --                  --and pp.NewStateID <> p.NewStateID
 --                  and pp.ProtocolID > p.ProtocolID
 inner join tOrders o 
         on o.OrderID = p.ObjectID
 --inner join tProtocol pp
 --        on pp.ObjectID    = p.ObjectID
 --       and pp.ProtocolID  > p.ProtocolID
 --       and pp.NewStateID = 8
 where p.NewStateID = 36


delete pp
  from tProtocol p
 --inner join tNodes n
 --        on n.NodeID = p.NewStateID
 --inner join tProtocol pp
 --       on pp.ObjectID = p.ObjectID
 --                  --and pp.NewStateID <> p.NewStateID
 --                  and pp.ProtocolID > p.ProtocolID
 inner join tOrders o 
         on o.OrderID = p.ObjectID
 inner join tProtocol pp
         on pp.ObjectID    = p.ObjectID
        and pp.ProtocolID  > p.ProtocolID
        and pp.NewStateID = 8
 where p.NewStateID = 24

 --rollback tran

 --commit tran

 --**/