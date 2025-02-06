drop proc if exists DeliveryRestTermSupplierRecalc
/*
  DeliveryRestTermSupplierRecalc - расчет сроков доставки поставщика :
                     
*/
go
create proc DeliveryRestTermSupplierRecalc
       
as
SET NOCOUNT ON;
SET DATEFIRST 1 ;  

declare @r int = 0

Update o
   set o.DeliveryRestTermSupplier = DATEDIFF(dd, getdate(), o.DeliveryPlanDateSupplier) -- Остаток срока до поставки
  from tOrders o (updlock)
 inner join tNodes n (nolock)
         on n.NodeID = o.StatusID
        and n.Flag&8>0 
 where isnull(o.isCancel, 0) = 0


Update od
   set od.DeliveryRestTermSupplier = DATEDIFF(dd, getdate(), od.DeliveryPlanDateSupplier) -- Остаток срока до поставки 
  from tOrders o (nolock)
 inner join tOrdersDeliverySupplier  od (updlock)
         on od.OrderID = o.OrderID
 inner join tNodes n (nolock)
         on n.NodeID = o.StatusID
        and n.Flag&8>0 
 where isnull(o.isCancel, 0) = 0
  
 exit_:

 return @r
go
  grant exec on DeliveryRestTermSupplierRecalc to public
go
exec setOV 'DeliveryRestTermSupplierRecalc', 'P', '20250204', '3'
go