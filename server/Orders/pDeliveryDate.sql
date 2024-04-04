if OBJECT_ID('pDeliveryDate') is not null
  drop table pDeliveryDate
/* **********************************************************
pDeliveryDate - Ближайшая дата доставки
********************************************************** */
create table pDeliveryDate
(
 Spid                 numeric(18,0)  
,ID                   numeric(18,0)  
,OrderDate            datetime       -- Дата заказа	
,Delivery             int
,ProfilesDeliveryID   numeric(18, 0)
,DeliveryDate     datetime           -- Ближайшая дата вылета	
)
go
create unique index ao1 on pDeliveryDate(Spid, ID)
go
grant select on pDeliveryDate to public
go
exec setOV 'pDeliveryDate', 'U', '20240403', '1'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pDeliveryDate', @desc = 'Сроки поставки'
