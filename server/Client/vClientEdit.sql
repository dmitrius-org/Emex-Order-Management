if OBJECT_ID('vClientEdit') is not null
    drop view vClientEdit
go
/* **********************************************************						
vClientEdit - получение сведений о клиенте для редактирования
********************************************************** */

create view vClientEdit

as

select c.ClientID      
      ,c.Brief       
      ,c.Name	     
	  ,c.SuppliersID
      ,c.inDatetime  
      ,c.updDatetime 
	  ,isnull(c.IsActive, 0) IsActive
	  ,c.UserID
      ,c.Taxes
      ,isnull(c.ResponseType, -1)       ResponseType
      ,isnull(c.NotificationMethod, -1) NotificationMethod
      ,c.NotificationAddress
      ,c.ClientTypeID
  from tClients c (nolock)

go
grant all on vClientEdit to public
go
exec setOV 'vClientEdit', 'V', '20240618', '2'
go
