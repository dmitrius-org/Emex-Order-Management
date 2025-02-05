if OBJECT_ID('tOrdersDepartureDate') is null
/*
  --ALTER TABLE tOrdersDepartureDate SET ( SYSTEM_VERSIONING = OFF )
  --drop table tOrdersDepartureDate
  --DROP TABLE History.tOrdersDepartureDate
--*/
/* **********************************************************
tOrdersDeliverySupplier - Сроки доставки поставщика
********************************************************** */
begin
    create table tOrdersDepartureDate
    (
    OrderID                         numeric(18,0) --
    -- блок сроков 
    ,DeliveryDaysReserve             int            -- Дней запаса до вылета
    ,DeliveryNextDate                datetime       -- Ближайшая дата вылета

    ,UserID                          numeric(18,0) default dbo.GetUserID()
    ,ValidFrom                       DATETIME2 GENERATED ALWAYS AS ROW START
    ,ValidTo                         DATETIME2 GENERATED ALWAYS AS ROW END
    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tOrdersDepartureDate_OrderID PRIMARY KEY CLUSTERED (OrderID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tOrdersDepartureDate));
end
go
grant select on tOrdersDepartureDate to public
go
exec setOV 'tOrdersDepartureDate', 'U', '20250204', '0'
go

-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tOrdersDepartureDate', @desc = 'Сроки вылета'