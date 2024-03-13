if OBJECT_ID('vUserRelated') is not null
    drop view vUserRelated
go
/* **********************************************************						
vUserRelated - вхождение пользователя в группы
********************************************************** */
create view vUserRelated
as

--SET DATEFIRST 1;

select u.UserID
      ,u.Brief    UserBrief
      ,u.Name     UserName
      ,g.GroupID
      ,g.Brief    GroupBrief
      ,g.Name     GroupName
  from tUserReliation ug (nolock) 
 inner join tGroups g (nolock) 
         on g.GroupID = ug.GroupID

 inner join tUser u (nolock) 
         on u.UserID = ug.UserID                      
 where ug.LinkType = 2 
             
go
grant all on vUserRelated to public
go
exec setOV 'vUserRelated', 'V', '20240101', '0'
go
 


--select * from vUsers
