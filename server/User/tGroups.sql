if OBJECT_ID('tGroups') is null
--drop table tGroups
/* **********************************************************
tGroups - Группы пользователей
********************************************************** */
create table tGroups
(
 GroupID       numeric(18,0)  identity --  
,Brief         nvarchar(512)  not null --
,Name          nvarchar(512)  null  -- 

,inDatetime        datetime default GetDate()      --
,updDatetime       datetime default GetDate()      --
)
go
create unique index ao1 on tGroups(GroupID) include (Brief, Name)
go
create unique index ao2 on tGroups(Brief)
go
grant all on tGroups to public
go
