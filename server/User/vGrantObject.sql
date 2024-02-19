if OBJECT_ID('vGrantObject') is not null
    drop view vGrantObject
go
/* **********************************************************						
vGrantObject - права на объекты учета
********************************************************** */
create view vGrantObject
as

Select p.ObjectType
      ,p.ObjectID
      ,p.LinkType
      ,c.ClientID
      ,c.Brief as ClientBrief
      ,c.Name  as ClientName
  from pGrantObject p (nolock)
 inner join tClients c (nolock)
         on c.ClientID = p.LinkID
 where p.Spid     = @@spid
   and p.LinkType = 7 -- 'Клиенты'

go
grant all on vGrantObject to public
go
exec setOV 'vGrantObject', 'V', '20240101', '1.0.0.0'
go
 
