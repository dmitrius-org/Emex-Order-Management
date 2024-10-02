drop table if exists pAccrualAction
go
/* **********************************************************
pAccrualAction - 
********************************************************** */
create table pAccrualAction
(
 Spid              numeric(18,0)  not null  
,ObjectID          numeric(18,0)  not null
,ActionID          numeric(18,0)  
,OperDate          DateTime
,ProtocolID        numeric(18,0)  
,StateID           numeric(18,0) 
,NewStateID        numeric(18,0)  
,Retval            numeric(18,0)  default 0 
,Message	       nvarchar(1024) 
,Flag              int
,ord               int            default 1
,sgn               int            -- признак для понимания где сделали insert - 10
)
go
create index ao1 on pAccrualAction(Spid, ObjectID, ActionID)
go
create index ao2 on pAccrualAction(Spid, Retval)
go
grant all on pAccrualAction to public
go
exec setOV 'pAccrualAction', 'U', '20240708', '10'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pAccrualAction', @desc = 'Временная таблица для выполнения действий'
