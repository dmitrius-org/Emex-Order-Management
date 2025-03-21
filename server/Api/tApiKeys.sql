if OBJECT_ID('tApiKeys') is null
/*
  ALTER TABLE tApiKeys SET ( SYSTEM_VERSIONING = OFF )
  --drop table tApiKeys
  DROP TABLE History.tApiKeys
*/
/* **********************************************************
tApiKeys - Таблица для хранения API-ключей
********************************************************** */
begin
	create table tApiKeys
	(	 
     ApiKeysID            INT IDENTITY
    ,ClientID             numeric(18,0) NOT NULL 
    ,Name                 VARCHAR(255)  NOT NULL
    ,ApiKey               VARCHAR(255)  NOT NULL
    ,Flag                 int
	,inDatetime           datetime      default GetDate() --
     --
    ,[ValidFrom]          DATETIME2 GENERATED ALWAYS AS ROW START
    ,[ValidTo]            DATETIME2 GENERATED ALWAYS AS ROW END

    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tApiKeys_ApiKeysID PRIMARY KEY CLUSTERED (ApiKeysID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tApiKeys));

	create index ao1 on tApiKeys(ClientID);-- include (Brief, Name);

    create unique index ao2 on tApiKeys(ApiKey);-- include (Brief, Name);

	grant all on tApiKeys to public;
end
go
exec setOV 'tApiKeys', 'U', '20240101', '0'
go
exec dbo.sys_setTableDescription @table = 'tApiKeys', @desc = 'Таблица для хранения API-ключей'
