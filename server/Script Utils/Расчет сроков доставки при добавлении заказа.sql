  -- расчет сроков дотавки
  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm (Spid, OrderID)
  Select @@spid, 86325
  
  exec LoadOrdersDeliveryTermCalc @IsSave = 0


  select * from pDeliveryTerm (rowlock) where spid = @@Spid