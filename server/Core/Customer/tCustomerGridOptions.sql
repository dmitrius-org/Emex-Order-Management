if OBJECT_ID('tCustomerGridOptions') is null
--drop table tCustomerGridOptions
/* **********************************************************
tCustomerGridOptions - настройки таблиц
********************************************************** */
begin
	create table tCustomerGridOptions
	(
	 ClientID         numeric(18,0)  not null --  
	,Grid             nvarchar(60)   not null --  -- 
	,[Column]         nvarchar(60)   not null --  -- 
	,Position         int               
	,Width            int
	,Visible          bit
	,Locking          bit
	)
	
	create unique index ao1 on tCustomerGridOptions(ClientID, Grid, [Column])
	
	grant all on tCustomerGridOptions to public
end
go
exec setOV 'tCustomerGridOptions', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tCustomerGridOptions', @desc = 'Настройки таблиц'
