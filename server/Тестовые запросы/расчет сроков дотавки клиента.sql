  -- расчет сроков дотавки
 delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
 insert pDeliveryTerm (Spid, OrderID)
 Select distinct @@spid, 186522
  -- from pMovement (nolock)
  --where Spid = @@SPID
  
 exec OrdersSupplierDeliveryCalc @IsSave = 1