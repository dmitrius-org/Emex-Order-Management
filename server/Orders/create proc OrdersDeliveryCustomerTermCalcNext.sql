drop proc if exists OrdersDeliveryCustomerTermCalcNext
/*
  OrdersDeliveryCustomerTermCalcNext - расчет сроков доставки :
    @IsSave - сохраняет данные
              0 - нет
              1 - да
    
    Входящий набор данных: pDeliveryTerm
    Результат расчета: pDeliveryTerm
*/
go
create proc OrdersDeliveryCustomerTermCalcNext
              @IsSave   bit = null,   
              @IsUpdate bit = null    
as
SET NOCOUNT  ON;
SET DATEFIRST 1;  

declare @r int = 0

select @IsUpdate = isnull(@IsUpdate, 0)

Update p
   set p.ClientID                 = od.ClientID
      ,p.ProfilesDeliveryID       = od.ProfilesDeliveryID	  
	  ,p.DeliveryPlanDateSupplier = od.DeliveryNextDate
  from pDeliveryTerm p (updlock)
  left join vOrdersDeliverySupplier od 
         on od.OrderID = p.OrderID    
 where p.Spid = @@Spid

 
update p
   set p.DeliveryRestToCustomer = datediff(dd, getdate(), dateadd(dd, sdp.DeliveryTermFromSupplier, ods.DeliveryPlanDateSupplier))
      ,p.DeliveryDateToCustomer = dateadd(dd, sdp.DeliveryTermFromSupplier, ods.DeliveryPlanDateSupplier)
      ,p.DeliveryTermToCustomer = datediff(dd, o.OrderDate, dateadd(dd, sdp.DeliveryTermFromSupplier, ods.DeliveryPlanDateSupplier))
  from pDeliveryTerm p (updlock)
 inner join tOrders o with (nolock index=ao1)
         on o.OrderID=p.OrderID 
 inner join vOrdersDeliverySupplier ods 
         on ods.OrderID=p.OrderID 
 inner join vOrdersDeliveryCustomer odc 
         on odc.OrderID=p.OrderID 
 inner join vSupplierDeliveryParam sdp
         on sdp.ProfilesDeliveryID = o.ProfilesDeliveryID
 where p.Spid = @@Spid

if @IsSave = 1
begin

  update o
     set o.DeliveryDateToCustomer = p.DeliveryDateToCustomer 
        --,o.DeliveryRestToCustomer = p.DeliveryRestToCustomer -- Остаток срока до поставки 
    from pDeliveryTerm p with (nolock index=ao1)
   inner join tOrders o with (updlock index=ao1)
           on o.OrderID=p.OrderID 
   where p.Spid = @@spid
     and o.DeliveryDateToCustomer is null

  update o
     set o.DeliveryDateToCustomer = p.DeliveryDateToCustomer 
        ,o.DeliveryRestToCustomer = p.DeliveryRestToCustomer 
        ,o.DeliveryTermToCustomer = p.DeliveryTermToCustomer
    from pDeliveryTerm p (nolock)
   inner join tOrdersDeliveryCustomer o with (updlock index=PK_tOrdersDeliveryCustomer_OrderID)
           on o.OrderID=p.OrderID 
   where p.Spid = @@spid

  insert tOrdersDeliveryCustomer with (rowlock)
        (OrderID,
         DeliveryDateToCustomer,
         DeliveryRestToCustomer,
         DeliveryTermToCustomer)
  select p.OrderID 
        ,p.DeliveryDateToCustomer
        ,p.DeliveryRestToCustomer 
        ,p.DeliveryTermToCustomer
    from pDeliveryTerm p with (nolock index=ao1)
   where p.Spid = @@spid
     and not exists ( select 1
                        from tOrdersDeliveryCustomer o with (nolock index=PK_tOrdersDeliveryCustomer_OrderID)
                       where o.OrderID = p.OrderID )
  update o
     set o.DeliveryRestToCustomer = p.DeliveryRestToCustomer -- Остаток срока до поставки 
    from pDeliveryTerm p with (nolock index=ao1)
   inner join tOrders o with (updlock index=ao1)
           on o.OrderID=p.OrderID 
   where p.Spid = @@spid
end

 exit_:

 return @r
go
  grant exec on OrdersDeliveryCustomerTermCalcNext to public
go
exec setOV 'OrdersDeliveryCustomerTermCalcNext', 'P', '20250320', '3'
go
  