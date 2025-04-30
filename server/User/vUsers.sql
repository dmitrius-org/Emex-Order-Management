if OBJECT_ID('vUsers') is not null
    drop view vUsers
go
/* **********************************************************						
vUsers - получение списка пользователей
********************************************************** */

create view vUsers

as

--SET DATEFIRST 1;

select u.UserID      
      ,u.Brief       
      ,u.Name	     
      ,cast(isnull(IS_SRVROLEMEMBER('sysadmin', u.Brief), 0) as bit) isAdmin	 
      ,u.isBlock isBlock
      ,nullif(u.DateBlock, '18991230') DateBlock    
      ,u.inDatetime  
      ,u.updDatetime 
      ,isnull(u.Email, '') Email
      ,case 
         when isnull(ls.LogDestination, '') <> '' and (isnull(ls.FileLogLevel, '') <> '' or isnull(ls.DBLogLevel, '') <> '') then 1
         else 0
       end Status
  from tUser u (nolock)
  left join tLoggerSettings ls (nolock) 
         on ls.UserID = u.UserID 
        and ls.AppName = 'Manager'
go
grant all on vUsers to public
go
exec setOV 'vUsers', 'V', '20250430', '2'
go

