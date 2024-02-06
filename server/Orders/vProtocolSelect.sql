

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
      ,u.Name          UserName
	  ,p.InDateTime    InDateTime
      ,0               ProtocolType
  FROM [tProtocol] p (nolock)
 inner join tOrders o (nolock)
         on o.OrderID = p.ObjectID
 inner join tNodes n (nolock)
         on n.NodeID = p.NewStateID
  left join tNodes s (nolock)
         on s.NodeID = p.StateID
  left join tNodes a (nolock)
         on a.NodeID = p.ActionID
 inner join tUser u (nolock)
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
 inner join tOrders o (nolock)
         on o.OrderID = p.ObjectID
 inner join tUser u (nolock)
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
      ,u.Name          UserName
	  ,p.InDateTime    InDateTime
      ,2               ProtocolType
  FROM tAudit p (nolock)
 inner join tOrders o (nolock)
         on o.OrderID = p.ObjectID
 inner join tUser u (nolock)
         on u.UserID = p.UserID
 where p.ActionID = 2 -- acUpdate
 
go
grant all on vProtocolSelect to public
go

select * 
  from vProtocolSelect
 where ObjectID=51970
 order by InDateTime desc