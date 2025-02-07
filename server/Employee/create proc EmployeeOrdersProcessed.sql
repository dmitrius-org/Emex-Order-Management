if OBJECT_ID('EmployeeOrdersProcessed') is not null
    drop proc EmployeeOrdersProcessed
/*
  EmployeeOrdersProcessed - 
*/
go

Create proc EmployeeOrdersProcessed
             @OrderID       numeric(18,0)
            ,@Flag          int = null
as
 declare @r int = 0

--копирование протоколов для новых записей
insert tEmployeeOrdersProcessed with (rowlock)
      (OrderID    
      ,EmployeeID     
      ,Flag       
      ,InDateIime)
Select @OrderID   
      ,dbo.GetUserID()    
      ,@Flag      
      ,GetDate()--

  exit_:

  return @r
GO
grant exec on EmployeeOrdersProcessed to public
go
exec setOV 'EmployeeOrdersProcessed', 'P', '20250207', '0'
go
 