if OBJECT_ID('vEmployees') is not null
    drop view vEmployees
go
/* **********************************************************						
vEmployees - получение списка сотрудников
********************************************************** */

create view vEmployees

as

select e.EmployeeID      
      ,e.Brief       
      ,e.Name	     

  from tEmployees e (nolock)

go
grant all on vEmployees to public

