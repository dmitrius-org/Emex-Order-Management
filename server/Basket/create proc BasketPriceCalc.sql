if OBJECT_ID('BasketPriceCalc', 'P') is not null
    drop proc BasketPriceCalc	 
go
/* --------------------------------------------------------
  BasketPriceCalc - расчет цены 
-------------------------------------------------------- */
create proc BasketPriceCalc
              @BasketID	numeric(18, 0)
as
set nocount on;

declare @RetVal             int
       ,@ProfilesCustomerID numeric(18, 0)

select @ProfilesCustomerID = b.ProfilesCustomerID
  from tBasket b (nolock)
 where b.BasketID=@BasketID

exec SearchPriceCalc
       @ProfilesCustomerID = @ProfilesCustomerID

update b
   set b.PriceRub        = o.PriceRub
      ,b.Amount          = b.Quantity * o.PriceRub
      ,b.OurDelivery     = o.OurDelivery
      ,b.InDateTime      = getDate()
  from tBasket b (nolock)
 inner join pFindByNumber o (nolock)
         on o.Spid      = @@SPID
        and o.Make      = b.Make
        and o.DetailNum = b.DetailNum

        and o.ProfilesCustomerID = @ProfilesCustomerID 
        and o.PriceLogo = b.PriceLogo
        
 where b.BasketID=@BasketID

exit_:
return @RetVal    
go
grant all on BasketPriceCalc to public
go
exec setOV 'BasketPriceCalc', 'P', '20250529', '3'
go
