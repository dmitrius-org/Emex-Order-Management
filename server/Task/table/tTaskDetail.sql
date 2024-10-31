--if OBJECT_ID('tTaskDetail') is null
--/* **********************************************************
--drop table tTaskDetail
--********************************************************** */
--begin
--	create table tTaskDetail
--	(
--	 TaskDetailID     numeric(18,0)  identity --  
--    ,TaskID           numeric(18,0) -- 
--    ,TaskActionsID    numeric(18,0) -- 
--	,Message          nvarchar(2000)
--	,Flag             int         
--	,InDatetime       datetime default GetDate()      --
--	)

--	create unique index ao1 on tTaskDetail(TaskDetailID)

--	create index ao2 on tTaskDetail(TaskID)

--	grant all on tTaskDetail to public
--end
--go
--exec setOV 'tTaskDetail', 'U', '20241031', '0'
--go
---- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'tTaskDetail', @desc = 'Детальная информация о выполнении задачи'
