if OBJECT_ID('OrderSplittingSupplierValid') is not null
    drop proc OrderSplittingSupplierValid
go
/*
  OrderSplitting - 
*/
Create proc OrderSplittingSupplierValid
              @OrderID     numeric(18, 0)
             ,@PriceLogo   varchar(40)

as
  declare @r int = 0
  
  if exists (
            Select 1
             from tOrders (nolock)
            where ParentID  = @OrderID
              and PriceLogo = @PriceLogo
              and isnull(Flag, 0)&524288 >0 -- деталь разделена на части менеджером
             )
  begin
    select @r = 547 -- 'Необходимо выбрать другого поставщика, так как выбран тот же поставщик, что и в основном заказе!'
    goto exit_
  end
  
  exit_:

  return @r
GO
grant exec on OrderSplittingSupplierValid to public
go
exec setOV 'OrderSplittingSupplierValid', 'P', '20250206', '0'
go
 