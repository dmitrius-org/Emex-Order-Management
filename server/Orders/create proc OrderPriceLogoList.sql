if OBJECT_ID('OrderPriceLogoList') is not null
    drop proc  OrderPriceLogoList
/*
   OrderPriceLogoList -
*/
go
create proc  OrderPriceLogoList
as
  declare @r          int = 0

  SELECT distinct
         0         ID,
         PriceLogo Name
    FROM [tOrders] (nolock)
   where PriceLogo is not null
   order by PriceLogo
 
 exit_:
 return @r
go
grant exec on  OrderPriceLogoList to public
go
exec setOV ' OrderPriceLogoList', 'P', '20250601', '0'
go
-- exec OrderPriceLogoList
