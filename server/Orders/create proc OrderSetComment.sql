drop proc if exists OrderSetComment
/*
  OrderSetComment - 

*/
go
create proc OrderSetComment
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
                         then isnull(t.Flag, 0) &~ 32
                         else isnull(t.Flag, 0) | 32 -- ��������� ��� �������
                     end 
	from tOrders t (updlock)
   where t.OrderID       = @OrderID

  if isnull(@Comment, '') = '' 
    set @Comment = '���������'
  else
    set @Comment = '����������� �� ������: ' + @Comment

  -- �����
  exec AuditInsert
              @AuditID          = @AuditID out         
             ,@ObjectID         = @OrderID
             ,@ObjectTypeID     = 3
             ,@ActionID         = 24 -- acMessage
             ,@Comment          = @Comment

 exit_:
 return @r
go
grant exec on OrderSetComment to public
go
