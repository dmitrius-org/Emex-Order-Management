if OBJECT_ID('tTask') is null
--drop table tTask
/* **********************************************************

********************************************************** */
begin
	create table tTask
	(
	 TaskID           numeric(18,0)  identity --  
	,Brief            nvarchar(60)       --
	,Name	          nvarchar(128)       -- 
	,TaskType         int                -- тип задачи
	,PeriodType       int
	,DateBegin        datetime
	,DateExec         datetime
	,TimeBegin        Time
	,TimeEnd          Time
	,DayPeriod        int
	,TimePeriod       Time
	,IsActive         bit
	,Message          nvarchar(1000)
	,LinkID           numeric(18,0)
	,Field            nvarchar(max)
	,Flag             int         
	,inDatetime       datetime default GetDate()      --
	,updDatetime      datetime default GetDate()      --
	)

	create unique index ao1 on tTask(TaskID)

	create index ao2 on tTask(Brief)

	grant all on tTask to public
end
go
exec setOV 'tTask', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tTask', @desc = 'Задачи'