if OBJECT_ID('pShipmentsBoxesData') is not null
  drop table pShipmentsBoxesData
/* **********************************************************
pShipmentsBoxesData - 
********************************************************** */
create table pShipmentsBoxesData
(
    Spid                        int, 
    TransporterNumber           varchar(64),  -- Номер груза
    Invoice                     varchar(64), 
    BoxNumber                   numeric(18, 0), -- Номер коробки
    SupplierPhysicalWeight      float, -- Физический вес по данным поставщика
    TransporterPhysicalWeight   float, -- Физический вес по данным перевозчика
    SupplierVolumetricWeight    float, -- Объемный вес по данным поставщика
    TransporterVolumetricWeight float, -- Объемный вес по данным перевозчик

    SupplierWidth               float, -- Ширина по данным поставщика 
    TransporterWidth            float, -- Ширина по данным перевозчика
    SupplierLength              float, -- Длина по данным поставщика
    TransporterLength           float, -- Длина по данным перевозчика
    SupplierHeight              float, -- Высота по данным поставщика 
    TransporterHeight           float, -- Высота по данным перевозчика
    ImageLinks                  varchar(MAX)
)
go
create index ao1 on pShipmentsBoxesData(Spid, BoxNumber)
go
grant all on pShipmentsBoxesData to public
go
exec setOV 'pShipmentsBoxesData', 'U', '20250213', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pShipmentsBoxesData', @desc = ''
