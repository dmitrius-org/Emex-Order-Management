aif OBJECT_ID('vClients') is not null
    drop view vClients
go
/* **********************************************************						
vClients - получение списка клиентов
********************************************************** */

create view vClients

as

select c.ClientID      
      ,c.Brief       
      ,c.Name	     
      ,c.inDatetime  
      ,c.updDatetime 
	  ,c.IsActive
	  ,c.UserID
      ,ct.Name as ClientTypeName --
  from tClients c (nolock)
  left join tClientType ct (nolock)
         on ct.ClientTypeID = c.ClientTypeID
  left join tOrderFileFormat o (nolock)
         on o.ClientID = c.ClientID
go
grant all on vClients to public
go
exec setOV 'vClients', 'V', '20240101', '1.0.0.0'
go
