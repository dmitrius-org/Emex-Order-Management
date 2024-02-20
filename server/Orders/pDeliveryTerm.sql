if OBJECT_ID('pDeliveryTerm') is not null
  drop table pDeliveryTerm
/* **********************************************************
pDeliveryTerm - Сроки поставки
********************************************************** */
create table pDeliveryTerm
(
 Spid                      numeric(18,0)  
,OrderID                   numeric(18,0)  
,ClientID                  numeric(18,0)  -- Клиент	
,OrderDate                 datetime       -- Дата заказа	
,PriceLogo                 nvarchar(30)
,DeliveryTerm              int
,DestinationLogo	       nvarchar(30)
,ProfilesDeliveryID        numeric(18, 0)
	
,DeliveryPlanDateSupplier  datetime       -- Плановая дата поступления поставщику	
,DeliveryRestTermSupplier  int            -- Остаток срока до поступления поставщику	
,DeliveredDateToSupplier   datetime       -- Доставлена поставщику


,DeliveryDaysReserve       int            -- Дней запаса до вылета	
,DeliveryNextDate          datetime       -- Ближайшая дата вылета	
,DeliveryDateToCustomer    datetime       -- Дата поставки клиенту	
,DeliveryTermToCustomer    int            -- Срок поставки клиенту	
,DeliveryRestToCustomer    int            -- Остаток срока до поставки клиенту


)
go
create unique index ao1 on pDeliveryTerm(Spid, OrderID)
go
grant select on pDeliveryTerm to public
go
exec setOV 'pDeliveryTerm', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pDeliveryTerm', @desc = 'Сроки поставки'
