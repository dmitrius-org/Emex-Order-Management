if OBJECT_ID('tSupplierPrices') is null
/* **********************************************************
tSupplierPrices - Прайсы
********************************************************** */
begin
	create table tSupplierPrices
	(
     SupplierPricesID  numeric(18, 0) identity
    ,SuppliersID	   numeric(18, 0)
	,Name              varchar(30) not null 
	,Comment           varchar(256) 
	,DeliveryTerm	   int            -- Срок доставки
	,DeliveryType	   varchar(30)   -- Тип доставки
	,InWorkingDays     bit            -- Срок указан в рабочих днях
	,ShowInSearch      bit            -- Не оказывать на форме поиска
	,Flag              int

	);

    create unique index a1 on tSupplierPrices (SupplierPricesID);

	create unique index a2 on tSupplierPrices (SuppliersID, Name);
end
go
grant all on tSupplierPrices to public
go
exec setOV 'tSupplierPrices', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tSupplierPrices', @desc = 'Таблица прайс листов поставщика'

