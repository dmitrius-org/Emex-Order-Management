if OBJECT_ID('vCustomerOrders') is not null
    drop view vCustomerOrders
go
if OBJECT_ID('CustomerOrdersSelect') is not null
    drop proc CustomerOrdersSelect
go
/* **********************************************************						
CustomerOrdersSelect - список заказов
********************************************************** */

create proc CustomerOrdersSelect
              @Page            int = null
as
SET NOCOUNT ON; 
select @Page = isnull(@Page, 1)

SELECT o.*
  FROM #OrderPage op with (nolock)
 inner join vCustomerOrders o
         on o.OrderID = op.OrderID
 where op.Page = @Page 
 order by op.OrderID desc 
go
grant exec on CustomerOrdersSelect to public
go
exec setOV 'CustomerOrdersSelect', 'P', '20250224', '0'
go
