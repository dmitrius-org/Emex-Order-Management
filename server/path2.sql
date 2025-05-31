alter table tShipments add Flag                            int           -- дополнительные признаки  

insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1054, 1054, 'Признак внесения данных в 1С',  'TShipmentsT.actSet1C', 63, 1

insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1055, 1055, 'Снять признак: 1С',  'TShipmentsT.actUnSet1C', 63, 1


update tmenu
  set Caption = 'Установить признак: 1С'
  where name = 'TShipmentsT.actSet1C'