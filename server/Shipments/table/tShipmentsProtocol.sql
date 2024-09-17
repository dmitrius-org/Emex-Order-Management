if OBJECT_ID('tShipmentsProtocol') is null
--  drop table tShipmentsProtocol
/* **********************************************************
tShipmentsProtocol - Таблица протокола
********************************************************** */
begin
	create table tShipmentsProtocol
	(
	 ShipmentsProtocolID    numeric(18, 0) identity  --
	,ShipmentsID       numeric(18, 0)   -- Объект
	,StateID           numeric(18, 0)   -- Предыдущее состояние
	,NewStateID        numeric(18, 0)   -- Текущее состояние 
	,ActionID          numeric(18, 0)   -- ИД выполняемое дейстие из tAction
	,OperDate          DateTime         -- Дата протокола
	,Comment           nvarchar(1024)   -- Комментарий
    ,Flag              int
	,UserID            numeric(18, 0)   -- Пользователь
	,InDateTime        DateTime default getdate()   -- 
	);

	create index ao1 on tShipmentsProtocol(ShipmentsProtocolID);

	create index ao2 on tShipmentsProtocol(ShipmentsID);

	grant select on tShipmentsProtocol to public;
end
go
exec setOV 'tShipmentsProtocol', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tShipmentsProtocol', @desc = 'Таблица протокола отгрузок'

