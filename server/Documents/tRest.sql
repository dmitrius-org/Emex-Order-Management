if OBJECT_ID('tRest') is null
  --drop table tRest
/* **********************************************************
tRest - 
********************************************************** */
create table tRest
(
 ClientID   numeric(18,0)  -- 
,Amount       money
)
go
create index ao1 on tRest(ClientID) include (Amount)
go
grant all on tRest to public
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tRest', @desc = 'Таблица '
