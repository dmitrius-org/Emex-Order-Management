drop proc if exists OrdersSupplierDeliveryCalc
/*
  OrdersSupplierDeliveryCalc - расчет сроков доставки поставщика:
  @IsSave - сохраняет данные в tOrders
            0 - нет
            1 - да

  Входящий набор данных: pDeliveryTerm
  Результат расчета: pDeliveryTerm
*/
go
create proc OrdersSupplierDeliveryCalc
              @IsSave bit =  null           
as
set nocount on;
SET DATEFIRST 1 ;  

declare @r int = 0

Update p
   set p.ClientID     = o.ClientID
      ,p.OrderDate    = coalesce(p.OrderDate, op.OperDate, cast(getdate() as date))
      ,p.PriceLogo    = o.PriceLogo
      ,p.DeliveryTerm = coalesce(p.DeliveryTerm, od.DeliveryTermSupplier, o.DeliveryTerm, 0) -- срок доставки поставщику
  from pDeliveryTerm p with (updlock)
 inner join tOrders o with (nolock)
         on o.OrderID = p.OrderID
  left join vOrdersProtocolInWork op with (nolock)
         on op.OrderID=o.OrderID
  left join tOrdersDeliverySupplier  od with (nolock)
         on od.OrderID = o.OrderID
 where p.Spid = @@Spid

Update p
   set p.DeliveryPlanDateSupplier = cast(
                                    case -- плановая дата поступления поставщику
	                                   when o.Flag&16>0 then DATEADD(dd, p.DeliveryTerm, p.OrderDate)
                                       when isnull(Prices.InWorkingDays, 0) = 1 /*срок в рабочих днях*/ then dbo.AddDaysAndWeekends(p.OrderDate, p.DeliveryTerm, 1)
                                       else DATEADD(dd, p.DeliveryTerm, p.OrderDate)
                                    end as date)
  from pDeliveryTerm p with (updlock)
 inner join tOrders o with (nolock)
         on o.OrderID = p.OrderID
 outer apply (select top 1 *
                from tPrices t with (nolock) 
               where t.Name = o.PriceLogo
              ) as Prices

 where p.Spid = @@Spid


if @IsSave = 1
begin

  update o
       set o.DeliveryPlanDateSupplier = p.DeliveryPlanDateSupplier 
          ,o.DeliveryRestTermSupplier = p.DeliveryTerm -- Остаток срока до поставки 
      from pDeliveryTerm p with (nolock index=ao1)
     inner join tOrders o with (updlock index=ao1)
             on o.OrderID=p.OrderID 
     where p.Spid = @@spid
       and o.DeliveryPlanDateSupplier is null

  update o
     set o.DeliveryPlanDateSupplier = p.DeliveryPlanDateSupplier 
        ,o.DeliveryTermSupplier     = p.DeliveryTerm 
        ,o.DeliveryRestTermSupplier = DATEDIFF(dd, getdate(), p.DeliveryPlanDateSupplier) -- Остаток срока до поставки 
    from pDeliveryTerm p (nolock)
   inner join tOrdersDeliverySupplier o with (updlock index=PK_tOrdersDeliverySupplier_OrderID)
           on o.OrderID=p.OrderID 
   where p.Spid = @@spid


  insert tOrdersDeliverySupplier with (rowlock)
        (OrderID,
         DeliveryPlanDateSupplier,
         DeliveryTermSupplier,
         DeliveryRestTermSupplier)
  select p.OrderID
        ,p.DeliveryPlanDateSupplier 
        ,p.DeliveryTerm
        ,DATEDIFF(dd, getdate(), p.DeliveryPlanDateSupplier) -- Остаток срока до поставки 
    from pDeliveryTerm p with (nolock)
   where p.Spid = @@spid
     and not exists ( select 1
                        from tOrdersDeliverySupplier o with (nolock index=PK_tOrdersDeliverySupplier_OrderID)
                       where o.OrderID = p.OrderID )

end

exit_:

return @r
go
  grant exec on OrdersSupplierDeliveryCalc to public
go
exec setOV 'OrdersSupplierDeliveryCalc', 'P', '20250210', '1'
go