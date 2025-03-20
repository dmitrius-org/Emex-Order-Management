if OBJECT_ID('vInsertPartToBasketByPart') is not null
    drop view vInsertPartToBasketByPart
go
/* **********************************************************						
vInsertPartToBasketByPart - получение списка деталей для добавления в корзину emex
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
	   o.Reference       as Reference, 
	   o.CustomerSubID   as CustomerSubID,
	   o.DestinationLogo as DestinationLogo,
	   isnull(o.Flag, 0) as Flag -- дополнительные признаки
  from pAccrualAction p (nolock)  
 inner join tOrders o (nolock)    
         on o.OrderID  = p.ObjectID
 inner join tClients c (nolock)
         on c.ClientID = o.ClientID
  left join tPrice pr with (nolock index=ao1)
         on pr.PriceID = o.PriceID
 where p.Spid   = @@spid          
   and p.Retval = 0               

go
grant select on vInsertPartToBasketByPart to public
go
exec setOV 'vInsertPartToBasketByPart', 'V', '20250227', '5'
go