if OBJECT_ID('OrdersToReturnPartial') is not null
    drop proc OrdersToReturnPartial
/*
  OrdersToReturnPartial - частичный возврат
*/
go
create proc OrdersToReturnPartial
              @OrderID  numeric(18, 0)
             ,@Quantity int

as
  set nocount on;

  declare @r               int = 0
         ,@NewOrderID      numeric(18, 0)

 
  if isnull(@Quantity, 0) > 0
  begin
  exec OrderSplitting
          @OrderID  = @OrderID
          ,@Quantity = @Quantity
          ,@NewOrderID = @NewOrderID out

  delete tMarks 
    from tMarks (rowlock) 
   where spid= @@spid 
     and type = 3

  if isnull(@NewOrderID, 0) > 0
      Insert into tMarks with (rowlock) 
              (Spid, Type, ID) 
      select @@Spid, 3, @NewOrderID
  end

 exit_:
 return @r
go
grant exec on OrdersToReturnPartial to public;
go
exec setOV 'OrdersToReturnPartial', 'P', '20250416', '8';
go
 