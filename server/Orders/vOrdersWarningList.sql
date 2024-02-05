if OBJECT_ID('vOrdersWarningList') is not null
    drop view vOrdersWarningList
go
/* 						
vOrdersWarningList - 
 */

create view vOrdersWarningList

as

--
Select o.OrderID, o.Warning, o.Flag, ns.NodeID as ActionID, ns.Brief as ActionBrief 
  from pAccrualAction p (nolock)
 inner join tOrders o (nolock)
         on  o.OrderID = p.ObjectID
		and (o.Flag & 1 > 0 or o.Flag & 2 > 0)
 inner join tNodes ns (nolock)
        on ns.NodeID = p.ActionID
 where p.Spid = @@spid

go
grant all on vOrdersWarningList to public

--select * from vUsers


Select * from vOrdersWarningList