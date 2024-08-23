update o
set o.DestinationName = pc.DestinationName
   from tOrders o

   -- - - -
   outer apply (select top 1 
                       pc.UploadPriceName,
                       pc.ProfilesDeliveryID,
                       pc.Margin,
					   s.Discount,
                       pc.Reliability,
                       s.Commission,
                       s.ExtraKurs,
                       pd.DestinationLogo,
                       pd.WeightKG,   -- Стоимость кг физического веса
                       pd.VolumeKG,
                       pd.Fragile,
                       pd.Name as DestinationName
                  from tProfilesCustomer pc with (nolock index=ao2)
                 inner join tSupplierDeliveryProfiles pd with (nolock index=ao2)
                         on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
                        and pd.DestinationLogo = o.DestinationLogo
                 inner join tSuppliers s with (nolock index=ao1)
                         on s.SuppliersID = pd.SuppliersID 
                 where pc.ClientID        = o.ClientID

                 order by pc.ProfilesCustomerID
                 
                 ) pc

where pc.DestinationLogo is not null

and o.DestinationName is null


--   select * 
   
   
   
--   from tOrders o (nolock)

--where o.DestinationName is null