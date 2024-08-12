if OBJECT_ID('vInsertPartToBasketByPart') is not null
    drop view vInsertPartToBasketByPart
go
/* **********************************************************						
vInsertPartToBasketByPart - получение списка деталей для добавления в корзину
********************************************************** */
create view vInsertPartToBasketByPart
as
Select c.ClientID,
       c.SuppliersID,
       o.OrderID,  
	   o.StatusID,    
       o.OrderNum, 
       case 
         when isnull(o.Flag, 0) & 256 > 0 then isnull(o.ReplacementPrice, o.PricePurchase) 
	     else o.PricePurchase
       end                              as PricePurchase, 
	   o.MakeLogo, 
	   o.DetailNumber, 
	   o.PriceLogo, 
	   o.Quantity, 
	   isnull(pr.WeightKGF, o.WeightKG) as WeightKG, 
	   o.Reference, 
	   o.CustomerSubID,
	   isnull(o.DestinationLogo, pd.DestinationLogo) as DestinationLogo,
	   isnull(o.Flag, 0) as Flag -- дополнительные признаки
  from pAccrualAction p (nolock)  
 inner join tOrders o (nolock)    
         on o.OrderID  = p.ObjectID
 inner join tClients c (nolock)
         on c.ClientID = o.ClientID
  left join tPrice pr with (nolock index=ao1)
         on pr.PriceID = o.PriceID
  left join tProfilesCustomer pc (nolock)
         on pc.ClientID        = o.ClientID
		and pc.ClientPriceLogo = o.CustomerPriceLogo  /*pc.ClientPriceLogo для онлайн заказов тут не будет связи*/
  left join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = isnull(o.ProfilesDeliveryID, pc.ProfilesDeliveryID)
 where p.Spid   = @@spid          
   and p.Retval = 0               

go
grant all on vInsertPartToBasketByPart to public
go
exec setOV 'vInsertPartToBasketByPart', 'V', '20240812', '4'
go