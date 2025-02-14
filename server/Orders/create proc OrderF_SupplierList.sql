drop proc if exists OrderF_SupplierList
go
create proc OrderF_SupplierList
               @OrderID                 numeric(18,0)            
/*
  OrderF_SupplierList - Список поставщиков
*/           
as
  declare @r int = 0

Select 
       o.PriceLogo  + '.' +  o.MakeLogo  as ID,
       s.Brief + ' | ' + 
       o.PriceLogo + ' | ' +
       '$' + convert(varchar, coalesce(o.PricePurchaseF, o.PricePurchase, 0)) + ' | ' + 
       convert(varchar, o.Quantity) + '/' + isnull(convert(varchar, p.Quantity), '-') + ' | ' + -- количество
       convert(varchar, isnull(o.DeliveryRestTermSupplier, datediff(dd,getdate(), o.DeliveryPlanDateSupplier) )) + ' дней ' +' | ' + 
       convert(varchar, o.Reliability) + '%' as Name
       ,0 as Price
  from tOrders o (nolock)
 inner join tSuppliers s (nolock)
         on s.SuppliersID = o.SuppliersID
  left join tPrice p with (nolock index=ao1)
         on p.PriceID = o.PriceID	
 where o.OrderID =@OrderID
   and not exists (select 1
                     from pFindByNumber p (nolock) 
                    where p.spid      = @@SPid
                      and p.PriceLogo = o.PriceLogo
                      and p.Make      = o.MakeLogo
                   )
 Union all
select 
       p.PriceLogo + '.' + p.Make  as ID,
       s.Brief + ' | ' + 
       p.PriceLogo + ' | ' +
       '$' + convert(varchar, p.Price) + ' | ' + 
       convert(varchar, o.Quantity) + '/' + convert(varchar, isnull(p.Available, '-'))  + ' | ' + -- количество
       convert(varchar, p.GuaranteedDay) + ' дней ' + case 
                                                        when  (datediff(day, o.OrderDate, getdate()) + -- дней в обработке
                                                              p.GuaranteedDay  +                       -- Срок поставщика из API
                                                              isnull(o.DeliveryDaysReserve2, o.DeliveryDaysReserve) +                  -- Запас до вылета
                                                              o.DeliveryTermFromSupplierProfile-       -- Доставка
                                                              iif(o.Flag&16>0, o.DeliveryTermToCustomer, o.DeliveryTermFromCustomerProfile) -- Срок клиента 
                                                              ) > 0            
                                                          then '(+' 
                                                          else '(' 
                                                      end +
                                                             cast(((datediff(day, o.OrderDate, getdate()) + -- дней в обработке
                                                              p.GuaranteedDay  +                            -- Срок поставщика из API
                                                              isnull(o.DeliveryDaysReserve2, o.DeliveryDaysReserve) +                       -- Запас до вылета
                                                              o.DeliveryTermFromSupplierProfile-            -- Доставка
                                                              iif(o.Flag&16>0, o.DeliveryTermToCustomer, o.DeliveryTermFromCustomerProfile) -- Срок клиента 
                                                              )) as varchar)     
                                                      +') | ' + 
        convert(varchar, p.PercentSupped) + '%' as Name,
       p.Price
  from vOrders o (nolock)
 inner join pFindByNumber p (nolock) 
         on p.spid = @@SPid
        and p.Make = o.MakeLogo
 inner join tSuppliers s (nolock)
         on s.SuppliersID = o.SuppliersID
 where o.OrderID = @OrderID
 order by Price

  exit_:
  return @r

go
grant exec on OrderF_SupplierList to public
go
exec setOV 'OrderF_SupplierList', 'P', '20250204', '6'
go
 
exec OrderF_SupplierList @OrderID=183012