if OBJECT_ID('tTaskActive') is null
/* **********************************************************
********************************************************** */
begin
	create table tTaskActive
	(
	  IsActive             bit
	);
	grant all on tTaskActive to public;
end
go
exec setOV 'tTaskActive', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tTaskActive', @desc = 'Активность планировщика задач';

insert tTaskActive 
select 0
where not exists (select 1 from tTaskActive);