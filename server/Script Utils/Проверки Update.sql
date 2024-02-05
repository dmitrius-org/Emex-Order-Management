select  Quantity, EmexQuantity, *
from tOrders
where OrderID=40105



Update tOrders
set Quantity=1
   
from tOrders
where OrderID=52014

delete
from tOrders
where OrderID=39496




  update o 
     set o.AmountPurchaseF = o.Quantity * o.PricePurchaseF
    from tOrders o 
   where o.PricePurchaseF * o.Quantity <> o.AmountPurchaseF


  update o 
     set o.AmountPurchase = o.Quantity * o.PricePurchase
    from tOrders o 
   where o.PricePurchase * o.Quantity <> o.AmountPurchase
delete p
  from tProtocol p
 where not exists (select 1
                    from tOrders o (nolock)
				   where o.OrderID = p.ObjectID
				   )