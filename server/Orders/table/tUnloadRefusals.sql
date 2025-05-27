if OBJECT_ID('tUnloadRefusals') is null
/*
  ALTER TABLE tUnloadRefusals SET ( SYSTEM_VERSIONING = OFF )
  drop table tUnloadRefusals
  DROP TABLE History.tUnloadRefusals
--*/
/* **********************************************************
tUnloadRefusals - Таблица отказов
********************************************************** */
begin
	create table tUnloadRefusals
	( 
     UnloaRefusalID       numeric(18,0) identity--
	,OperDate             datetime -- дата выгрузки ответа
	,FileName             nvarchar(256)  
	,ClientID             numeric(18, 0)
	,ClientName           nvarchar(512)
	,OrderNum             nvarchar(128)
	,MakeLogo             nvarchar(32)
	,DetailNumber         nvarchar(128)
	,Reference            nvarchar(128)
	,DetailID             nvarchar(128)
	,Quantity             int 
	,PricePurchase        money
	,AmountPurchase       money
	,Flag                 int
    ,ValidFrom            DATETIME2 GENERATED ALWAYS AS ROW START
    ,ValidTo              DATETIME2 GENERATED ALWAYS AS ROW END
    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tUnloadRefusals_OrderID PRIMARY KEY CLUSTERED (UnloaRefusalID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tUnloadRefusals));

	create index ao2 on tUnloadRefusals(OperDate)

	create index ao3 on tUnloadRefusals(ClientID, DetailNumber, Reference, DetailID)
end
go
grant all on tUnloadRefusals to public
go
exec setOV 'tUnloadRefusals', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tUnloadRefusals', @desc = 'Таблица истории отказов'