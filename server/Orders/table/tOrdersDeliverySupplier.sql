if OBJECT_ID('tOrdersDeliverySupplier') is null
/*
  --ALTER TABLE tOrdersDeliverySupplier SET ( SYSTEM_VERSIONING = OFF )
  --drop table tOrdersDeliverySupplier
  --DROP TABLE History.tOrdersDeliverySupplier
--*/
/* **********************************************************
tOrdersDeliverySupplier - Сроки доставки поставщика
********************************************************** */
begin
    create table tOrdersDeliverySupplier
    (
    OrderID                         numeric(18,0) --

    -- блок сроков доставки
    ,DeliveryPlanDateSupplier        datetime       -- Плановая дата поступления поставщику
    ,DeliveryRestTermSupplier        int            -- Остаток срока до поступления поставщику
    ,DeliveryTermSupplier            int            -- Срок доставки поставщику

    ,UserID                          numeric(18,0) default dbo.GetUserID()
    ,ValidFrom                       DATETIME2 GENERATED ALWAYS AS ROW START
    ,ValidTo                         DATETIME2 GENERATED ALWAYS AS ROW END
    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tOrdersDeliverySupplier_OrderID PRIMARY KEY CLUSTERED (OrderID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tOrdersDeliverySupplier));

end
go
grant select on tOrdersDeliverySupplier to public
go
exec setOV 'tOrdersDeliverySupplier', 'U', '20250204', '0'
go

-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tOrdersDeliverySupplier', @desc = 'Сроки доставки'