if OBJECT_ID('tProperty') is null
/* **********************************************************
tProperty - 
********************************************************** */
begin
	create table tProperty
	(
	 PropertyID       numeric(18, 0)  --
	,ObjectTypeID     numeric(18, 0) 
	,Brief            nvarchar(128)   -- 
	,Name             nvarchar(512)

	--,Flag             int -- 1 - поддерживает модель сосотояния
							-- 2 - Активна
	);

	create unique index ao1 on tProperty(PropertyID);

	create unique index ao2 on tProperty(Brief);

	grant select on tProperty to public;
end
go
exec setOV 'tProperty', 'U', '20240101', '0';
go
exec dbo.sys_setTableDescription @table = 'tProperty', @desc = 'Типы объектов системы';
go
exec dbo.sys_setTableDescription 'tProperty', 'PropertyID'                 ,'Идентификатор';
go
--insert tProperty (PropertyID, ObjectTypeID, Brief, Name) select 1, 101, 'EmexOrderStateSync', 'Синхронизация статусов заказов' 
