if OBJECT_ID('tObjectType') is null
--drop table tObjectType
/* **********************************************************
tObjectType - типы объектов системы. TObjectType
********************************************************** */
begin
	create table tObjectType
	(
	 ObjectTypeID     numeric(18, 0)  --
	,Brief            nvarchar(512)   -- 
	,Name             nvarchar(512)
	,Flag             int -- 1 - поддерживает модель сосотояния
						  -- 2 - Активна
	);
	
	create unique index ao1 on tObjectType(ObjectTypeID);
	
	create unique index ao2 on tObjectType(Brief);
	
	grant select on tObjectType to public;
end
go
exec setOV 'tObjectType', 'U', '20240101', '0'
go
exec dbo.sys_setTableDescription @table = 'TObjectType', @desc = 'Типы объектов системы'
go
exec dbo.sys_setTableDescription 'TObjectType', 'Flag', 'Дополнительные признаки: -- 1 - поддерживает модель сосотояния -- 2 - Активна'

