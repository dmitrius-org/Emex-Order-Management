

if OBJECT_ID('vShipmentsProtocolSelect') is not null
    drop view vShipmentsProtocolSelect
go
/* **********************************************************						
vShipmentsProtocolSelect - начитка данных для формы Протокол
********************************************************** */
create view vShipmentsProtocolSelect
as

SELECT p.ShipmentsProtocolID  ProtocolID
      ,p.ShipmentsID          ObjectID
      ,n.Name          CurState
      ,a.Name          ActionName 
      ,p.OperDate      OperDate
      ,p.[Comment]     Comment
      ,case 
         when p.Flag & 1 > 0 /*Протокол по клиентскому приложению*/ then c.Brief
         else u.Name
       end as UserName
	  ,p.InDateTime    InDateTime
      ,0               ProtocolType
  FROM tShipmentsProtocol p (nolock)
 inner join tOrders o with (nolock index=ao1)
         on o.OrderID = p.ShipmentsID
 inner join tClients c with (nolock index=ao1)
         on c.ClientID = o.ClientID  
 inner join tNodes n with (nolock index=ao1)
         on n.NodeID = p.NewStateID
  left join tNodes s with (nolock index=ao1)
         on s.NodeID = p.StateID
  left join tNodes a with (nolock index=ao1)
         on a.NodeID = p.ActionID
 inner join tUser u with (nolock index=ao1)
         on u.UserID = p.UserID
         
 union all
/*Изменения*/
SELECT p.[AuditID]     ProtocolID
      ,p.[ObjectID]	   ObjectID
      ,null            CurState
      ,'Изменение'     ActionName 
      ,p.InDateTime    OperDate
      ,p.[Comment]     Comment
      ,u.Name UserName
	  ,p.InDateTime    InDateTime
      ,1               ProtocolType
  FROM tAudit p with (nolock)
 inner join tShipments o with (nolock index=ao1)
         on o.ShipmentsID = p.ObjectID
 --inner join tClients c with (nolock index=ao1)
 --        on c.ClientID = o.ClientID  
 inner join tUser u with (nolock index=ao1)
         on u.UserID = p.UserID
 where p.ActionID in ( 2 -- acUpdate
                      ,28--	acCancelRequest
                     )
   and p.ObjectTypeID = 10


go
grant all on vShipmentsProtocolSelect to public
go
exec setOV 'vShipmentsProtocolSelect', 'V', '20240915', '0'
go
