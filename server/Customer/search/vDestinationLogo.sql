if OBJECT_ID('vDestinationLogo') is not null
    drop view vDestinationLogo
go
/* **********************************************************						
vDestinationLogo - получение способов доставки



********************************************************** */

create view vDestinationLogo
as 

Select c.ClientID 
      ,sp.DestinationLogo 
      ,sp.Image
      ,sp.ImageHelp
  from tClients c (nolock)  
inner join tProfilesCustomer pc (nolock)
        on pc.ClientID    = c.ClientID
       and pc.IsActive    = 1   
inner join tSupplierDeliveryProfiles sp (nolock) 
        on sp.ProfilesDeliveryID = pc.ProfilesDeliveryID 
       and sp.IsActive    = 1   

go
grant all on vDestinationLogo to public
go
exec setOV 'vDestinationLogo', 'V', '20240618', '1'
go
