drop proc if exists GetAppInfo
/*
  GetAppInfo 

*/
go
create proc GetAppInfo
as
  set nocount on

        select 'Имя пользователя на SQL-серверах' as p , dbo.GetLogin() as i
  union select 'Сотpудник', (Select top 1 Name from tUser (nolock) where UserID = dbo.GetUserID())
  union select 'SQL-сервера', @@SERVERNAME  
  union select 'Имя базы данных', DB_NAME() 
  union select 'SPID', cast(@@SPID as varchar)
  


 exit_:
 return 0
go
grant exec on GetAppInfo to public
go
exec setOV 'GetAppInfo', 'P', '20240306', '1'
go
exec GetAppInfo