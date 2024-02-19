if OBJECT_ID('tGridOptions') is null
--drop table tGridOptions
/* **********************************************************
tGridOptions - настройки таблиц
********************************************************** */
begin
	create table tGridOptions
	(
	 UserID           numeric(18,0)  not null --  
	,Grid             nvarchar(60)   not null --  -- 
	,[Column]         nvarchar(60)   not null --  -- 
	,Position         int               
	,Width            int
	,Visible          bit
	,Locking          bit
	)
	
	create unique index ao1 on tGridOptions(UserID, Grid, [Column])
	
	grant all on tGridOptions to public
end
go
exec setOV 'tGridOptions', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tGridOptions', @desc = 'Настройки таблиц'
