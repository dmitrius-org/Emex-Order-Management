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
      ,cp.ProfilesCustomerID 
      ,cp.DestinationLogo
      ,cp.Image
      ,cp.ImageHelp
  from tClients c with (nolock index=PK_tClients_ClientID)  
 inner join vClientProfilesParam cp
        on cp.ClientID    = c.ClientID
       and cp.ClientProfileIsActive   = 1   
       and cp.SupplierProfileIsActive = 1   

go
grant all on vDestinationLogo to public
go
exec setOV 'vDestinationLogo', 'V', '20250320', '4'
go
