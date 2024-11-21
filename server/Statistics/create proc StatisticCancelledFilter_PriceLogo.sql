if OBJECT_ID('StatisticCancelledFilter_PriceLogo') is not null
    drop proc StatisticCancelledFilter_PriceLogo
/*
  StatisticCancelledFilter_PriceLogo - 
*/
go
create proc StatisticCancelledFilter_PriceLogo
as
    declare @r int = 0

    SELECT distinct
           PriceLogo Name
      FROM [tOrders] (nolock)
     where PriceLogo is not null
     order by PriceLogo     

 exit_:
 return @r
go
grant exec on StatisticCancelledFilter_PriceLogo to public
go
exec setOV 'StatisticCancelledFilter_PriceLogo', 'P', '20241020', '1'
go


exec StatisticCancelledFilter_PriceLogo
