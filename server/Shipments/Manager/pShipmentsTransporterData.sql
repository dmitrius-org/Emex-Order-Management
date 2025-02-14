if OBJECT_ID('pShipmentsTransporterData') is not null
  drop table pShipmentsTransporterData
/* **********************************************************
pShipmentsTransporterData - 
********************************************************** */
create table pShipmentsTransporterData
(
  Spid                  int, 
  TransporterNumber     varchar(64), 
  Invoice               varchar(64), 
  WeightKGAmount	    float ,
  VolumeKGAmount        float ,
  SupplierWeightKG      float , 
  SupplierVolumeKG      float , 
  TransporterWeightKG   float , 
  TransporterVolumeKG   float , 
  TransporterAmount     float ,

  WeightKG              float , -- вес Физический по прайсу
  VolumeKG              float , -- вес Обьемный по прайсу
  WeightKGF             float , -- вес Физический факт (по проверке)
  VolumeKGF             float , -- вес Обьемный факт (по проверке)

  WeightIK              float , -- Коэффициент разницы для вычисления веса каждого инвойса
  VolumeIK              float , -- Коэффициент разницы для вычисления веса каждого инвойса
  WeightSK              float , -- Коэффициент разницы для вычисления веса каждого инвойса
  VolumeSK              float , -- Коэффициент разницы для вычисления веса каждого инвойса
  WeightI               float , 
  VolumeI               float , 
  WeightS               float , 
  VolumeS               float , 
  AmountCalculated      float , --Стоимость доставки расчетная
  AmountK               float , --Коэффициент
  AmountFinal           float ,  --Стоимость доставки конечная
  Flag                  int
)
go
create index ao1 on pShipmentsTransporterData(Spid, Invoice)
go
grant all on pShipmentsTransporterData to public
go
exec setOV 'pShipmentsTransporterData', 'U', '20250213', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pShipmentsTransporterData', @desc = ''
