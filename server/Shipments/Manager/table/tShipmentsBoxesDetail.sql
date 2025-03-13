if OBJECT_ID('tShipmentsBoxesDetail') is null
--  drop table tShipmentsBoxesDetail
/* **********************************************************
tShipmentsBoxesDetail - 
********************************************************** */
begin
  create table tShipmentsBoxesDetail
  (
      ShipmentsBoxesDetailID      numeric(18,0)  identity, --
      ShipmentsBoxesID            numeric(18,0), --
      OrderID                     numeric(18,0), --

      TransporterNumber           varchar(64),  -- Номер груза
      Invoice                     varchar(64), 
      BoxNumber                   numeric(18, 0), -- Номер коробки

      Weight                      float, -- Физический вес по данным поставщика
      Volume                      float, -- Объемный вес по данным поставщика

  )
  
  create unique index ao1 on tShipmentsBoxesDetail(ShipmentsBoxesDetailID); 
  
  create index ao2 on tShipmentsBoxesDetail(ShipmentsBoxesID);

  
  grant select on tShipmentsBoxesDetail to public;
end
go
exec setOV 'tShipmentsBoxesDetail', 'U', '20250213', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tShipmentsBoxesDetail', @desc = ''
