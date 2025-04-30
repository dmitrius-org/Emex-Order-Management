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
      ,case 
         when isnull(ls.LogDestination, '') <> '' and (isnull(ls.FileLogLevel, '') <> '' or isnull(ls.DBLogLevel, '') <> '') then 1
         else 0
       end Status
  from tClients c (nolock)
  left join tSuppliers s (nolock)
         on s.SuppliersID = c.SuppliersID
  left join tClientType ct (nolock)
         on ct.ClientTypeID = c.ClientTypeID
  left join tOrderFileFormat o (nolock)
         on o.ClientID = c.ClientID
  left join tRest r  (updlock) 
         on r.ClientID = c.ClientID  
  left join tLoggerSettings ls (nolock) 
         on ls.UserID = c.ClientID 
        and ls.AppName = 'Customer'
go
grant all on vClients to public
go
exec setOV 'vClients', 'V', '20250414', '3'
go

select * from vClients