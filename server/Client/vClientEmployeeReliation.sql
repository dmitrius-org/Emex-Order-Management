if OBJECT_ID('vClientEmployeeReliation') is not null
    drop view vClientEmployeeReliation
go
/* **********************************************************						
vClientEmployeeReliation - связанные менеджеры
********************************************************** */
create view vClientEmployeeReliation
as

select p.ID	        ID 
      ,p.ClientID   ClientID
      ,u.UserID     EmployeeID
      ,u.Name       EmployeeBrief      
  from pClientReliation p (nolock)
  left join tUser u (nolock)
         on u.UserID = p.LinkID
 where p.Spid     = @@spid

go
grant all on vClientEmployeeReliation to public
go
exec setOV 'vClientEmployeeReliation', 'V', '20240101', '1.0.0.0'
go
