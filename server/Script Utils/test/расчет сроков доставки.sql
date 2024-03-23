 
 update tOrders 
 set DeliveryNextDate2 = null
 where OrderID=75141




-- расчет сроков дотавки
delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
insert pDeliveryTerm
      (Spid
      ,OrderID)
Select @@spid
      ,75141 --75141

exec OrdersDeliveryTermCalc @IsSave = 1


select p.DeliveryNextDate,
       p.DeliveryDaysReserve,
       o.DeliveryNextDate,
	   o.DeliveryNextDate2,
       o.DeliveryDaysReserve,
	   p.DeliveryPlanDateSupplier,
       *  
  from pDeliveryTerm p (nolock)
 inner join tOrders o (nolock)
         on o.OrderID = p.OrderID
 where p.spid = @@Spid




