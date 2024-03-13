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
	,Comment           nvarchar(1024)
	,UserID            numeric(18, 0)   -- 
	,HostInfoID        nvarchar(256) null
	,InDateTime        DateTime      default getdate()   -- 
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

