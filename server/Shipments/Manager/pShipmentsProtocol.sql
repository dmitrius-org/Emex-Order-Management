drop table if exists pShipmentsProtocol
go
/* **********************************************************
pShipmentsProtocol - 
********************************************************** */
create table pShipmentsProtocol
(
 Spid              numeric(18,0)  not null  
,ShipmentsID       numeric(18,0)  not null
,ActionID          numeric(18,0)  
,OperDate          DateTime
,ProtocolID        numeric(18,0)  
,StateID           numeric(18,0) 
,NewStateID        numeric(18,0)  
,Retval            numeric(18,0)  default 0 
,Message	       nvarchar(1024) 
,Flag              int
,ord               int            default 1
,sgn               int            -- признак для понимания где сделали insert - 0
)
go
create index ao1 on pShipmentsProtocol(Spid, ShipmentsID, ActionID)
go
create index ao2 on pShipmentsProtocol(Spid, Retval)
go
grant all on pShipmentsProtocol to public
go
exec setOV 'pShipmentsProtocol', 'U', '20240708', '10'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pShipmentsProtocol', @desc = 'Временная таблица протокола по отгрузкам'
