 /*

-- расчет сроков дотавки
delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
insert pDeliveryTerm
      (Spid
      ,OrderID)
Select @@spid,OrderID
  from tOrders 
 where OrderID >= 119086


--Update o
--   set o.DeliveryNextDate = null
--      ,o.DeliveryNextDate2 = null
--      ,o.DeliveryDaysReserve = null
--      ,o.DeliveryPlanDateSupplier = null
--  from pDeliveryTerm p (nolock)
-- inner join tOrders o (nolock)
--         on o.OrderID = p.OrderID
-- where p.spid = @@Spid

exec OrdersDeliveryTermCalc @IsSave = 0

select p.DeliveryNextDate DeliveryNextDateP,
       p.DeliveryDaysReserve DeliveryDaysReserveP, -- ƒней запаса до вылета	
      
       o.DeliveryNextDate,
	   o.DeliveryNextDate2,
       o.DeliveryDaysReserve,-- ƒней запаса до вылета	
	   p.DeliveryPlanDateSupplier DeliveryPlanDateSupplierP,
       o.ProfilesDeliveryID 


       ,p.*
  from pDeliveryTerm p (nolock)
 inner join tOrders o (nolock)
         on o.OrderID = p.OrderID
 where p.spid = @@Spid

 --*/
 --update tOrders
 --set DeliveryNextDate2 = null, DeliveryDaysReserve2 = null
 -- from tOrders
 --where OrderID = 136695
 

  -- расчет сроков дотавки
 delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
 insert pDeliveryTerm (Spid, OrderID)
 Select distinct @@spid, 186522
  -- from pMovement (nolock)
  --where Spid = @@SPID
  
 exec OrdersSupplierDeliveryCalc @IsSave = 1



 select * from pDeliveryTerm where spid = @@spid




