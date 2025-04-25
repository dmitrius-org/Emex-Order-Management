if OBJECT_ID('tLogMsg') is not null
  drop table tLogMsg
/* **********************************************************
tLogMsg - Таблица логирования


********************************************************** */
go
begin
	create table tLogMsg
	(
	 LogMsgID         numeric(18, 0) identity  --
    
    ,ThreadId         integer 
	,UserID           numeric(18, 0)    -- 
	,EventDate        DateTime -- Клиентское логирование
	,EventType        varchar(20) -- Серверное логирование (sql)
    ,Msg              varchar(max)

    ,Environment      varchar(50)
    ,PlaftormInfo     varchar(128)
    ,OSVersion        varchar(128)
    ,Host             varchar(20)
    ,UserName         varchar(128)
    ,AppName          varchar(50)
	);

	create unique index ao1 on tLogMsg(LogMsgID);

	create index ao2 on tLogMsg(UserID, AppName);

	grant all on tLogMsg to public;
end
go
exec setOV 'tLogMsg', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tLogMsg', @desc = 'Таблица логирования'
-- Описание полей
exec dbo.sys_setTableDescription 'tLogMsg', 'LogMsgID'                 ,'Уникальный идентификатор'
