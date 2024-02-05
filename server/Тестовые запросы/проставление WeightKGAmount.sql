

Update o
  set o.WeightKGAmount  = pd.WeightKG
     ,o.VolumeKGAmount  = pd.VolumeKG
     ,o.DestinationLogo = pd.DestinationLogo
 from tOrders o (nolock)
inner join tClients c with (nolock index=ao1)
        on c.ClientID = o.ClientID
 left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
        on pd.SuppliersID     = c.SuppliersID
       and pd.DestinationLogo = o.DestinationLogo

where o.WeightKGAmount is null



select 

     o.WeightKGAmount
    ,o.VolumeKGAmount
from tOrders o (nolock)
inner join tClients c with (nolock index=ao1)
         on c.ClientID = o.ClientID
  left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
         on pd.SuppliersID =c.SuppliersID
        and pd.DestinationLogo = o.DestinationLogo






select 

     o.WeightKGAmount
    ,o.VolumeKGAmount
    ,o.*
from tOrders o (nolock)
where o.WeightKGAmount is not null