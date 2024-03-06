if OBJECT_ID('tUnloadRefusals') is null
/* **********************************************************
tUnloadRefusals - Таблица отказов
********************************************************** */
begin
	create table tUnloadRefusals
	(
	 OperDate             datetime -- дата выгрузки ответа
	,FileName             nvarchar(256)  
	,ClientID             numeric(18, 0)
	,ClientName           nvarchar(512)
	,OrderNum             nvarchar(128)
	,MakeLogo             nvarchar(32)
	,DetailNumber         nvarchar(128)
	,Reference            nvarchar(128)
	,DetailID             nvarchar(128)
	,Quantity             int 
	,PricePurchase        money
	,AmountPurchase       money
	,Flag                 int
	,InDateTime           DateTime default GetDate()
	)

	create index ao2 on tUnloadRefusals(OperDate)

	create index ao3 on tUnloadRefusals(ClientID, DetailNumber, Reference, DetailID)
end
go
grant all on tUnloadRefusals to public
go
exec setOV 'tUnloadRefusals', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tUnloadRefusals', @desc = 'Таблица отказов'