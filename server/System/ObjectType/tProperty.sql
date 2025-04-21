if OBJECT_ID('tProperty') is null
/* **********************************************************
drop table tProperty - 
********************************************************** */
begin
	create table tProperty
	(
	 
	 ObjectTypeID     numeric(18, 0) 
    ,PropertyID       numeric(18, 0)  --
	,Brief            nvarchar(128)   -- 
	,Name             nvarchar(512)

	,Flag             int 	   -- 1 - Используется при выполнении действия
	                           -- 2 - Используется при откате действия
	);

	create unique index ao1 on tProperty(ObjectTypeID, PropertyID);

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

--Процедуры автоматических заданий
insert tProperty (PropertyID, ObjectTypeID, Brief, Name)       select 1, 101, 'EmexOrderStateSync', 'Синхронизация статусов заказов' 

--Процедуры для модели состояния
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 2, 102, 1, 'EmexCreateOrder', 'Создание заказа' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 3, 102, 1, 'EmexOrderStateSync', 'Синхронизация статусов заказов' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 4, 102, 1, 'EmexCreateOrderCheck', 'Проверка наличия заказа в Emex по данным корзины' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 5, 102, 1, 'InsertPartToBasketByPartFromMark', 'Добавление заказов в корзину' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 6, 102, 2, 'InsertPartToBasketByPartRollBack', 'Удаление деталей из корзины при откате' 

-- типы платежей
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 1, 12, 0, 'Карта', 'Карта' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 2, 12, 0, 'Наличные', 'Наличные' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 3, 12, 0, 'Взаимозачет', 'Взаимозачет' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 4, 12, 0, 'Безнал НДС', 'Безнал НДС' 

-- тип ответа на отказы
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 0, 13, 0, 'Эмекс.ру', 'Эмекс.ру' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 1, 13, 0, 'Файл',     'Файл' 
insert tProperty (PropertyID, ObjectTypeID, Flag, Brief, Name) select 2, 13, 0, 'Скрипт',   'Скрипт' 