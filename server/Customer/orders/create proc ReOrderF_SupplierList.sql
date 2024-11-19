drop proc if exists ReOrderF_SupplierList
/*
  ReOrderF_SupplierList - Список поставщиков
*/
go
create proc ReOrderF_SupplierList
               @OrderID  numeric(18,0)            
              
as
declare @r int = 0

Select 
       o.PriceLogo  + '.' +  o.MakeLogo  as ID,
       o.PriceLogo + ' | ' + 
       convert(varchar, o.Price) + ' руб | ' + 
       convert(varchar, isnull(o.DeliveryRestTermSupplier, datediff(dd,getdate(), o.DeliveryPlanDateSupplier) )) + ' дней ' +' | ' + 
       convert(varchar, o.Reliability) + '%'  +' | ' + 
       convert(varchar(20), o.Quantity) as Name
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
       convert(varchar(20), o.PriceRub) + ' руб | ' +
       convert(varchar(20), o.OurDelivery) + ' дней  | ' + 
        convert(varchar(20), o.PercentSupped) + '% | ' + 
       case 
         when o.Available = -1 then 'под заказ'
         else cast(o.Available as varchar)
       end  as Name
  from vFindByNumber o (nolock)
-- where o.OrderID =@OrderID
 --order by Price


 --where MakeName        = :MakeName 
 --  and DetailNum       = :DetailNum
 --  and DestinationLogo = :DestinationLogo  

 exit_:
 return @r

go
grant exec on ReOrderF_SupplierList to public
go
exec setOV 'ReOrderF_SupplierList', 'P', '20241119', '1'
go

exec ReOrderF_SupplierList @OrderID=159911