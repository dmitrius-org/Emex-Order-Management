if OBJECT_ID('vDestinationLogo') is not null
    drop view vDestinationLogo
go
/* **********************************************************						
vDestinationLogo - получение способов доставки
********************************************************** */
create view vDestinationLogo
as 

Select distinct 
       c.ClientID 
      ,pc.ProfilesCustomerID 
      ,sp.DestinationLogo
      ,sp.Image
      ,sp.ImageHelp
  from tClients c with (nolock index=PK_tClients_ClientID)  
inner join tProfilesCustomer pc with (nolock index=ao2)
        on pc.ClientID    = c.ClientID
       and pc.IsActive    = 1   
inner join tSupplierDeliveryProfiles sp with (nolock index=ao2) 
        on sp.ProfilesDeliveryID = pc.ProfilesDeliveryID 
       and sp.IsActive    = 1   

go
grant all on vDestinationLogo to public
go
exec setOV 'vDestinationLogo', 'V', '20250226', '3'
go
