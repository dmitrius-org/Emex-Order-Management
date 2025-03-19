if OBJECT_ID('ApiBasketDeleteP', 'P') is not null
    drop proc ApiBasketDeleteP	 
go
/* --------------------------------------------------------
  ApiBasketInsertP - 
-------------------------------------------------------- */
create proc ApiBasketDeleteP
              -- @ClientID     numeric(18, 0)   
as
set nocount on;

declare @RetVal       int  = 0

DELETE pBasket 
  FROM pBasket with (rowlock index=ao2) 
 WHERE Spid = @@Spid
       
exit_:
return @RetVal    
go
grant exec on ApiBasketDeleteP to public
go
exec setOV 'ApiBasketDeleteP', 'P', '20250319', '0'
go
 