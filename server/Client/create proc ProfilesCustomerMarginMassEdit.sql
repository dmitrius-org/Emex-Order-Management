if OBJECT_ID('ProfilesCustomerMarginMassEdit') is not null
    drop proc ProfilesCustomerMarginMassEdit
/*
  ProfilesCustomerMarginMassEdit - 

*/
go
create proc ProfilesCustomerMarginMassEdit
              @Margin         money
            
as
  set nocount on
  declare @r int

 Update pProfilesCustomer
    set Margin = @Margin
  where Spid     = @@Spid


exit_:
return @r
go
grant exec on ProfilesCustomerMarginMassEdit to public
go
exec setOV 'ProfilesCustomerMarginMassEdit', 'P', '20240810', '1'
go