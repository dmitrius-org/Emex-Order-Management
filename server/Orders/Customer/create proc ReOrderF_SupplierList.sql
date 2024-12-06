drop proc if exists ReOrderF_SupplierList
/*
  ReOrderF_SupplierList - Список поставщиков для формы перезаказа
*/
go
create proc ReOrderF_SupplierList
               @OrderID  numeric(18,0)            
              
as
declare @r int = 0

select p.ID
      ,p.Name
from (

Select 
       o.PriceLogo  + '.' +  o.MakeLogo  as ID,
       o.PriceLogo + ' | ' + 
       FORMAT(o.Price, '# ##0.00 руб') + ' | ' + 
       convert(varchar, isnull(o.DeliveryRestTermSupplier, datediff(dd,getdate(), o.DeliveryPlanDateSupplier) )) + ' дней ' +' | ' + 
       convert(varchar, o.Reliability) + '%'  +' | ' + 
       convert(varchar(20), o.Quantity) as Name,
       o.Price
  from tOrders o (nolock)
 where o.OrderID =@OrderID
   and not exists (select 1
                     from pFindByNumber p (nolock) 
                    where p.spid      = @@SPid
                      and p.PriceLogo = o.PriceLogo
                      and p.Make      = o.MakeLogo
                   )
 Union all
select 
       o.PriceLogo  + '.' +  o.MakeLogo  as ID,
       o.PriceLogo + ' | ' + 
       FORMAT(o.PriceRub, '# ##0.00 руб') + ' | ' +  +
       convert(varchar(20), o.OurDelivery) + ' дней  | ' + 
        convert(varchar(20), o.PercentSupped) + '% | ' + 
       case 
         when o.Available = -1 then 'под заказ'
         else cast(o.Available as varchar)
       end  as Name,
       o.PriceRub
  from tOrders t with (nolock index=ao1)
 inner join vFindByNumber o (nolock)
         on o.MakeLogo = t.MakeLogo 
 where t.OrderID =@OrderID
) p
order by p.Price
 --where MakeName        = :MakeName 
 --  and DetailNum       = :DetailNum
 --  and DestinationLogo = :DestinationLogo  

 exit_:
 return @r

go
grant exec on ReOrderF_SupplierList to public
go
exec setOV 'ReOrderF_SupplierList', 'P', '20241206', '2'
go

exec ReOrderF_SupplierList @OrderID=167044