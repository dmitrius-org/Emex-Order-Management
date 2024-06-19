if OBJECT_ID('ClientReliationDelete') is not null
    drop proc ClientReliationDelete
/*
  ClientReliationDelete - Удаление связанных объектов клиента
*/
go
create proc ClientReliationDelete
              @ClientID            numeric(18,0) 
--
as
  declare @r int = 0

  delete tProfilesCustomer
    from tProfilesCustomer t  (rowlock)
   where t.ClientID = @ClientID

  delete tClientReliation
    from tClientReliation (rowlock)
   where ClientID = @ClientID   

exit_:
return @r
go
grant exec on ClientReliationDelete to public
go
exec setOV 'ClientReliationDelete', 'P', '20240101', '0'
go
