if OBJECT_ID('vMarkOrderSelect') is not null
    drop view vMarkOrderSelect

go
if OBJECT_ID('vMarkOrderState') is not null
    drop view vMarkOrderState
go
/* **********************************************************						
vMarkOrderState - 
********************************************************** */
create view vMarkOrderState
as

select --o.OrderID,
       o.StatusID,
	   o.IsStartState,
	   m.Spid,
	   m.Type
  from tMarks m (nolock)
 inner join vOrders o
         on o.OrderID = m.ID

go
grant all on vMarkOrderState to public
go

Select distinct StatusID, IsStartState from vMarkOrderState

