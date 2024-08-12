if OBJECT_ID('ProfilesCustomerReliabilityMassEdit') is not null
    drop proc ProfilesCustomerReliabilityMassEdit
/*
  ProfilesCustomerReliabilityMassEdit - 

*/
go
create proc ProfilesCustomerReliabilityMassEdit
             @Reliability    money 
as
  set nocount on
  declare @r int

 Update pProfilesCustomer
    set Reliability = @Reliability
  where Spid     = @@Spid
    
exit_:
return @r
go
grant exec on ProfilesCustomerReliabilityMassEdit to public
go
exec setOV 'ProfilesCustomerReliabilityMassEdit', 'P', '20240810', '1'
go
