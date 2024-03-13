if OBJECT_ID('tTaskActions') is null
/* **********************************************************
tTaskActions - действия автоматических заданий
********************************************************** */
begin
	create table tTaskActions
	(
	 TaskActionsID    numeric(18,0)  identity --  
	,TaskID           numeric(18,0)   --  
    ,Number           int      --
    ,Comment          nvarchar(255)       -- 
	,TaskType         int                -- тип задачи
	,IsActive         bit
	,LinkID           numeric(18,0)
	,Field            nvarchar(max)
	,Flag             int         
	,inDatetime       datetime default GetDate()      --
	,updDatetime      datetime default GetDate()      --
	);

	create unique index ao1 on tTaskActions(TaskActionsID);

	create index ao2 on tTaskActions(TaskID);

	grant all on tTaskActions to public;
end
go
exec setOV 'tTaskActions', 'U', '20240101', '0';
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tTaskActions', @desc = 'Действия для задачи';
