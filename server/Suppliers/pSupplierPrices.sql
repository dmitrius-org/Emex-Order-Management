if OBJECT_ID('pSupplierPrices') is not null
  drop table pSupplierPrices
/* **********************************************************
pSupplierPrices - Прайсы
********************************************************** */
go
create table pSupplierPrices
(
 Spid              numeric(18, 0) 
,ID                numeric(18, 0) identity
,SupplierPricesID  numeric(18, 0) 
,SuppliersID	   numeric(18, 0)
,Name              varchar(30) not null 
,Comment           varchar(256) 
,DeliveryTerm	   int            -- Срок доставки
,DeliveryType	   varchar(30)   -- Тип доставки
,InWorkingDays     bit            -- Срок указан в рабочих днях
,ShowInSearch      bit            -- Не оказывать на форме поиска
,Flag              int
);

create unique index a1 on pSupplierPrices (ID);

create unique index a2 on pSupplierPrices (Spid, SuppliersID, Name);

go
grant all on pSupplierPrices to public
go
exec setOV 'pSupplierPrices', 'U', '20250618', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pSupplierPrices', @desc = 'Таблица прайс листов поставщика'

