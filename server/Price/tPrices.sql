if OBJECT_ID('tPrices') is null
/* **********************************************************						
tPrices - список прайсов 
********************************************************** */
begin
	create table tPrices
	(
	 Name           nvarchar(30) not null 
	,Comment        nvarchar(256) 
	,DeliveryTerm	int            -- Срок доставки
	,DeliveryType	nvarchar(30)   -- Тип доставки
	,InWorkingDays  bit            -- Срок указан в рабочих днях
	,ShowInSearch   bit            -- Не оказывать на форме поиска
	,Flag           int

	);

	create unique index a1 on tPrices (Name);

	grant all on tPrices to public;
end
go
go
exec setOV 'tPrices', 'U', '20240101', '0'
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tPrices', @desc = 'Список прайсов'
-- Описание полей
exec dbo.sys_setTableDescription 'tPrices', 'Name',                'Наименование прайса'
