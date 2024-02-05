if OBJECT_ID('pShipments') is not null
  drop table pShipments
/* **********************************************************
pShipments - Сроки поставки
********************************************************** */
create table pShipments
(
 Spid                            int
,Invoice                         nvarchar(64)   -- Инвойс, номер отправки
,ShipmentsDate                   datetime       not null -- дата отгрузки
,ReceiptDate                     datetime       -- ожидаемая дата поступления
,ShipmentsType                   nvarchar(20)   -- Тип отправки DestinationLogo
,ShipmentsAmount                 money          -- сумма отгрузки в долларах
,DetailCount                     int            -- количество деталей
,WeightKG                        money          -- вес физический (по прайсу)
,VolumeKG                        money          -- вес объемный (по прайсу)
,WeightKGDiff                    money          -- указать разницу сумм вес физический факт минус вес физический из прайса
,WeightKGF                       money          -- указать сумму вес физический факт (напоминаю, что после того как деталь переходит в статус "в работе", физ вес факт и объем вес факт должны заполняться автоматом если были пусты
,VolumeKGF                       money          -- указать сумму вес объемный факт
,VolumeKGDiff                    money          -- указать разницу сумм вес объемный факт минус вес объемный из прайса
,WeightKGAmount                  money          -- выводить ставки за физ кг и объем кг исходя из типа доставки
,VolumeKGAmount	                 money          -- 
,Amount                          money          -- выводить расчетную стоимость доставки исходя из них 

,SupplierWeightKG                money          -- добавить редактируемое поле "вес физ инвойса по данным поставщика"
,SupplierVolumeKG                money          -- добавить редактируемое поле "вес объем инвойса по данным поставщика"
,SupplierDiffVolumeWeigh         money          -- указать разницу сумм вес объемный и вес физ факт по данным поставщика
,SupplierAmount                  money          -- считать доставку исходя из данных поставщика
--считать доставку исходя из данных поставщика
,TransporterWeightKG             money          -- добавить редактируемое поле "вес физ по данным перевозчика",
,TransporterVolumeKG             money          -- добавить редактируемое поле "вес объем по данным перевозчика"
,TransporterDiffVolumeWeigh      money          -- указать разницу сумм вес объемный и вес физ факт по данным перевозчика
,TransporterAmount               money          -- считать доставку исходя из данных перевозчика
--,считать доставку исходя из данных перевозчика

,SuppliersID                     numeric(18,0) -- Поставщик. Аккаунт из которого сделана отгрузка
--,UserID                          numeric(18,0) default dbo.GetUserID()
--,inDatetime                      datetime      default GetDate()      --
--,updDatetime                     datetime      default GetDate()      --


)
go
create unique index ao1 on pShipments(Spid, Invoice)
go
grant select on pShipments to public
go
 -- Комментарий
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pShipments', @desc = ''
