if OBJECT_ID('tOrderRefusals') is null
begin
/* **********************************************************
tOrderRefusals - Таблица отказов
********************************************************** */
	create table tOrderRefusals
	(
	 OrderRefusalsID      numeric(18,0)  identity --  
	,FileName             nvarchar(256)  
	,Flag                 int
	,UserID               numeric(18,0) default dbo.GetUserID()
	,InDateTime           DateTime default GetDate()
	,UpdDateTime          DateTime default GetDate()
	)

	create unique index ao1 on tOrderRefusals(OrderRefusalsID)
end
go
grant all on tOrderRefusals to public
go
exec setOV 'tOrderRefusals', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tOrderRefusals', @desc = 'Таблица отказов'