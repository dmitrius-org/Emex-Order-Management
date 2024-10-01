if OBJECT_ID('tGrantObject') is null
--drop table tGrantObject
/* **********************************************************
tGrantObject - Права 
********************************************************** */
begin
	create table tGrantObject
	(
	 GrantObjectID     numeric(18, 0) identity  --
	,ObjectID          numeric(18, 0)           -- ИД группы или пользователя
	,ObjectType        int                      -- 0 - пользователь
												-- 1 - группа
	,LinkID            numeric(18, 0)           -- Связанный объект
	,LinkType          int                      -- Тип объекта                       
	)

	create unique index ao1 on tGrantObject(ObjectType, ObjectID, LinkType, LinkID)

	grant all on tGrantObject to public
end
go
exec setOV 'tGrantObject', 'U', '20240101', '0'
go

-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tGrantObject', @desc = 'Права доступа пользователя к объектам системы'