if OBJECT_ID('tGroups') is null
--drop table tGroups
/* **********************************************************
tGroups - Группы пользователей
********************************************************** */
begin
	create table tGroups
	(
	 GroupID       numeric(18,0)  identity --  
	,Brief         nvarchar(512)  not null --
	,Name          nvarchar(512)  null  -- 

	,inDatetime        datetime default GetDate()      --
	,updDatetime       datetime default GetDate()      --
	)

	create unique index ao1 on tGroups(GroupID) include (Brief, Name)

	create unique index ao2 on tGroups(Brief)

	grant all on tGroups to public
end
go
exec setOV 'tGroups', 'U', '20240101', '1.0.0.0'
go

