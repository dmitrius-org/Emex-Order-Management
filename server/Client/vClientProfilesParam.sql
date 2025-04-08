if OBJECT_ID('vClientProfilesParam') is not null
    drop view vClientProfilesParam
go
/* **********************************************************						
vClientProfilesParam - 
********************************************************** */

create view vClientProfilesParam

as

  select pc.ProfilesCustomerID,
         pc.isActive          as ClientProfileIsActive, -- признак активности профиля на клиенте
         pc.ClientID,       
         pc.ClientPriceLogo,
         pc.UploadPriceName,
         pc.UploadFileName,
         pc.Brief             as ClientProfileName,
         pc.Margin,
         pc.Reliability,
         pc.DeliveryTermCustomer, -- срок поставки клиента

         pd.ProfilesDeliveryID,
         pd.SupplierProfileIsActive,-- признак активности профиля на направлении
         pd.DestinationLogo   as DestinationLogo, 
         pd.ProfileName       as DestinationName,
         pd.DeliveryTermFromSupplier, -- срок поставки от поставщика (от Эмиратов до России)
         pd.WeightKG,
         pd.VolumeKG,
         pd.VolumeKG_Rate1,
         pd.VolumeKG_Rate2,
         pd.VolumeKG_Rate3,
         pd.VolumeKG_Rate4,
         pd.Fragile,
         pd.Restrictions,       -- ограничения
         pd.Image,
         pd.ImageHelp,
         pd.isMyDelivery,
         pd.isIgnore,

         pd.SuppliersID
    from tProfilesCustomer pc with (nolock)-- index=PK_tProfilesCustomer_ProfilesCustomerID)
    left join vSupplierDeliveryParam pd--SupplierDeliveryProfiles pd with (nolock index=PK_tSupplierDeliveryProfiles_ID)
           on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
            
go
grant all on vClientProfilesParam to public
go
exec setOV 'vClientProfilesParam', 'V', '20250320', '0'
go

select * from vClientProfilesParam