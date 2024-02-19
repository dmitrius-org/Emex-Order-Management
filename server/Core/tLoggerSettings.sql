if OBJECT_ID('tLoggerSettings') is null
/* **********************************************************
tLoggerSettings - Настройки логирования
********************************************************** */
begin
	create table tLoggerSettings
	(
	 LoggerSettingsID           numeric(18, 0) identity  --
	,UserID                     numeric(18, 0) not null   -- 
	--,AppServerLog               bit -- Сервер приложения UniServerModule
	,AppClientLog               bit -- Клиентское логирование
	,AppSqlLog                  bit -- Серверное логирование (sql)
	);

	create unique index ao1 on tLoggerSettings(LoggerSettingsID);

	create unique index ao2 on tLoggerSettings(UserID);

	grant all on tLoggerSettings to public;
end
go
exec setOV 'tLoggerSettings', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tLoggerSettings', @desc = 'Настройки логирования'
-- Описание полей
exec dbo.sys_setTableDescription 'tLoggerSettings', 'LoggerSettingsID'                 ,'Уникальный идентификатор'
exec dbo.sys_setTableDescription 'tLoggerSettings', 'UserID'                           ,'Идентификатор пользователя'
exec dbo.sys_setTableDescription 'tLoggerSettings', 'AppClientLog'                     ,'Клиентское логирование'
exec dbo.sys_setTableDescription 'tLoggerSettings', 'AppSqlLog'                        ,'Серверное логирование (sql)'
