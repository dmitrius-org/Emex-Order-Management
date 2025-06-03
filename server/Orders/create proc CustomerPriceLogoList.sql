if OBJECT_ID('CustomerPriceLogoList') is not null
    drop proc  CustomerPriceLogoList
/*
   CustomerPriceLogoList -
*/
go
create proc  CustomerPriceLogoList
as
  declare @r          int = 0

  SELECT distinct
         0                 ID,
         CustomerPriceLogo Name
    FROM [tOrders] (nolock)
   where PriceLogo is not null
   order by CustomerPriceLogo
 
 exit_:
 return @r
go
grant exec on  CustomerPriceLogoList to public
go
exec setOV ' CustomerPriceLogoList', 'P', '20250601', '0'
go
--exec CustomerPriceLogoList
