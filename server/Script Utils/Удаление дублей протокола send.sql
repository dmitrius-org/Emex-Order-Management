begin tran
-- commit tran
--rollback tran

;with sd as (

Select 
      min (ProtocolID) ProtocolID
      ,ObjectID		
      ,NewStateID	
  from tProtocol
where 1=1
  and NewStateID = 8	--Send	Передано для доставки из ОАЭ в РФ

group by 
 ObjectID	
--,StateID	
,NewStateID	
--,ActionID
)



/*
select p.*

  from sd 
  inner join tProtocol p 
          on p.ObjectID    = sd.ObjectID
       --  and p.StateID	   = sd.StateID	
         and p.NewStateID  = sd.NewStateID
       --  and p.ActionID    = sd.ActionID
         and p.ProtocolID >sd.ProtocolID  


 order by p.ObjectID
 */
delete p

  from sd 
  inner join tProtocol p 
          on p.ObjectID    = sd.ObjectID
         and p.NewStateID  = sd.NewStateID
         and p.ProtocolID >sd.ProtocolID  
/*

Update o
set StatusID = p.NewStateID
from tOrders o
cross apply (select top 1 * 
               from tProtocol p
              where p.ObjectID = o.OrderID
              order by p.ProtocolID desc
              ) as p
where o.StatusID <> p.NewStateID



select * from tNodes
--*/