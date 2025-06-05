if OBJECT_ID('ProfilesCustomerClearPTable') is not null
    drop proc ProfilesCustomerClearPTable
/*
  ProfilesCustomerClearPTable -
*/
go
create proc ProfilesCustomerClearPTable
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
grant exec on ProfilesCustomerClearPTable to public
go
exec setOV 'ProfilesCustomerClearPTable', 'P', '20250603', '0'
go
