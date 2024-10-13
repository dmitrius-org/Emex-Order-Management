if OBJECT_ID('tChatsMessage') is null
/* **********************************************************
tChatsMessage - Таблица 

drop table tChatsMessage
********************************************************** */
begin
	create table tChatsMessage
	(
	 MessageID   numeric(18, 0) identity
    ,ChatID      numeric(18, 0)
	,ClientID    numeric(18, 0)
    ,UserID      numeric(18, 0)
	,Message     nvarchar(512)
	,Flag        int
	,InDateTime  DateTime2 default sysdatetime()
	);

	create index ao1 on tChatsMessage(MessageID);

	create index ao2 on tChatsMessage(ChatID);

    create index ao3 on tChatsMessage(ClientID);
end
go
grant all on tChatsMessage to public
go
exec setOV 'tChatsMessage', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tChatsMessage', @desc = 'Таблица'