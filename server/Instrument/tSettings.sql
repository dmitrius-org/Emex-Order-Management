if OBJECT_ID('tSuppliers') is null
--  drop table tSuppliers
/* **********************************************************
tSettings - Настройки приложения
********************************************************** */
begin
	create table tSettings
	(
	 SettingsID        numeric(18,0)  identity -- Ид
	,GroupID           numeric(18,0)
	,Brief             nvarchar(64)   not null -- сокращение
	,Name	           nvarchar(128)  not null -- Наименование
	,Comment           nvarchar(256)  not null -- Комментарий
	,Val               nvarchar(1024) not null -- Значение
	,SettingType       int                     -- Тип данных
	)

	create unique index ao1 on tSettings(SettingsID)

	create unique index ao2 on tSettings(Brief)

	grant all on tSettings to public
end
go
exec setOV 'tSettings', 'U', '20240101', '0'
go
exec dbo.sys_setTableDescription @table = 'tSettings', @desc = 'Настройки приложения'
go
