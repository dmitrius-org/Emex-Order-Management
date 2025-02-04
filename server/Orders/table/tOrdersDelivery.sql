  ALTER TABLE tOrdersDelivery SET ( SYSTEM_VERSIONING = OFF )
  --drop table tOrdersDelivery
  DROP TABLE History.tOrdersDelivery
  go
if OBJECT_ID('tOrdersDelivery') is not null
  drop table tOrdersDelivery
go
  --ALTER TABLE tOrdersDelivery SET ( SYSTEM_VERSIONING = OFF )
  --drop table tOrdersDelivery
  --DROP TABLE History.tOrdersDelivery
--*/
go
/* **********************************************************
tOrdersDelivery - Сроки доставки
********************************************************** */
begin
    create table tOrdersDelivery
    (
    OrderID                         numeric(18,0) --

    -- блок сроков доставки
    ,DeliveryPlanDateSupplier        datetime       -- Плановая дата поступления поставщику
    ,DeliveryRestTermSupplier        int            -- Остаток срока до поступления поставщику
    --,DeliveredDateToSupplier         datetime       -- Доставлена поставщику
    ,DeliveryTermSupplier            int            -- Срок доставки поставщику

    --,DeliveryDaysReserve             int            -- Дней запаса до вылета
    --,DeliveryDaysReserve2            int            -- Дней запаса до вылета, рассчитывается если прошел срок DeliveryNextDate
    --,DeliveryNextDate                datetime       -- Ближайшая дата вылета
    --,DeliveryNextDate2               datetime       -- Ближайшая дата вылета, рассчитывается если прошел срок DeliveryNextDate

    --,DeliveryDateToCustomer          datetime       -- Дата поставки клиенту
    --,DeliveryDateToCustomer2         datetime       -- Дата поставки клиенту после изменения
    --,DeliveryTermToCustomer          int            -- Срок поставки клиенту
    --,DeliveryTermToCustomer2         int            -- Срок поставки клиенту после изменения
    --,DeliveryRestToCustomer          int            -- Остаток срока до поставки клиенту

    --,DateDeparture                   datetime       -- Дата вылета 
    --,DaysInWork                      int            -- Дней в работе
    --,DateInWork                      datetime       -- Дата перехода в работу

    ,UserID                          numeric(18,0) default dbo.GetUserID()
   -- ,inDatetime                      datetime      default GetDate()--
   -- ,updDatetime                     datetime      default GetDate()--

    ,[ValidFrom]                     DATETIME2 GENERATED ALWAYS AS ROW START
    ,[ValidTo]                       DATETIME2 GENERATED ALWAYS AS ROW END
    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tOrdersDelivery_OrderID PRIMARY KEY CLUSTERED (OrderID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tOrdersDelivery));

    --create unique index ao1 on tOrdersDelivery(OrderID);

    --create index ao2 on tOrdersDelivery(ClientID, OrderNum);

--    create index ao3 on tOrdersDelivery(Invoice);
end
go
grant select on tOrdersDelivery to public
go
exec setOV 'tOrdersDelivery', 'U', '20250204', '0'
go

-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tOrdersDelivery', @desc = 'Сроки доставки'