drop proc if exists OrderF_SupplierList
/*
  OrderF_SupplierList - Список поставщиков
*/
go
create proc OrderF_SupplierList
               @OrderID                 numeric(18,0)            
              
as
  declare @r int = 0

Select 
       o.PriceLogo  + o.MakeLogo  as ID,
       s.Brief + ' | ' + 
       o.PriceLogo + ' | ' +
       '$' + convert(varchar, isnull(o.PricePurchaseF, o.PricePurchase)) + ' | ' + 
       convert(varchar, isnull(o.DeliveryRestTermSupplier, datediff(dd,getdate(), o.DeliveryPlanDateSupplier) )) + ' дней ' +' | ' + 
       convert(varchar, o.Reliability) + '%' as Name
       ,0 as Price
  from tOrders o (nolock)
 inner join tSuppliers s (nolock)
         on s.SuppliersID = o.SuppliersID
 where o.OrderID =@OrderID
   and not exists (select 1
                     from pFindByNumber p (nolock) 
                    where p.spid      = @@SPid
                      and p.PriceLogo = o.PriceLogo
                      and p.Make      = o.MakeLogo
                   )
 Union all
select 
       p.PriceLogo  + p.Make  as ID,
       s.Brief + ' | ' + 
       p.PriceLogo + ' | ' +
       '$' + convert(varchar, p.Price) + ' | ' + 
       convert(varchar, p.GuaranteedDay) + ' дней ' + case 
                                                        when isnull(o.DeliveryRestTermSupplier, datediff(dd,getdate(), o.DeliveryPlanDateSupplier)) < p.GuaranteedDay 
                                                          then '(+' + convert(varchar, (p.GuaranteedDay - isnull(o.DeliveryRestTermSupplier, datediff(dd,getdate(), o.DeliveryPlanDateSupplier)))) + ')'
                                                        when isnull(o.DeliveryRestTermSupplier, datediff(dd,getdate(), o.DeliveryPlanDateSupplier)) > p.GuaranteedDay 
                                                          then '(' + convert(varchar, (p.GuaranteedDay - isnull(o.DeliveryRestTermSupplier, datediff(dd,getdate(), o.DeliveryPlanDateSupplier)))) + ')'
                                                        else ''
                                                      end +' | ' + 
        convert(varchar, p.PercentSupped) + '%' as Name,
       p.Price
  from tOrders o (nolock)
 inner join pFindByNumber p (nolock) 
         on p.spid = @@SPid
        and p.Make = o.MakeLogo
 inner join tSuppliers s (nolock)
         on s.SuppliersID = o.SuppliersID
 where o.OrderID =@OrderID
 order by Price

  exit_:
  return @r

go
grant exec on OrderF_SupplierList to public
go
exec setOV 'OrderF_SupplierList', 'P', '20240728', '3'
go
 