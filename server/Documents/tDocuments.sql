if OBJECT_ID('tDocuments') is null
/*
  ALTER TABLE tDocuments SET ( SYSTEM_VERSIONING = OFF )
  --drop table tDocuments
  DROP TABLE History.tDocuments
*/
/* **********************************************************
tDocuments - 
********************************************************** */
begin
	create table tDocuments
	(
	 DocumentID          numeric(18,0)  identity -- 
	,ClientID            numeric(18,0)  
	,Number              nvarchar(255)  null  --
	,Date                datetime
	,Amount              money
	,Comment	         nvarchar(512)  null  -- 
    ,PayType             int            --     Тип оплаты
	,Type                int            --     1 - дебит
								        --    -1 - кредит   
	--
	,Flag                int
	,UserID              numeric(18,0) default dbo.GetUserID()
	,inDatetime          datetime      default GetDate()
	,updDatetime         datetime      default GetDate()

    ,[ValidFrom]          DATETIME2 GENERATED ALWAYS AS ROW START
    ,[ValidTo]            DATETIME2 GENERATED ALWAYS AS ROW END

    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tDocuments_DocumentID PRIMARY KEY CLUSTERED (DocumentID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tDocuments));

	create index ao2 on tDocuments(ClientID);

	grant all on tDocuments to public;
end
go
exec setOV 'tDocuments', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tDocuments', @desc = 'Таблица '