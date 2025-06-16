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
      ,r.Amount as Rest
      ,case 
         when isnull(ls.LogDestination, '') <> '' and (isnull(ls.FileLogLevel, '') <> '' or isnull(ls.DBLogLevel, '') <> '') then 1
         else 0
       end |
       case 
         when isnull(ua.CNT, 0) >= 3 then 2
         else 0
       end  
       Status
  from tClients c (nolock)
  left join tClientType ct (nolock)
         on ct.ClientTypeID = c.ClientTypeID
  left join tOrderFileFormat o (nolock)
         on o.ClientID = c.ClientID
  left join tRest r  (updlock) 
         on r.ClientID = c.ClientID  
  left join tLoggerSettings ls (nolock) 
         on ls.UserID = c.ClientID 
        and ls.AppName = 'Customer'
  left join tUsersAuthorization ua (nolock)
         on ua.UserName = c.Email

go
grant all on vClients to public
go
exec setOV 'vClients', 'V', '20250604', '5'
go
