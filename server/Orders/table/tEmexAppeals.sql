if OBJECT_ID('tAutoCallsToEmex') is not null
begin
  ALTER TABLE tAutoCallsToEmex SET ( SYSTEM_VERSIONING = OFF )
  drop table  tAutoCallsToEmex
  DROP TABLE  History.tAutoCallsToEmex
end
--*/
/* **********************************************************
tAutoCallsToEmex - 
********************************************************** */
begin
	create table tAutoCallsToEmex
	(
     ID                    numeric(18,0)  identity --
    ,OrderID               numeric(18,0)  -- Заказ
    ,Type                  int -- тип запроса:  0 - уточнение срока доставки; 1 - запрос отказа
    --,ClientID              numeric(18,0)  -- Клиент tClients.ClientID
    --,SuppliersID           numeric(18,0)  -- Поставщик tSuppliers.SuppliersID
    --,Manufacturer          varchar(64)    -- Производитель
    --,DetailNumber          varchar(32)    -- Номер детали
    --,DetailID              varchar(32)    -- ID Детали
    --,Reference             varchar(32)    -- Reference
    --,Quantity              int            -- Количество деталей    
    ,StatusID              int              -- Cтатус обращения в emex: 0 - открыто, 1 - в ожидании, 2 - закрыто
    ,Number                varchar(32)    -- Номер обращения в emex
    ,Message               varchar(max)
    ,InDateTime            datetime       -- Дата протокола с временем
    ,UpdDateTime           datetime       -- Дата последнего обновления протокола с временем
     --
    ,[ValidFrom]           DATETIME2 GENERATED ALWAYS AS ROW START
    ,[ValidTo]             DATETIME2 GENERATED ALWAYS AS ROW END

    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tAutoCallsToEmex_ID PRIMARY KEY CLUSTERED (ID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tAutoCallsToEmex));

    create index ao1 on tAutoCallsToEmex(OrderID);

	grant all on tAutoCallsToEmex to public;
end
go
exec setOV 'tAutoCallsToEmex', 'U', '20250221', '0'
go
exec dbo.sys_setTableDescription @table = 'tAutoCallsToEmex', @desc = 'Автоматические обращения в emex'
