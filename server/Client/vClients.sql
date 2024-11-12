if OBJECT_ID('vClients') is not null
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
      ,ct.Name  as ClientTypeName --
	  ,s.Brief  as Supplier
      ,r.Amount as Rest 
  from tClients c (nolock)
  left join tSuppliers s (nolock)
         on s.SuppliersID = c.SuppliersID
  left join tClientType ct (nolock)
         on ct.ClientTypeID = c.ClientTypeID
  left join tOrderFileFormat o (nolock)
         on o.ClientID = c.ClientID
  left join tRest r  (updlock) 
         on r.ClientID = c.ClientID  
go
grant all on vClients to public
go
exec setOV 'vClients', 'V', '20241112', '2'
go

select * from vClients