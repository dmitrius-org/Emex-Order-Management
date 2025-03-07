if OBJECT_ID('ApiBasketClear', 'P') is not null
    drop proc ApiBasketClear	 
go
/* --------------------------------------------------------
  ApiBasketClear - 
-------------------------------------------------------- */
create proc ApiBasketClear
               @ClientID     numeric(18, 0)
    
as
set nocount on;

declare @RetVal   int  = 0

DELETE tBasket 
  FROM tBasket (rowlock) 
 WHERE ClientID = @ClientID 

exit_:
return @RetVal    
go
grant exec on ApiBasketClear to public
go
exec setOV 'ApiBasketClear', 'P', '20240605', '0'
go
 