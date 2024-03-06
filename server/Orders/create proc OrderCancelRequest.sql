drop proc if exists OrderCancelRequest
/*
  OrderCancelRequest - 

*/
go
create proc OrderCancelRequest
               @OrderID       numeric(18,0)
              ,@Comment       nvarchar(2048)          
as
  set nocount on;

  declare @r       int = 0
		 ,@AuditID  numeric(18,0)

  update t
     set t.Comment = nullif(@Comment, '')
        ,t.Flag    = case 
                       when isnull(@Comment, '') = '' 
                         then isnull(t.Flag, 0) &~ 64
                         else isnull(t.Flag, 0) | 64 -- Запрошен отказ
                     end 
	from tOrders t (updlock)
   where t.OrderID       = @OrderID

  set @Comment = 'Запрос на отказ: ' + @Comment

  -- аудит
  exec AuditInsert
              @AuditID          = @AuditID out         
             ,@ObjectID         = @OrderID
             ,@ObjectTypeID     = 3
             ,@ActionID         = 5 -- acCancel
             ,@Comment          = @Comment

 exit_:
 return @r
go
grant exec on OrderCancelRequest to public
go
exec setOV 'OrderCancelRequest', 'P', '20240101', '1.0.0.1'
go
 