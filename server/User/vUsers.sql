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
  from tUser u (nolock)
 -- inner join  is_disabled from sys.server_principals
go
grant all on vUsers to public
go
exec setOV 'vUsers', 'V', '20241007', '1'
go
 
 
 select * from vUsers
