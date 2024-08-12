if OBJECT_ID('tOrderRefusalsDetail') is null
begin
/* **********************************************************

********************************************************** */
	create table tOrderRefusalsDetail
	(
	 ID                   numeric(18,0)  identity -- 
	,OrderRefusalsID      numeric(18,0)           --
	,OrderID              numeric(18,0)           --
	,Quantity             int
	,Flag                 int                     --
	);

	create unique index ao1 on tOrderRefusalsDetail(ID);

	create index ao2 on tOrderRefusalsDetail(OrderRefusalsID, OrderID);
end
go
grant all on tOrderRefusalsDetail to public
go
exec setOV 'tOrderRefusalsDetail', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tOrderRefusalsDetail', @desc = 'Таблица детализации по отказам'