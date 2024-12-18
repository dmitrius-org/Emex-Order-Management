if OBJECT_ID('System.tObjectVersion') is null
/*
  ALTER TABLE System.tObjectVersion SET ( SYSTEM_VERSIONING = OFF )
  DROP TABLE System.tObjectVersion
  DROP TABLE History.tObjectVersion
*/
/* **********************************************************
tObjectVersion - Версии объектов системы
********************************************************** */
begin
	create table System.tObjectVersion
	(
	 ObjectVersionID      numeric(18,0)  identity--
	,ObjectName           nvarchar(255)  not null-- 
	,ObjectDate           datetime     
	,ObjectTypeID         numeric(18,0)
	,[Version]            int
	,[Type]               nvarchar(2)
	,[InDatetime]         datetime2    
	,[UpdDatetime]        datetime2    
    ,[ValidFrom]          DATETIME2 GENERATED ALWAYS AS ROW START
    ,[ValidTo]            DATETIME2 GENERATED ALWAYS AS ROW END

    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tObjectVersion_ID PRIMARY KEY CLUSTERED (ObjectVersionID)
    )
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.tObjectVersion));

	grant select on System.tObjectVersion to public;
end
go
--exec setOV 'tObjectVersion', 'U', '20240310', '1'
go
