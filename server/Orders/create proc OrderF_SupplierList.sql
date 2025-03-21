drop proc if exists OrderF_SupplierList
go
create proc OrderF_SupplierList
               @OrderID            numeric(18,0)
              ,@ProfilesDeliveryID numeric(18,0)
/*
  OrderF_SupplierList - Список поставщиков
*/           
as
  declare @r int = 0

Select 
       convert(varchar, o.PriceLogo  + '.' +  o.MakeLogo)  as ID,
       s.Brief + ' | ' + 
       o.PriceLogo + ' | ' +
       '$' + convert(varchar, coalesce(o.PricePurchaseF, o.PricePurchase, 0)) + ' | ' + 
       convert(varchar, o.Quantity) + '/' + isnull(convert(varchar, p.Quantity), '-') + ' | ' + -- количество
       convert(varchar, isnull(o.DeliveryRestTermSupplier, datediff(dd,getdate(), o.DeliveryPlanDateSupplier) )) + ' дней ' +' | ' + 
       convert(varchar, o.Reliability) + '%' as Name
       ,0 as Price
       ,0 as Flag
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
       convert(varchar, p.PriceLogo + '.' + p.Make)  as ID,
       o.SuppliersBrief + ' | ' + 
       p.PriceLogo + ' | ' +
       '$' + convert(varchar, p.Price) + ' | ' + 
       convert(varchar, o.Quantity) + '/' + convert(varchar, isnull(p.Available, '-'))  + ' (' + cast(p.Packing as varchar) + ') | ' + -- количество
       convert(varchar, p.GuaranteedDay) + ' дней ' + case 
                                                        when  (datediff(day, o.OrderDate, getdate()) + -- дней в обработке
                                                              p.GuaranteedDay  +                       -- Срок поставщика из API
                                                              isnull(o.DeliveryDaysReserve2, o.DeliveryDaysReserve) + -- Запас до вылета
                                                              cp.DeliveryTermFromSupplier -            -- Доставка -- Срок доставки с профиля доставки поставщика
                                                              iif(o.Flag&16>0, o.DeliveryTermToCustomer, o.DeliveryTermFromCustomerProfile) -- Срок клиента 
                                                              ) > 0            
                                                          then '(+' 
                                                          else '(' 
                                                      end +
                                                             cast(((datediff(day, o.OrderDate, getdate()) + -- дней в обработке
                                                              p.GuaranteedDay  +                            -- Срок поставщика из API
                                                              isnull(o.DeliveryDaysReserve2, o.DeliveryDaysReserve) + -- Запас до вылета
                                                              cp.DeliveryTermFromSupplier -                 -- Доставка -- Срок доставки с профиля доставки поставщика
                                                              iif(o.Flag&16>0, o.DeliveryTermToCustomer, o.DeliveryTermFromCustomerProfile) -- Срок клиента 
                                                              )) as varchar)     
                                                      +') | ' + 
        convert(varchar, p.PercentSupped) + '%' as Name ,
       p.Price,
       iif( p.PriceLogo=pl.PriceLogo, 1, 0)
  from vOrders o (nolock)
 inner join pFindByNumber p (nolock) 
         on p.spid = @@SPid
        and p.Make = o.MakeLogo
 inner join vSupplierDeliveryParam cp
         on cp.ProfilesDeliveryID = @ProfilesDeliveryID
 outer apply (Select o2.PriceLogo
                from tOrders o2 (nolock)
               where o2.ParentID  = o.OrderID
                 and o2.PriceLogo = p.PriceLogo
                 and isnull(o2.Flag, 0)&524288 >0 -- деталь разделена на части менеджером
             ) as pl


 where o.OrderID = @OrderID
 order by Price

  exit_:
  return @r

go
grant exec on OrderF_SupplierList to public
go
exec setOV 'OrderF_SupplierList', 'P', '20250320', '10'
go
