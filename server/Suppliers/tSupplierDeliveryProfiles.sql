if OBJECT_ID('tSupplierDeliveryProfiles') is null
--drop table tSupplierDeliveryProfiles
/* **********************************************************
tSupplierDeliveryProfiles - расширение профилей управления выгрузкой 
********************************************************** */
begin
	create table tSupplierDeliveryProfiles
	(
	 ProfilesDeliveryID int  identity          -- Идентификатор 
	,SuppliersID        numeric(18,0) not null -- Поставщик 
	,Name               varchar(60)            -- Наименование
	,WeightKG           float                  -- Вес физический кг, стоимость 1 кг 
	,VolumeKG           float                  -- Вес объемный кг, стоимость 1 кг   
	,PDelivery1         int                    -- Срок поставки до поставщика
	,PDelivery2         int                    -- Максимальный срок задержки поставщика
	,PDelivery3         int                    -- срок доставки до Москвы (из новой таблицы tDelivery)
	,DenVyleta          nvarchar(256)          -- день вылета, начиная с понедельника
	,VolumeKG_Rate1     decimal(10, 2) null    -- Коэффициент на детали у которых [VolumeKG] строго меньше 10 кг
	,VolumeKG_Rate2     decimal(10, 2) null    -- Коэффициент на детали у которых [VolumeKG] от 10 кг включительно, но строго меньше 20 кг
	,VolumeKG_Rate3     decimal(10, 2) null    -- Коэффициент на детали у которых [VolumeKG] от 20 кг включительно, но строго меньше 25 кг
	,VolumeKG_Rate4     decimal(10, 2) null    -- Коэффициент на детали у которых [VolumeKG] от 25 кг включительно
	,DestinationLogo    nvarchar(10)   not null-- Направление
	,Restrictions       bit                    -- Признак выгружать детали с ограничениями или нет
	,IsActive           bit     
	,Delivery           int                    -- наш срок поставки, добавляем к сроку emex
    ,[Image]            nvarchar(256)
    ,ImageHelp          nvarchar(2048)
 	,isMyDelivery       bit                    -- Считать с учетом доставки
	,isIgnore           bit                    -- Игнорировать детали без веса
	);

	create unique index ao1 on tSupplierDeliveryProfiles(SuppliersID, DestinationLogo);

	create unique index ao2 on tSupplierDeliveryProfiles(ProfilesDeliveryID);

	grant all on tSupplierDeliveryProfiles to public;
end
go
exec setOV 'tSupplierDeliveryProfiles', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tSupplierDeliveryProfiles', @desc = 'Расширение профилей управления выгрузкой'
-- Описание полей
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'ProfilesDeliveryID'    ,'Уникальный идентификатор'
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'SuppliersID'           ,'Поставщик'
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'Name'                  ,'Наименование' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'WeightKG'              ,'Вес физический кг, стоимость 1 кг' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'VolumeKG'              ,'Вес объемный кг, стоимость 1 кг' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'PDelivery1'            ,'Срок поставки до поставщика' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'PDelivery2    '        ,'Максимальный срок задержки поставщика' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'PDelivery3    '        ,'Срок доставки до Москвы (из новой таблицы tDelivery)' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'DenVyleta     '        ,'День вылета, начиная с понедельника' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'VolumeKG_Rate1'        ,'Коэффициент на детали у которых [VolumeKG] строго меньше 10 кг' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'VolumeKG_Rate2'        ,'Коэффициент на детали у которых [VolumeKG] от 10 кг включительно, но строго меньше 20 кг' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'VolumeKG_Rate3'        ,'Коэффициент на детали у которых [VolumeKG] от 20 кг включительно, но строго меньше 25 кг' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'VolumeKG_Rate4'        ,'Коэффициент на детали у которых [VolumeKG] от 25 кг включительно' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'DestinationLogo'       ,'Направление заказа. Передается в emex при добалении детали в корзину' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'Restrictions'          ,'Признак выгружать детали с ограничениями или нет' 
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'Delivery'              ,'Наш срок поставки, добавляем к сроку emex' 
go
