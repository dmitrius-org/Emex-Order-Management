drop proc if exists EmployeeOrdersProcessedT_EmployeeList
go
create proc EmployeeOrdersProcessedT_EmployeeList        
/*
  OrderF_SupplierList - Список поставщиков
*/           
as
  declare @r int = 0


select 
       u.UserID as ID
      ,u.Brief
      ,u.Name
  
  from tUser u (nolock)
 order by u.isBlock
         ,u.Name

  exit_:
  return @r

go
grant exec on EmployeeOrdersProcessedT_EmployeeList to public
go
exec setOV 'EmployeeOrdersProcessedT_EmployeeList', 'P', '20250204', '1'
go
 
exec EmployeeOrdersProcessedT_EmployeeList