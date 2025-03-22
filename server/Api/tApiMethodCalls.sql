if OBJECT_ID('tApiMethodCalls') is null
/*
  ALTER TABLE tApiMethodCalls SET ( SYSTEM_VERSIONING = OFF )
  drop table tApiMethodCalls
  DROP TABLE History.tApiMethodCalls
*/
/* **********************************************************
tApiMethodCalls - Таблица для подсчета вызовов методов
********************************************************** */
begin
	create table tApiMethodCalls
	(	 
     ApiMethodCallsID     INT IDENTITY
    ,ClientID             numeric(18,0) NOT NULL
    ,ApiKey               VARCHAR(64)   NOT NULL
    ,MethodName           VARCHAR(64)   NOT NULL
    
    ,CallCount            INT           NOT NULL DEFAULT 0
     --
    ,[ValidFrom]          DATETIME2 GENERATED ALWAYS AS ROW START
    ,[ValidTo]            DATETIME2 GENERATED ALWAYS AS ROW END
    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
    ,CONSTRAINT PK_tApiMethodCalls_ID PRIMARY KEY CLUSTERED (ApiMethodCallsID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tApiMethodCalls));

    create unique index ao1 on tApiMethodCalls(ClientID, ApiKey, MethodName)

	grant select on tApiMethodCalls to public;
end
go
exec setOV 'tApiMethodCalls', 'U', '20240101', '0'
go
exec dbo.sys_setTableDescription @table = 'tApiMethodCalls', @desc = 'Таблица для подсчета вызовов методов'
