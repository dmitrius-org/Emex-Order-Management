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

	,Flag             int 	   -- 1 - Используется при выполнении действия
	                           -- 2 - Используется при откате действия
	);

	create unique index ao1 on tProperty(PropertyID);

	create unique index ao2 on tProperty(ObjectTypeID, Brief);

	grant select on tProperty to public;
end
go
exec setOV 'tProperty', 'U', '20240101', '0';
go
exec dbo.sys_setTableDescription @table = 'tProperty', @desc = 'Типы объектов системы';
go
exec dbo.sys_setTableDescription 'tProperty', 'PropertyID'                 ,'Идентификатор';
go

delete from tProperty
insert tProperty (PropertyID, ObjectTypeID, Brief, Name) select 1, 101, 'EmexOrderStateSync', 'Синхронизация статусов заказов' 

insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 2, 102, 1, 'EmexCreateOrder', 'Создание заказа' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 3, 102, 1, 'EmexOrderStateSync', 'Синхронизация статусов заказов' 

insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 4, 102, 1, 'EmexCreateOrderCheck', 'Проверка наличия заказа в Emex по данным корзины' 

insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 5, 102, 1, 'InsertPartToBasketByPartFromMark', 'Добавление заказов в корзину' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 6, 102, 2, 'InsertPartToBasketByPartRollBack', 'Удаление деталей из корзины при откате' 
