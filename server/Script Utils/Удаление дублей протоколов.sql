--Select 
--      *

--  from tProtocol

--where ObjectID = 111233

-- rollback tran
--begin tran
;with sd as (

Select 
      min (ProtocolID) ProtocolID
      ,ObjectID	
   --   ,StateID	
      ,NewStateID	
    --  ,ActionID

  from tProtocol

--where ObjectID = 162142

group by 
 ObjectID	
--,StateID	
,NewStateID	
--,ActionID
)

delete p

  from sd 
  inner join tProtocol p 
          on p.ObjectID    = sd.ObjectID
       --  and p.StateID	   = sd.StateID	
         and p.NewStateID  = sd.NewStateID
       --  and p.ActionID    = sd.ActionID
         and p.ProtocolID >sd.ProtocolID  
--where p.ObjectID = 111233