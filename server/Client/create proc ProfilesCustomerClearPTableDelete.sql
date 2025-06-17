if OBJECT_ID('ProfilesCustomerClearPTabledelete') is not null
    drop proc ProfilesCustomerClearPTabledelete
/*
  ProfilesCustomerClearPTabledelete -
*/
go
create proc ProfilesCustomerClearPTabledelete
as
  set nocount on
  declare @r int

  select @R         = 0

  delete pOrderFileFormat  from pOrderFileFormat  (rowlock) where spid = @@spid
  delete pClientReliation  from pClientReliation  (rowlock) where spid = @@spid
  delete pProfilesCustomer from pProfilesCustomer (rowlock) where spid = @@spid

exit_:
return @r
go
grant exec on ProfilesCustomerClearPTabledelete to public
go
exec setOV 'ProfilesCustomerClearPTabledelete', 'P', '20250603', '0'
go
