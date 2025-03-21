if OBJECT_ID('tAutoCallsToEmexDetail') is not null
begin
  DROP TABLE  tAutoCallsToEmexDetail
end
--*/
/* **********************************************************
tAutoCallsToEmexDetail - 
********************************************************** */
begin
	create table tAutoCallsToEmexDetail
	(
     ID                    numeric(18,0)  identity --
    ,Subject               varchar(256)   -- Тема
    ,Status                varchar(32)    -- Cтатус обращения в emex
    ,Number                varchar(32)    -- Номер обращения в emex
    ,DetailNumber          varchar(32)    -- Номер детали
    ,Author                varchar(128)   -- Автор
    ,Type                  int            -- Тип сообщения: 0 - от нас; 1- от них 
    ,EmexOrderID           integer        -- Номер заказа emex
    ,Message               varchar(max)   -- Тело сообщения
    ,InDateTime            datetime       -- Дата
    ,UpdDateTime           datetime       -- Дата последнего обновления протокола с временем
	)

    create index ao1 on tAutoCallsToEmexDetail(ID);

    create index ao2 on tAutoCallsToEmexDetail(Number);

	grant all on tAutoCallsToEmexDetail to public;
end
go
exec setOV 'tAutoCallsToEmexDetail', 'U', '20250221', '0'
go
--exec dbo.sys_setTableDescription @table = 'tAutoCallsToEmexDetail', @desc = 'Автоматические обращения в emex'
