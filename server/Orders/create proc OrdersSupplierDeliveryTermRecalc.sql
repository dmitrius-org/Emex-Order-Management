drop proc if exists OrdersSupplierDeliveryTermRecalc
/*
  OrdersSupplierDeliveryTermRecalc - расчет сроков доставки поставщика :
                     
*/
go
create proc OrdersSupplierDeliveryTermRecalc
       
as
SET NOCOUNT ON;
SET DATEFIRST 1 ;  

declare @r int = 0

Update o
   set o.DeliveryRestTermSupplier = o.DeliveryTerm - DATEDIFF(dd, o.OrderDate, getdate())  -- Остаток срока до поставки 
  from tOrders o (nolock)
 inner join tNodes n (nolock)
         on n.NodeID = o.StatusID
        and n.Flag&8>0 
 where isnull(o.isCancel, 0) = 0
  
 exit_:

 return @r
go
  grant exec on OrdersSupplierDeliveryTermRecalc to public
go
exec setOV 'OrdersSupplierDeliveryTermRecalc', 'P', '20241011', '1'
go