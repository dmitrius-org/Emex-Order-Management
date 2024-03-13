if OBJECT_ID('vClientEdit') is not null
    drop view vClientEdit
go
/* **********************************************************						
vClientEdit - получение сведений о клиенте для редактирования
********************************************************** */

create view vClientEdit

as

--SET DATEFIRST 1;

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
      ,c.Margin
      ,c.Reliability
      ,c.Discount
      ,c.Commission
  from tClients c (nolock)

go
grant all on vClientEdit to public
go
exec setOV 'vClientEdit', 'V', '20240101', '0'
go
