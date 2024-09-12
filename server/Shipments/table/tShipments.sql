if OBJECT_ID('tShipments') is null
  --drop table tShipments
/* **********************************************************
tShipments - Отгрузки
В нем в 1 строку указаны отгрузка по конкретному инвойсу, например 220071
********************************************************** */
begin
	create table tShipments
	(
	 ShipmentsID                     numeric(18,0)  identity --
	,ShipmentsDate                   datetime       not null -- дата отгрузки
	,ReceiptDate                     datetime       -- ожидаемая дата поступления
    ,ReceiptDate2                    datetime 
	,Invoice                         nvarchar(64)   -- Инвойс, номер отправки
	,DestinationLogo                 nvarchar(20)   -- Тип отправки DestinationLogo
    ,DestinationName                 nvarchar(120)  -- Тип отправки DestinationLogo
	,ShipmentsAmount                 money          -- сумма отгрузки в долларах
    ,ShipmentsAmountR                money          -- сумма отгрузки в рублях
	,DetailCount                     int            -- количество деталей
	,WeightKG                        money          -- вес физический (по прайсу)
	,VolumeKG                        money          -- вес объемный (по прайсу)
	,WeightKGDiff                    money          -- разница сумм вес физический факт минус вес физический из прайса
	,WeightKGF                       money          -- сумма вес физический факт
	,VolumeKGF                       money          -- сумма вес объемный факт
	,VolumeKGDiff                    money          -- разница сумм вес объемный факт минус вес объемный из прайса
	,WeightKGAmount                  money          -- выводить ставки за физ кг и объем кг исходя из типа доставки
	,VolumeKGAmount	                 money          
	,Amount                          money          -- выводить расчетную стоимость доставки исходя из них 

	,SuppliersID                     numeric(18,0)  -- Поставщик. Аккаунт из которого сделана отгрузка
	,SupplierWeightKG                money          -- добавить редактируемое поле "вес физ инвойса по данным поставщика"
	,SupplierVolumeKG                money          -- добавить редактируемое поле "вес объем инвойса по данным поставщика"
	,SupplierDiffVolumeWeigh         money          -- указать разницу сумм вес объемный и вес физ факт по данным поставщика
	,SupplierAmount                  money          -- считать доставку исходя из данных поставщика
	--считать доставку исходя из данных поставщика
	,TransporterWeightKG             money          -- добавить редактируемое поле "вес физ по данным перевозчика",
	,TransporterVolumeKG             money          -- добавить редактируемое поле "вес объем по данным перевозчика"
	,TransporterDiffVolumeWeigh      money          -- указать разницу сумм вес объемный и вес физ факт по данным перевозчика
	,TransporterAmount               money          -- считать доставку исходя из данных перевозчика
    ,TransporterNumber               nvarchar(64)   -- Номер груза


    ,StatusID                        int
	,UserID                          numeric(18,0) default dbo.GetUserID()
	,inDatetime                      datetime      default GetDate()      --
	,updDatetime                     datetime      default GetDate()      --
	)

	create unique index ao1 on tShipments(ShipmentsID) 

	create unique index ao2 on tShipments(Invoice)

	grant select on tShipments to public
end
go
exec setOV 'tShipments', 'U', '20240101', '0'
go
