if OBJECT_ID('tAudit') is null
--drop table tAudit
/* **********************************************************
tAudit - Аудит действий пользователя
********************************************************** */
begin
	create table tAudit
	(
	 AuditID           numeric(18, 0) identity  --
	,ObjectTypeID      numeric(18, 0)   -- тип объекта 
	,ObjectID          numeric(18, 0)   -- ИД объекта по которому ведется аудит
	,ActionID          numeric(18, 0)   -- ИД выполняемое дейстие из tAction
	,Comment           varchar(1024)
    ,Flag              int
	,UserID            numeric(18, 0)   -- 
	,HostInfoID        varchar(256) null
	,InDateTime        DateTime2  default sysdatetime()   -- 
	)

	create index ao1 on tAudit(UserID, ObjectID)

	create index ao2 on tAudit(ObjectTypeID, ObjectID)

	grant select on tAudit to public
end
go
exec setOV 'tAudit', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tAudit', @desc = 'Таблица аудита'


/*
ALTER TABLE tAudit DROP CONSTRAINT DF__tAudit__InDateTi__5EDF0F2E;

ALTER TABLE tAudit 
ALTER COLUMN InDateTime DateTime2;

ALTER TABLE tAudit 
ADD CONSTRAINT DF_tAudit_InDateTime DEFAULT SYSDATETIME() FOR InDateTime;
*/