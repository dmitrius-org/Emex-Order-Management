if OBJECT_ID('tClientGridOptions') is null
--drop table tClientGridOptions
/* **********************************************************
tClientGridOptions - настройки таблиц
********************************************************** */
begin
	create table tClientGridOptions
	(
	 [ClientID]         numeric(18,0)  not null --  
	,[Grid]             nvarchar(60)   not null --  -- 
	,[Column]           nvarchar(60)   not null --  -- 
	,[Position]         int               
	,[Width]            int
	,[Visible]          bit
	,[Locking]          bit
	)
	
	create unique index ao1 on tClientGridOptions(ClientID, Grid, [Column])
	
	grant all on tClientGridOptions to public
end
go
exec setOV 'tClientGridOptions', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tClientGridOptions', @desc = 'Настройки таблиц'
