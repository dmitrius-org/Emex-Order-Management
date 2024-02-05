if OBJECT_ID('tGrant') is null
--drop table tGrant
/* **********************************************************
tGrant - Права 
********************************************************** */
create table tGrant
(
 GrantID           numeric(18, 0) identity  --
,ObjectID          numeric(18, 0)   -- 
,MenuID            numeric(18, 0)   -- 
,ObjectType        int -- 0 -- пользователь
                       -- 1 -- группа
)
go
create unique index ao1 on tGrant(ObjectType, ObjectID, MenuID)
go
--create unique index ao2 on tGrant(ObjectID, MenuID)
go
grant all on tGrant to public
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tGrant', @desc = 'Права доступа пользователя к приложению'
