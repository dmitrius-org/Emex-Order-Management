drop proc if exists TaskActionDelete
/*
TaskActionDelete
*/
go
create proc TaskActionDelete
               @ID           numeric(18,0) 
as
  declare @r int = 0

  delete pTaskActions from pTaskActions (rowlock) where ID=@ID 

 exit_:
 return @r
go
grant exec on TaskActionDelete to public
go
exec setOV 'TaskActionDelete', 'P', '20240307', '1.0.0.1'
go
