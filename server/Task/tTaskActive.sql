if OBJECT_ID('tTaskActive') is null
--drop table tTaskActive
/* **********************************************************
********************************************************** */
begin
	create table tTaskActive
	(
	  IsActive             bit
	);
	grant all on tTaskActive to public;
	
	insert tTaskActive 
	select 0
	where not exists (select 1 from tTaskActive);

	select * from tTaskActive;

	-- Описание таблицы
	exec dbo.sys_setTableDescription @table = 'tTaskActive', @desc = 'Активность планировщика задач';
end
