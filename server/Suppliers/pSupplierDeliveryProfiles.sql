if OBJECT_ID('pSupplierDeliveryProfiles') is not null
  drop table pSupplierDeliveryProfiles
/* **********************************************************
pSupplierDeliveryProfiles - Профили доставки
********************************************************** */
create table pSupplierDeliveryProfiles
(
 Spid               int
,ID                 int identity
,ProfilesDeliveryID int                    -- Идентификатор 
,SuppliersID        numeric(18,0) not null -- Поставщик 
,Name               varchar(60)            -- Наименование
,WeightKG           float                  -- Вес физический кг 
,VolumeKG           float                  -- Вес объемный кг  
,PDelivery1         int                    -- Срок поставки до поставщика
,PDelivery2         int                    -- Максимальный срок задержки поставщика
,PDelivery3         int                    -- срок доставки до Москвы (из новой таблицы tDelivery)
,DenVyleta          nvarchar(256)          -- день вылета, начиная с понедельника
,VolumeKG_Rate1     decimal(10, 2) null    -- Коэффициент на детали у которых [VolumeKG] строго меньше 10 кг
,VolumeKG_Rate2     decimal(10, 2) null    -- Коэффициент на детали у которых [VolumeKG] от 10 кг включительно, но строго меньше 20 кг
,VolumeKG_Rate3     decimal(10, 2) null    -- Коэффициент на детали у которых [VolumeKG] от 20 кг включительно, но строго меньше 25 кг
,VolumeKG_Rate4     decimal(10, 2) null    -- Коэффициент на детали у которых [VolumeKG] от 25 кг включительно
,DestinationLogo    nvarchar(10) not null  -- Направление
,Restrictions       bit                    -- Признак выгружать детали с ограничениями или нет
,IsActive           bit 
,Delivery           int                    -- наш срок поставки, добавляем к сроку emex
,[Image]            nvarchar(256)
,ImageHelp          nvarchar(2048)
,isMyDelivery       bit                    -- Считать с учетом доставки
,isIgnore           bit                    -- Игнорировать детали без веса
,Fragile            float                  -- Наценка за страховку
)
go
create index ao1 on pSupplierDeliveryProfiles(ID)
go
create index ao2 on pSupplierDeliveryProfiles(Spid, SuppliersID, DestinationLogo)
go
grant all on pSupplierDeliveryProfiles to public
go
exec setOV 'pSupplierDeliveryProfiles', 'U', '20240701', '4'
go