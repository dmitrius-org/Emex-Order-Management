if OBJECT_ID('tRestrictions') is null
--drop table tRestrictions
/* **********************************************************
tRestrictions - список ограничений 
********************************************************** */
begin
	create table tRestrictions
	(
	 Name           varchar(30)
	,Flag           int
	);

	create unique index a1 on tRestrictions(Name);

	grant all on tRestrictions to public;
end
go
exec setOV 'tRestrictions', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tRestrictions', @desc = 'Список ограничений'
-- Описание полей
exec dbo.sys_setTableDescription 'tRestrictions', 'Name',                'Наименование ограничения'
