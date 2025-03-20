if OBJECT_ID('vProfilesCustomer') is not null
    drop view vProfilesCustomer
--go
--/* **********************************************************						
--vProfilesCustomer - 
--********************************************************** */

--create view vProfilesCustomer

--as

-- select pc.ClientID, 
--        pc.ProfilesCustomerID, 
--        pd.DestinationLogo, 
--        pd.Name DestinationName,
--        pd.Delivery-- Срок поставки клиента, для заказов из файла берем из профилей доставки
--   from tProfilesCustomer pc with (nolock)
--   left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
--          on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
            
--go
--grant all on vProfilesCustomer to public
--go
--exec setOV 'vProfilesCustomer', 'V', '20241112', '0'
--go

--select * from vProfilesCustomer