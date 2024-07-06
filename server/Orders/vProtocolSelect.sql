

if OBJECT_ID('vProtocolSelect') is not null
    drop view vProtocolSelect
go
/* **********************************************************						
vProtocolSelect - начитка данных для формы Протокол
********************************************************** */
create view vProtocolSelect
as

SELECT p.[ProtocolID]  ProtocolID
      ,p.[ObjectID]	   ObjectID
      ,n.Name          CurState
      ,a.Name          ActionName 
      ,p.OperDate      OperDate
      ,p.[Comment]     Comment
      ,case 
         when o.Flag & 16 > 0 /*если он-лайн заказ*/ then c.Brief
         else u.Name
       end as UserName
	  ,p.InDateTime    InDateTime
      ,0               ProtocolType
  FROM [tProtocol] p (nolock)
 inner join tOrders o with (nolock index=ao1)
         on o.OrderID = p.ObjectID
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
/*Отказы*/
SELECT p.[AuditID]          ProtocolID
      ,p.[ObjectID]	        ObjectID
      ,null                 CurState
      ,'Выгрузка отказов'   ActionName 
      ,p.InDateTime    OperDate
      ,p.[Comment]     Comment
      ,u.Name          UserName
	  ,p.InDateTime    InDateTime
      ,1               ProtocolType
  FROM tAudit p (nolock)
 inner join tOrders o with (nolock index=ao1)
         on o.OrderID = p.ObjectID
 inner join tUser u with (nolock index=ao1)
         on u.UserID = p.UserID
 where p.ActionID = 5 -- acCancel
 union all
/*Изменения*/
SELECT p.[AuditID]     ProtocolID
      ,p.[ObjectID]	   ObjectID
      ,null            CurState
      ,'Изменение'     ActionName 
      ,p.InDateTime    OperDate
      ,p.[Comment]     Comment
      ,case 
         when o.Flag & 16 > 0 /*если он-лайн заказ*/ then c.Brief
         else u.Name
       end as UserName
	  ,p.InDateTime    InDateTime
      ,2               ProtocolType
  FROM tAudit p with (nolock)
 inner join tOrders o with (nolock index=ao1)
         on o.OrderID = p.ObjectID
 inner join tClients c with (nolock index=ao1)
         on c.ClientID = o.ClientID  
 inner join tUser u with (nolock index=ao1)
         on u.UserID = p.UserID
 where p.ActionID = 2 -- acUpdate

 union all
/*Откат действия */
SELECT p.[AuditID]     ProtocolID
      ,p.[ObjectID]	   ObjectID
      ,null            CurState
      ,'Отмена'        ActionName 
      ,p.InDateTime    OperDate
      ,p.[Comment]     Comment
      ,case 
         when o.Flag & 16 > 0 /*если он-лайн заказ*/ then c.Brief
         else u.Name
       end as UserName
	  ,p.InDateTime    InDateTime
      ,3               ProtocolType
  FROM tAudit p with (nolock)
 inner join tOrders o with (nolock index=ao1)
         on o.OrderID = p.ObjectID
 inner join tClients c with (nolock index=ao1)
         on c.ClientID = o.ClientID  
 inner join tUser u with (nolock index=ao1)
         on u.UserID = p.UserID
 where p.ActionID = 27	--acRollback	Откат действия    
 
go
grant all on vProtocolSelect to public
go
exec setOV 'vProtocolSelect', 'V', '20240704', '2'
go
