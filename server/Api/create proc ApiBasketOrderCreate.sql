if OBJECT_ID('ApiBasketOrderCreate', 'P') is not null
    drop proc ApiBasketOrderCreate	 
go
/* --------------------------------------------------------
  ApiBasketOrderCreate - 
-------------------------------------------------------- */
create proc ApiBasketOrderCreate
               @ClientID         numeric(18, 0),
               @PaymentMethod    varchar(32)  = null,
               @ShipmentMethod   varchar(32)  = null,
               @ShipmentAddress  varchar(32)  = null,
               @ShipmentOffice   varchar(32)  = null,
               @ShipmentDate     DateTime     = null,
               @Comment          varchar(512) = null,
               @OrderNum         varchar(32)  = null out
  
as
set nocount on;

declare @RetVal int = 0

delete tMarks from tMarks with (rowlock index=pk_tMarks) where Spid = @@Spid;

insert tMarks with (rowlock)
      (Spid
      ,Type
      ,ID)
select @@Spid
      ,6
      ,BasketID
  from tBasket b  with (nolock index=ao2)
 where b.ClientID = @ClientID

if @@ROWCOUNT = 0
begin
    set @RetVal =  706 -- 'Нет позиций для заказа!'
    goto exit_
end


exec @RetVal = OrderCreateFromBasket
                 @OrderNum = @OrderNum out

if isnull(@OrderNum, '') <> ''
  Update tOrders
     set flag       = isnull(flag, 0) | 1048576 -- Заказ через АПИ
         ,Comment3  = @Comment
    from tOrders with (updlock index=ao2)
   where ClientID = @ClientID
     and OrderNum = @OrderNum

exit_:
return @RetVal    
go
grant exec on ApiBasketOrderCreate to public
go
exec setOV 'ApiBasketOrderCreate', 'P', '20250318', '0'
go
 