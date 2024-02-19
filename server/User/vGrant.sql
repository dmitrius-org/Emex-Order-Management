if OBJECT_ID('vGrant') is not null
    drop view vGrant
go
/* 						
vGrant - права
 */

create view vGrant
as
--
select u.GrantID           
      ,u.ObjectID 
      ,u.ParentID
      ,u.MenuID         
      ,u.N
      ,u.Caption	           
      ,u.Value
      ,u.Type
      ,m.Name
      ,u.IsGroup
      ,u.Groups
      ,u.GroupValue
  from pGrant u with (nolock index=ao1)
 inner join tMenu m with (nolock index=ao1)
         on m.MenuID = u.MenuID
 where u.spid = @@Spid

go
grant all on vGrant to public
go
exec setOV 'vGrant', 'V', '20240101', '1.0.0.0'
go
 
