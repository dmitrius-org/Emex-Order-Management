if OBJECT_ID('tTaskActions') is null
/* **********************************************************
drop table tTaskActions
********************************************************** */
begin
	create table tTaskActions
	(
	 TaskActionsID    numeric(18,0)  identity --  
	,TaskID           numeric(18,0)   --  
    ,Number           int      --
    ,Comment          nvarchar(255)       -- 
	,TaskType         int                -- тип задачи
	--,PeriodType       int
	--,DateBegin        datetime
	--,DateExec         datetime
	--,TimeBegin        Time
	--,TimeEnd          Time
	--,DayPeriod        int
	--,TimePeriod       Time
	,IsActive         bit
	--,Message          nvarchar(1000)
	,LinkID           numeric(18,0)

	,Field            nvarchar(max)
	,Flag             int         
	,inDatetime       datetime default GetDate()      --
	,updDatetime      datetime default GetDate()      --
	)

	create unique index ao1 on tTaskActions(TaskID)

	--create index ao2 on tTaskActions(tTaskActions)

	grant all on tTask to public
end
go
exec setOV 'tTaskActions', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tTaskActions', @desc = 'Действия для задачи'