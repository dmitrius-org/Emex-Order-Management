if OBJECT_ID('vOrders') is not null
    drop view vOrders
go
/* **********************************************************						
vOrders - получение списка заказов
********************************************************** */

create view vOrders

as

SELECT o.[OrderID]
      ,o.[ClientID]
      ,c.[Brief]         as ClientName
      ,o.[OrderDate]
      ,o.[PriceLogo]
      ,o.[OrderNum]
      ,o.[StatusID]
      ,s.[Name]          as StatusName -- статус/состояние
      ,o.[isCancel]
	  ,o.[isCancelToClient] -- отказ отправлен клиенту
	  ,o.[MakeLogo]
      ,o.[Manufacturer]
      ,o.[DetailNumber]
      ,ltrim(rtrim(Replace( case 
                  when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                  then p.DetailName
                  else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                end  
               ,o.[DetailNumber]  
               ,'')))    as DetailName
      ,o.[DetailID]
      ,o.[Quantity]
      ,o.[Price]
      ,o.[Amount]
      ,o.[PricePurchase]
      ,o.[AmountPurchase]
      ,o.[PricePurchaseF]
      ,o.[AmountPurchaseF]
      ,o.[WeightKG]
      ,o.[VolumeKG]
      ,p.[WeightKGF]
      ,p.[VolumeKGF]
      ,( o.[VolumeKG] - o.[WeightKG] ) OverVolume    -- превышение объема, разница Объемный вес - Физический вес по данным прайс-листа.
      ,o.[Margin]
      ,o.[MarginF]
      ,o.[Profit]
      ,o.[Income]
      ,o.[IncomePRC]

      ,o.[DeliveryPlanDateSupplier]
      ,case 
         when isnull(o.DeliveredDateToSupplier, '') = ''
         then DATEDIFF(dd, getDate(), o.[DeliveryPlanDateSupplier])
         else DATEDIFF(dd, o.DeliveredDateToSupplier, o.[DeliveryPlanDateSupplier])
       end  [DeliveryRestTermSupplier] --Остаток срока до поступления поставщику	
      ,o.[DeliveredDateToSupplier]     -- Доставлена поставщику
      ,case 
         when o.DeliveryNextDate < cast(getDate() as date)
         then 0
         else DATEDIFF(dd, getDate(), o.DeliveryNextDate)
       end  DeliveryDaysReserve        -- Дней запаса до вылета	
      ,o.DeliveryNextDate              -- Ближайшая дата вылета
      ,o.DeliveryDateToCustomer        -- Дата поставки клиенту	
      ,o.DeliveryTermToCustomer	       -- Срок поставки клиенту	
      ,o.DeliveryRestToCustomer        -- Остаток срока до поставки клиенту
                                       
	  ,o.OverPricing                   -- превышение
	  ,o.Warning                       -- предупреждение/замечания
	  ,cast(b.Name as nvarchar(128)) as ReplacementManufacturer -- наименование бренда замены
	  ,o.ReplacementMakeLogo           -- бренд замены
	  ,o.ReplacementDetailNumber       -- номер замены
	  ,o.ReplacementPrice              -- Изменение цены
	  ,o.CustomerPriceLogo             -- Наименование прайса заказа от клиента
	  ,isnull(o.DestinationLogo, pd.DestinationLogo)  DestinationLogo     -- Направление отгрузки      

      ,o.Invoice                       -- номер инвойса
      ,o.FileDate                      -- Дата файла

      ,o.[UserID]
      ,u.[Name]                 as UserName
      ,o.[inDatetime]
      ,o.[updDatetime]
      ,c.SuppliersID

	  ,isnull(o.Flag, 0)        as Flag

      ,p.PriceID                       -- 
      ,p.Restrictions                  -- ограничение

	  ,m.Flag&1 /*1 - начальное состояние */ 
                                as IsStartState

  FROM vUserAccess ua 

 inner join tOrders o (nolock)
         on o.ClientID = ua.LinkID 

 inner join tUser u with (nolock index=ao1)
         on u.UserID = o.UserID

 inner join tNodes s with (nolock index=ao1)
         on s.NodeID = o.[StatusID]
        and s.Type   = 0 -- состояние/статус

 inner join tModel m with (nolock)
         on m.StateID = s.NodeID
        and m.ActionID= 0 -- только состояния
 inner join tInstrument i with (nolock index=ao1)
         on i.InstrumentID = m.InstrumentID
		and i.ObjectTypeID = 3

 inner join tClients c with (nolock index=ao1)
         on c.ClientID = o.ClientID

 left join tProfilesCustomer pc with (nolock)
         on pc.ClientID        = c.ClientID
        and pc.ClientPriceLogo = o.CustomerPriceLogo
  left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
         on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID

  left join tMakes b with (nolock index=ao2) -- брент замены
         on cast(b.Code as nvarchar)= o.ReplacementMakeLogo

  left join tPrice p with (nolock index=ao1)
         on p.PriceID = o.PriceID		 

 where ua.UserID    = dbo.GetUserID()
   and ua.LinkType  = 7
go
grant select on vOrders to public
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vOrders', @desc = 'Список заказов'

select IsStartState, * from vOrders --where OrderID=327


--select top 1000 * from tPrice
