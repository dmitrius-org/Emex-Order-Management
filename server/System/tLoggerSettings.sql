if OBJECT_ID('tLoggerSettings') is null
/* **********************************************************
tLoggerSettings - Настройки логирования

drop table tLoggerSettings
********************************************************** */
begin
	create table tLoggerSettings
	(
	 LoggerSettingsID  numeric(18, 0) identity  --
	,UserID            numeric(18, 0) not null   -- 
    ,AppName           varchar(30)
    ,LogDestination    varchar(64)
    ,LogSql            bit
    ,FileLogLevel      varchar(256)
    ,DBLogLevel        varchar(256)
	);

	create unique index ao1 on tLoggerSettings(LoggerSettingsID);

	create unique index ao2 on tLoggerSettings(UserID, AppName);

	grant all on tLoggerSettings to public;
end
go
exec setOV 'tLoggerSettings', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tLoggerSettings', @desc = 'Настройки логирования'
-- Описание полей
exec dbo.sys_setTableDescription 'tLoggerSettings', 'LoggerSettingsID'                 ,'Уникальный идентификатор'
exec dbo.sys_setTableDescription 'tLoggerSettings', 'UserID'                           ,'Идентификатор пользователя'
exec dbo.sys_setTableDescription 'tLoggerSettings', 'AppName'                          ,'Приложение'