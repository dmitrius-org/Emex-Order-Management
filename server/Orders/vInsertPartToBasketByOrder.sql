if OBJECT_ID('vInsertPartToBasketByOrder') is not null
    drop view vInsertPartToBasketByOrder
go
/* **********************************************************						
vInsertPartToBasketByOrder - получение списка деталей для добавления в корзину emex
********************************************************** */
create view vInsertPartToBasketByOrder
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
       o.DestinationLogo as DestinationLogo,
       cast(case 
              when isnull(o.Flag, 0)&2097152 /*ТОЛЬКО ЭТОТ БРЕНД. Без замен */ >0 then 1
              else 0
            end as bit) OnlyThisBrand, 
       isnull(o.Flag, 0) as Flag -- дополнительные признаки
  from tOrders o with (nolock index=ao1)    
 inner join tClients c with (nolock index=PK_tClients_ClientID)
         on c.ClientID = o.ClientID
  left join tPrice pr with (nolock index=ao1)
         on pr.PriceID = o.PriceID          
go
grant all on vInsertPartToBasketByOrder to public
go
exec setOV 'vInsertPartToBasketByOrder', 'V', '20250402', '1'
go
select *
  from vInsertPartToBasketByOrder
 where ClientID=149
 