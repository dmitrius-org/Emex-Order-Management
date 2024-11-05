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
      ,p.ObjectType ObjectType
  from pClientReliation p (nolock)
 inner join tUser u (nolock)
         on u.UserID     = p.LinkID 
        and p.ObjectType = 0
  where p.Spid     = @@spid
union all
select p.ID	        ID 
      ,p.ClientID   ClientID
      ,u.UserID     EmployeeID
      ,u.Name       EmployeeBrief 
      ,p.ObjectType ObjectType
  from pClientReliation p (nolock)
  inner join tGroups g (nolock)
          on g.GroupID= p.LinkID 
  inner join tUserReliation ur (nolock)
          on ur.GroupID = g.GroupID
         and ur.LinkType= 2 
  inner join tUser u (nolock)
          on u.UserID    = ur.UserID 
         and p.ObjectType = 1 
  where p.Spid     = @@spid
go
grant all on vClientEmployeeReliation to public
go
exec setOV 'vClientEmployeeReliation', 'V', '20241105', '1'
go

select * 
  from vClientEmployeeReliation 
 where ClientID = 86