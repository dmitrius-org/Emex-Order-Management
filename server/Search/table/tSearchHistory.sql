if OBJECT_ID('tSearchHistory') is null
--  drop table tSearchHistory
/* **********************************************************
tSearchHistory - История поиска
********************************************************** */
begin
	create table tSearchHistory
	(
	 SearchHistoryID   numeric(18,0) identity
	,ClientID          numeric(18,0)
	,DetailNum         varchar(40)
    --,InDateTime        datetime
	);

	create index ao1 on tSearchHistory (ClientID);

	grant all on tSearchHistory to public;
end
go
exec setOV 'tSearchHistory', 'U', '20240327', '1'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tSearchHistory', @desc = ' История поиска деталей'

