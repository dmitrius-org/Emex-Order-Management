if OBJECT_ID('vProfilesCustomer') is not null
    drop view vProfilesCustomer
go
/* **********************************************************						
vProfilesCustomer - 
********************************************************** */
create view vProfilesCustomer
as

select p.*
      ,sp.Name   ProfilesDeliveryName
      ,d.Name    UploadDelimiter
      ,cast(s.Brief as varchar)   SupplierName
  from pProfilesCustomer p (nolock)
  left join tSupplierDeliveryProfiles sp (nolock)
         on sp.ProfilesDeliveryID = p.ProfilesDeliveryID
  left join tDelimiter d (nolock)
         on d.DelimiterID = p.UploadDelimiterID
  left join tSuppliers s (nolock)   
         on s.SuppliersID = p.SuppliersID    
 where p.Spid = @@Spid
            
go
grant all on vProfilesCustomer to public
go
exec setOV 'vProfilesCustomer', 'V', '20250604', '1'
go

--select * from vProfilesCustomer