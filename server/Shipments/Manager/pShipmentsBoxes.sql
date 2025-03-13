if OBJECT_ID('pShipmentsBoxes') is not null
  drop table pShipmentsBoxes
/* **********************************************************
pShipmentsBoxes - 
********************************************************** */
create table pShipmentsBoxes
      (
       ID                              int identity
      ,Spid                            int
      ,N                               int
      ,ShipmentsBoxesID                numeric(18,0) --
      ,TransporterNumber               varchar(64)   -- Номер груза
      ,Invoice                         varchar(64) 
      ,BoxNumber                       numeric(18, 0) -- Номер коробки
      ,SupplierPhysicalWeight          float -- Физический вес по данным поставщика
      ,TransporterPhysicalWeight       float -- Физический вес по данным перевозчика
      ,SupplierVolumetricWeight        float -- Объемный вес по данным поставщика
      ,TransporterVolumetricWeight     float -- Объемный вес по данным перевозчик
      
       --SupplierWidth               float, -- Ширина по данным поставщика 
       --TransporterWidth            float, -- Ширина по данным перевозчика
       --SupplierLength              float, -- Длина по данным поставщика
       --TransporterLength           float, -- Длина по данным перевозчика
       --SupplierHeight              float, -- Высота по данным поставщика 
       --TransporterHeight           float, -- Высота по данным перевозчика
      ,ImageLinks                     varchar(MAX)
                                      
      ,OrderID                        numeric(18,0) --
      ,WeightKGOld                    money         -- Вес Физический
      ,VolumeKGOld                    money         -- Вес Объемный
      ,WeightKG                       money         -- Вес Физический
      ,VolumeKG                       money         -- Вес Объемный
      ,WeightKGS                      money         -- Вес Физический
      ,VolumeKGS                      money         -- Вес Объемный
      ,Quantity                       int           -- Количество
      ,Manufacturer                   varchar(64)   -- Производитель
      ,DetailNumber                   varchar(32)   -- Номер детали
      ,ManufacturerReplacement        varchar(64)   -- Производитель замены
      ,DetailNumberReplacement        varchar(32)   -- Номер детали замены
      ,DetailName                     varchar(256)  -- Название детали
      ,PricePurchase                  money         -- Цена закупки факт
      ,AmountPurchase                 money         -- Сумма закупки факт
      ,Reference                      varchar(32) 
      ,OrderDetailSubId               varchar(32) 
      ,CustomerSubId                  varchar(32) 
      ,ClientName                     varchar(256) 
      ,Type                           int
      )
go
create index ao1 on pShipmentsBoxes(ID) 
go
create index ao2 on pShipmentsBoxes(Spid, N)
go
grant all on pShipmentsBoxes to public
go
exec setOV 'pShipmentsBoxes', 'U', '20250312', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pShipmentsBoxes', @desc = ''
