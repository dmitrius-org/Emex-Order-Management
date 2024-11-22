if OBJECT_ID('StatisticCancelledFilter_OrderPriceLogo') is not null
    drop proc StatisticCancelledFilter_OrderPriceLogo
/*
  StatisticCancelledFilter_OrderPriceLogo - поставщик из заказа
*/
go
create proc StatisticCancelledFilter_OrderPriceLogo
as
    declare @r int = 0

    SELECT distinct
           CustomerPriceLogo Name
      FROM [tOrders] (nolock)
     where CustomerPriceLogo is not null
     order by CustomerPriceLogo     

 exit_:
 return @r
go
grant exec on StatisticCancelledFilter_OrderPriceLogo to public
go
exec setOV 'StatisticCancelledFilter_OrderPriceLogo', 'P', '20241020', '1'
go


exec StatisticCancelledFilter_OrderPriceLogo
