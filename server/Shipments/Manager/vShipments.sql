if OBJECT_ID('vShipments') is not null
    drop view vShipments
go
/* **********************************************************						
vShipments - Интерфейс: Отгрузка
********************************************************** */

create view vShipments

as

SELECT s.ShipmentsID
      ,s.ShipmentsDate               -- дата отгрузки
      ,s.ReceiptDate                 -- ожидаемая жата поступления (расчетное поле)
      ,s.ReceiptDate2
      ,s.Invoice                     -- номер инвойса
      ,s.DestinationLogo             -- тип отправки
      ,s.DestinationName
      ,s.ShipmentsAmount             -- сумма отгрузки в долларах
      ,s.ShipmentsAmountR
      ,s.DetailCount                 -- количество деталей
      ,s.WeightKG                    -- вес физический (по прайсу)
      ,s.VolumeKG                    -- вес объемный (по прайсу)
      ,s.WeightKGF                   -- указать сумму вес физический факт
      ,s.VolumeKGF                   -- указать сумму вес объемный факт
      ,s.WeightKGDiff                -- 
      ,s.VolumeKGDiff                --
      ,s.WeightKGAmount              -- выводить ставки за физ кг и объем кг исходя из типа доставки
      ,s.VolumeKGAmount
      ,s.Amount                      -- Расчетная стоимость доставки по весам из прайса
      ,s.AmountF                     -- Фактическая стоимость доставки (по весам факт)
      ,s.SupplierWeightKG            -- добавить редактируемое поле "вес физ инвойса по данным поставщика"
      ,s.SupplierVolumeKG            -- добавить редактируемое поле "вес объем инвойса по данным поставщика"
      ,s.SupplierDiffVolumeWeigh     -- указать разницу сумм вес объемный и вес физ факт по данным поставщика
      ,s.SupplierAmount   
      -- считать доставку исходя из данных поставщика
      ,s.TransporterWeightKG         -- добавить редактируемое поле "вес физ по данным перевозчика"
      ,s.TransporterVolumeKG         -- добавить редактируемое поле "вес объем по данным перевозчика"
      ,s.TransporterDiffVolumeWeigh  -- указать разницу сумм вес объемный и вес физ факт по данным перевозчика      
      ,s.TransporterAmount 
      ,s.TransporterNumber


      ,s.StatusID
      ,st.Name      StatusName
      ,s.updDatetime
      -- считать доставку исходя из данных перевозчика

      ,sp.Brief     SupplierBrief
      ,s.SuppliersID
      ,s.DeliverySumF
      ,case
         when isnull(sb.ShipmentsBoxesID, 0) > 0 then 1
         else 0
       end Flag
  FROM tShipments s (nolock)
  left join tSuppliers sp (nolock)
         on sp.SuppliersID=s.SuppliersID

 --inner join tOrders o (nolock)
 --        on o.ClientID = ua.LinkID 

 --inner join tUser u with (nolock index=ao1)
 --        on u.UserID = o.UserID

  left join tNodes st with (nolock index=ao1)
         on st.NodeID = s.[StatusID]
        and st.Type   = 0 -- состояние/статус

  outer apply ( select top 1 *
                  from tShipmentsBoxes sb (nolock)
                 where sb.TransporterNumber = s.TransporterNumber
               ) as sb
go
grant select on vShipments to public
go
go
exec setOV 'vShipments', 'V', '20250215', '5'
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vShipments', @desc = 'Отгрузки'
go
select  * from vShipments where Invoice = '241002'
