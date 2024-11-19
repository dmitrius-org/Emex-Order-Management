drop proc if exists IsCancelApproval
/*
  IsCancelApproval - проверки перед созданием заказа


  @OrderID  - ид заказа
*/
go

create proc IsCancelApproval  
              @OrderID numeric(15, 0)
as
declare @r int = 0

  Update o
     set o.Flag = o.Flag | 4096 -- Отказ подтвержден
    from tOrders o (updlock)
   where o.OrderID = @OrderID

  exit_:

  return @r
GO
grant exec on IsCancelApproval to public
go
exec setOV 'IsCancelApproval', 'P', '20241118', '1'
go
 




