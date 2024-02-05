if OBJECT_ID('ClientGrantDelete') is not null
    drop proc ClientGrantDelete
/*
  ClientGrantDelete - Удаление прав
*/
go
create proc ClientGrantDelete
              @ClientID            numeric(18,0) 
--
as
  declare @r int = 0

  delete tGrantObject
    from tGrantObject t  (rowlock)
   where t.ObjectType in (0, 1) 
     and t.ObjectID  > 0
     and t.LinkType  = 7
     and t.LinkID    = @ClientID

exit_:
return @r
go
grant exec on ClientGrantDelete to public
go