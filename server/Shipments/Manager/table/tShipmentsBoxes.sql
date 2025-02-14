if OBJECT_ID('tShipmentsBoxes') is null
--  drop table tShipmentsBoxes
/* **********************************************************
tShipmentsBoxes - 
********************************************************** */
begin
  create table tShipmentsBoxes
  (
      ShipmentsBoxesID            numeric(18,0)  identity, --
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
  
  create unique index ao1 on tShipmentsBoxes(ShipmentsBoxesID); 
  
  create index ao2 on tShipmentsBoxes(TransporterNumber);

  create index ao3 on tShipmentsBoxes(BoxNumber);
  
  grant select on tShipmentsBoxes to public;
end
go
exec setOV 'tShipmentsBoxes', 'U', '20250213', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tShipmentsBoxes', @desc = ''
