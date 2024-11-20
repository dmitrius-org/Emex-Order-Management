if OBJECT_ID('vOrderStateSyncByOrderNum') is not null
    drop view vOrderStateSyncByOrderNum
go
/* **********************************************************						
vOrderStateSyncByOrderNum - получение списка заказов для синхронизации статусов

********************************************************** */
create view vOrderStateSyncByOrderNum
as

Select o.ClientID,
	   o.OrderID,
	   o.StatusID,
       o.EmexOrderID as EmexOrderID,
       c.SuppliersID

  from tOrders o (nolock)   
 inner join tClients c (nolock)
         on c.ClientID = o.ClientID 
 inner join tNodes n (nolock) 
         on n.NodeID = o.StatusID
        and n.Flag&2>0 
 where isnull(o.EmexOrderID, 0)  > 0
   and isnull(o.isCancel, 0)     = 0 

go
grant all on vOrderStateSyncByOrderNum to public
go
go
exec setOV 'vOrderStateSyncByOrderNum', 'V', '20240914', '2'
go

select EmexOrderID, count(*) 
  
  from vOrderStateSyncByOrderNum 
 group by EmexOrderID