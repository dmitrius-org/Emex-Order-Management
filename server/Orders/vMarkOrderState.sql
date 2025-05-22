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
	   iif(o.StatusID=1, 1, 0) as IsStartState,
	   m.Spid,
	   m.Type
  from tMarks m with (nolock index=pk_tMarks)
 inner join tOrders o with (nolock index=ao1) 
         on o.OrderID = m.ID
 where Spid = @@Spid 
   and Type = 3
go
grant all on vMarkOrderState to public
go
exec setOV 'vMarkOrderState', 'V', '20250531', '0'
go

