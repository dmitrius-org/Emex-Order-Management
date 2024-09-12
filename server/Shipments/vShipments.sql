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
      ,s.WeightKGAmount              --выводить ставки за физ кг и объем кг исходя из типа доставки
      ,s.VolumeKGAmount
      ,s.Amount                      -- выводить расчетную стоимость доставки исходя из них 
                                     -- выводить расчетную стоимость доставки исходя из них
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

 --inner join tModel m with (nolock)
 --        on m.StateID = s.NodeID
 --       and m.ActionID= 0 -- только состояния
 --inner join tInstrument i with (nolock index=ao1)
 --        on i.InstrumentID = m.InstrumentID
	--	and i.ObjectTypeID = 3

 --inner join tClients c with (nolock index=ao1)
 --        on c.ClientID = o.ClientID

 --left join tProfilesCustomer pc with (nolock)
 --        on pc.ClientID        = c.ClientID
 --       and pc.ClientPriceLogo = o.CustomerPriceLogo
 -- left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
 --        on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID

 -- left join tMakes b with (nolock index=ao2) -- брент замены
 --        on cast(b.Code as nvarchar)= o.ReplacementMakeLogo

 -- left join tPrice p with (nolock index=ao1)
 --        on p.PriceID = o.PriceID		 

 --where ua.UserID    = dbo.GetUserID()
 --  and ua.LinkType  = 7
go
grant select on vShipments to public
go
go
exec setOV 'vShipments', 'V', '20240911', '2'
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vOrders', @desc = 'Список заказов'

select  * from vShipments where Invoice = '241002'
