if OBJECT_ID('tRest') is null
  --drop table tRest
/* **********************************************************
tRest - 
********************************************************** */
begin
create table tRest
(
 ClientID   numeric(18,0)  -- 
,Amount       money
);

create index ao1 on tRest(ClientID) include (Amount);

grant all on tRest to public;
end
go
exec setOV 'tRest', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tRest', @desc = 'Таблица '
