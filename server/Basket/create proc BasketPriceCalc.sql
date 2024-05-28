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

declare @RetVal            int
       ,@DestinationLogo   nvarchar(20)
	   ,@DetailNum         nvarchar(40)

  select @DestinationLogo = b.DestinationLogo
        ,@DetailNum       = b.DetailNum
    from tBasket b (nolock)
   where b.BasketID=@BasketID

  exec SearchPriceCalc
         @DestinationLogo = @DestinationLogo
        ,@DetailNum       = @DetailNum

  update b
     set b.PriceRub        = o.PriceRub
        ,b.Amount          = b.Quantity * o.PriceRub
        ,b.OurDelivery     = o.OurDelivery
        ,b.InDateTime      = getDate()
    from tBasket b (nolock)
   inner join pFindByNumber o (nolock)
           on o.Spid = @@SPID
          and o.DestinationLogo = b.DestinationLogo
          and o.DetailNum       = b.DetailNum
          and o.Make            = b.Make
   where b.BasketID=@BasketID

exit_:
return @RetVal    
go
grant all on BasketPriceCalc to public
go
exec setOV 'BasketPriceCalc', 'P', '20240528', '1'
go
