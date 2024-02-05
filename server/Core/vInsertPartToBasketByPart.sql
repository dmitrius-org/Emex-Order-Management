if OBJECT_ID('vInsertPartToBasketByPart') is not null
    drop view vInsertPartToBasketByPart
go
/* **********************************************************						
vInsertPartToBasketByPart -
********************************************************** */

create view vInsertPartToBasketByPart

as

Select o.ClientID,
       o.OrderID,  o.StatusID,    
       o.OrderNum, 
	   o.PricePurchase, 
	   o.MakeLogo, 
	   o.DetailNumber, 
	   o.PriceLogo, 
	   o.Quantity, 
	   isnull(pr.WeightKGF, o.WeightKG) WeightKG, 
	   o.Reference, 
	   o.CustomerSubID,
	   isnull(o.DestinationLogo, pd.DestinationLogo) as DestinationLogo
  from pAccrualAction p (nolock)  
 inner join tOrders o (nolock)    
         on o.OrderID = p.ObjectID
  left join tPrice pr with (nolock index=ao1)
         on pr.PriceID = o.PriceID

 inner join tProfilesCustomer pc (nolock)
         on pc.ClientID        = o.ClientID
        and pc.ClientPriceLogo = o.CustomerPriceLogo
 inner join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = isnull(o.ProfilesDeliveryID, pc.ProfilesDeliveryID)
		 
 where p.Spid   = @@spid          
   and p.Retval = 0               

go
grant all on vInsertPartToBasketByPart to public
go


--Select * from tOrders p 

select * from vInsertPartToBasketByPart
