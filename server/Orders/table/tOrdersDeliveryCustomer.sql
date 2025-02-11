if OBJECT_ID('tOrdersDeliveryCustomer') is null
/*
  ALTER TABLE tOrdersDeliveryCustomer SET ( SYSTEM_VERSIONING = OFF )
  drop table tOrdersDeliveryCustomer
  DROP TABLE History.tOrdersDeliveryCustomer
--*/
/* **********************************************************
tOrdersDeliveryCustomer - Сроки доставки Клиента
********************************************************** */
begin
    create table tOrdersDeliveryCustomer
    (
     OrderID                 numeric(18,0) --
    ,DeliveryTermToCustomer int      -- Срок поставки клиенту
    ,DeliveryDateToCustomer datetime -- Дата поставки клиенту	
    ,DeliveryRestToCustomer int      -- Остаток срока до поставки клиенту

    ,UserID                 numeric(18,0) default dbo.GetUserID()
    ,ValidFrom              DATETIME2 GENERATED ALWAYS AS ROW START
    ,ValidTo                DATETIME2 GENERATED ALWAYS AS ROW END
    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tOrdersDeliveryCustomer_OrderID PRIMARY KEY CLUSTERED (OrderID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tOrdersDeliveryCustomer));
end
go
grant select on tOrdersDeliveryCustomer to public
go
exec setOV 'tOrdersDeliveryCustomer', 'U', '20250204', '0'
go

-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tOrdersDeliveryCustomer', @desc = 'Сроки доставки клиента'