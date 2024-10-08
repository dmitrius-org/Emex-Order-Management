if OBJECT_ID('tChats') is null
/* **********************************************************
tChats - Таблица 
drop table tChats
********************************************************** */
begin
	create table tChats
	(
	 ChatID      numeric(18, 0) identity
	,ClientID    numeric(18, 0)
    ,OrderID     numeric(18, 0)
	,Flag        int
    ,InDateTime  datetime2 default SYSDATETIME()
	)

	create index ao1 on tChats(ChatID)

	create index ao2 on tChats(ClientID)
end
go
grant all on tChats to public
go
exec setOV 'tChats', 'U', '20241007', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tChats', @desc = 'Таблица'