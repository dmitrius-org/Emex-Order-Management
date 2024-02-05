
if OBJECT_ID('vOrderStateSyncByOrderNum') is not null
    drop view vOrderStateSyncByOrderNum
go
/* **********************************************************						
vOrderStateSyncByOrderNum - получение списка заказов для синхронизации статусов
********************************************************** */

create view vOrderStateSyncByOrderNum

as

Select-- distinct  top 10     
       o.ClientID,
	   o.OrderID,
	   o.StatusID,
       o.EmexOrderID as EmexOrderID 
  from tOrders o (nolock)            
 inner join tNodes n (nolock) 
         on n.NodeID = o.StatusID
		and n.EID not in (5 /*Отправлено*/
	                     ,6	/*NOT AVAILABLE*/
		)     
 where isnull(o.EmexOrderID, 0)<> 0 
   and isnull(o.isCancel, 0)    = 0 
   and  o.EmexOrderID in (248)
  and ClientID = 8

  -- and 1=2
go
grant all on vOrderStateSyncByOrderNum to public
go


--Select * from tNodes n 

select distinct EmexOrderID from vOrderStateSyncByOrderNum
   