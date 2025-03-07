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
      ,s.[Name]          as StatusName -- Статус/состояние
      ,o.[isCancel]
	  ,o.[MakeLogo]
      ,o.[Manufacturer]
      ,cast(b.Name as nvarchar(128)) as ReplacementManufacturer -- наименование бренда замены
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
      ,o.[Reliability]
      ,p.[WeightKGF]
      ,p.[VolumeKGF]
	  /* превышение объема, разница Объемный вес - Физический вес по данным прайс-листа.
	  Верно считать так:

		Если не указан фактический вес и фактический объем:
		Объем - Вес. Если итог < 0, ставим 0
		Если указан фактически вес и фактический объем:
		Фактический Объем - Фактический Вес. Если итог < 0, ставим 0
	  */ 
	  ,case
	     when isnull(p.[WeightKGF], '') = '' and isnull(p.[VolumeKGF], '') = '' 
		 then case
		        when o.[VolumeKG] - o.[WeightKG]  >= 0 then o.[VolumeKG] - o.[WeightKG] 
		        else 0    
		      end

         else case
		        when p.[VolumeKGF] - p.[WeightKGF]  >= 0 then p.[VolumeKGF] - p.[WeightKGF]
			    else 0    
		      end
	   end OverVolume
      ,o.[Margin]
      ,o.[MarginF]
      ,o.[Profit]
      ,o.[Income]
      ,o.[IncomePRC]
      
      ,o.[DeliveryPlanDateSupplier]             -- Плановая дата поступления поставщику
      ,nullif(od.[DeliveryPlanDateSupplier], o.[DeliveryPlanDateSupplier]) as DeliveryPlanDateSupplier2-- Плановая дата поступления поставщику после изменения
      ,isnull(od.[DeliveryRestTermSupplier], o.[DeliveryRestTermSupplier]) as DeliveryRestTermSupplier-- Остаток срока до поступления поставщику	
      ,o.[DeliveryTerm] as DeliveryTermSupplier -- Срок до поступления поставщику (срок из прайса)
      ,nullif(od.DeliveryTermSupplier, o.[DeliveryTerm]) as DeliveryTermSupplier2 -- Срок доставки поставщику после изменения
      ,o.[DeliveredDateToSupplier]              -- Доставлена поставщику
      ,o.DeliveryDaysReserve                    -- Дней запаса до вылета	
      ,nullif(o.DeliveryDaysReserve2, o.DeliveryDaysReserve) as DeliveryDaysReserve2 --
      ,o.DeliveryNextDate                       -- Ближайшая дата вылета
      ,nullif(o.DeliveryNextDate2, o.DeliveryNextDate) as DeliveryNextDate2  -- Ближайшая дата вылета, рассчитывается если прошёл срок DeliveryNextDate	
      ,pd.Delivery as DeliveryTermFromSupplierProfile -- Срок доставки с профиля доставки поставщика

      ,o.DeliveryDateToCustomer                          -- Дата поставки клиенту	
      ,nullif(oс.DeliveryDateToCustomer, o.DeliveryDateToCustomer) as DeliveryDateToCustomer2 -- Дата поставки клиенту после изменения
      ,o.DeliveryTermToCustomer	                         -- Срок поставки клиенту	
      ,nullif(oс.DeliveryTermToCustomer, o.DeliveryTermToCustomer) as DeliveryTermToCustomer2 -- Срок поставки клиенту после изменения
      ,o.DeliveryRestToCustomer                             -- Остаток срока до поставки клиенту
      ,pd.DeliveryTermCustomer       as DeliveryTermFromCustomerProfile
      
	  ,o.DateDeparture        -- Дата вылета 
      ,coalesce(sh.ReceiptDate2, sh.ReceiptDate) ReceiptDate -- Ожидаемая дата поступления
	  ,o.DaysInWork                    -- Дней в работе  
      ,o.DateInWork                    -- Дата перехода в состояние "в работе" в emex
	  ,o.OverPricing                   -- превышение
	  ,o.Warning                       -- предупреждение/замечания
      ,o.Comment                       -- 
	  ,o.ReplacementMakeLogo           -- бренд замены
	  ,o.ReplacementDetailNumber       -- номер замены
	  ,o.ReplacementPrice              -- Изменение цены
	  ,o.CustomerPriceLogo             -- Наименование прайса заказа от клиента
	  ,isnull(o.DestinationLogo, pd.DestinationLogo) as DestinationLogo     -- Направление отгрузки
      ,coalesce(o.DestinationName, pd.Name, o.DestinationLogo, pd.DestinationLogo) as DestinationName -- Направление отгрузки    
      ,coalesce(o.ProfilesCustomerID, pd.ProfilesCustomerID) ProfilesCustomerID
      ,o.Invoice                       -- номер инвойса
      ,o.FileDate                      -- Дата файла
      ,o.[UserID]
      ,u.[Name]                 as UserName
      ,o.[inDatetime]
      ,o.[updDatetime]
      ,c.[SuppliersID]
      ,ps.[OrderUniqueCount]      -- количество уникальных заказов
      ,o.[PercentSupped]          -- процент поставки детали
	  ,isnull(o.Flag, 0)        as Flag
      ,p.[PriceID]           
      ,p.[Quantity]             as PriceQuantity -- количество из прайса
      ,cast(Case 
              when p.Restrictions = 'NOAIR' then 1
              else 0
            end as bit)         as NoAir
      ,p.Fragile -- признак: хрупкий
      ,p.NLA -- No longer available или Более недоступно
      ,o.OrderDetailSubId
	  ,m.Flag&1 /*1 - начальное состояние */ as IsStartState
      ,o.BasketId
      ,o.Reference
      ,o.CustomerSubID
  FROM vUserAccess ua 

 inner join tOrders o with (nolock index=ao2)
         on o.ClientID = ua.LinkID 

  left join vOrdersDeliverySupplier od  with (nolock index=PK_tOrdersDeliverySupplier_OrderID) -- актуальные сроки доставки поставщика
         on od.OrderID = o.OrderID

  left join vOrdersDeliveryCustomer oс  with (nolock index=PK_tOrdersDeliveryCustomer_OrderID) -- актуальные сроки доставки клиента
         on oс.OrderID = o.OrderID

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

 outer apply (
      select top 1 pd.DestinationLogo, 
                   pd.Name, 
                   pd.Delivery,
                   pc.DeliveryTermCustomer,
                   pc.ProfilesCustomerID
        from tProfilesCustomer pc with (nolock index=ao2)
        left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
               on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
          and (pc.ProfilesCustomerID = o.ProfilesCustomerID 
            or pd.DestinationLogo    = o.DestinationLogo)
        order by case
                   when pc.ProfilesCustomerID = o.ProfilesCustomerID  then 1
                   when pc.ClientPriceLogo = o.CustomerPriceLogo  then 2
                   else 555
                 end
     ) as pd

  left join tMakes b with (nolock index=ao2) -- брент замены
         on cast(b.Code as nvarchar)= o.ReplacementMakeLogo

  left join tPrice p with (nolock index=ao1)
         on p.PriceID = o.PriceID	
         
  left join tPartsStatistics ps with (nolock index=ao1)
         on ps.Make      = o.MakeLogo
        and ps.DetailNum = o.DetailNumber

  left join tShipments sh with (nolock index=ao2)
         on sh.Invoice = o.Invoice

 where ua.UserID    = dbo.GetUserID()
   and ua.LinkType  = 7
go
grant select on vOrders to public
go
exec setOV 'vOrders', 'V', '20250305', '21'
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vOrders', @desc = 'Список заказов'

