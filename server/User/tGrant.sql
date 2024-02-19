if OBJECT_ID('tGrant') is null
--drop table tGrant
/* **********************************************************
tGrant - Права 
********************************************************** */
begin
	create table tGrant
	(
	 GrantID           numeric(18, 0) identity  --
	,ObjectID          numeric(18, 0)   -- 
	,MenuID            numeric(18, 0)   -- 
	,ObjectType        int -- 0 -- пользователь
						   -- 1 -- группа
	)

	create unique index ao1 on tGrant(ObjectType, ObjectID, MenuID)

	grant all on tGrant to public
end
go
exec setOV 'tGrant', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tGrant', @desc = 'Права доступа пользователя к приложению'
