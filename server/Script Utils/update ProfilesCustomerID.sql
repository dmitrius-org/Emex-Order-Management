Update o
set o.ProfilesCustomerID = null
  from tOrders o

Update o
   set o.ProfilesCustomerID = pc.ProfilesCustomerID
  from tOrders o
 inner join tProfilesCustomer pc 
         on pc.ClientID = o.ClientID
        and pc.ProfilesDeliveryID = o.ProfilesDeliveryID
        and pc.ClientPriceLogo = o.CustomerPriceLogo
 where isnull(o.ProfilesCustomerID, 0)= 0

Update o
   set o.ProfilesCustomerID = pc.ProfilesCustomerID
  from tOrders o
 inner join tProfilesCustomer pc 
         on pc.ClientID = o.ClientID
        and pc.ProfilesDeliveryID = o.ProfilesDeliveryID
 where isnull(o.ProfilesCustomerID, 0)= 0


Update o
   set o.ProfilesCustomerID = pc.ProfilesCustomerID
  from tOrders o
 inner join tProfilesCustomer pc 
         on pc.ProfilesDeliveryID = o.ProfilesD