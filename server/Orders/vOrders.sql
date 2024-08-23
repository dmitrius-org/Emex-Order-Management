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
      ,o.[DeliveryPlanDateSupplier]    -- Плановая дата поступления поставщику
      ,case 
         when datediff(dd, cast(getdate() as date), o.[DeliveryPlanDateSupplier]) > 0
         then datediff(dd, cast(getdate() as date), o.[DeliveryPlanDateSupplier])
         else 0
       end  [DeliveryRestTermSupplier] -- Остаток срока до поступления поставщику	
      ,o.[DeliveredDateToSupplier]     -- Доставлена поставщику
      ,o.DeliveryDaysReserve           -- Дней запаса до вылета	
      ,o.DeliveryNextDate              -- Ближайшая дата вылета
      ,o.DeliveryNextDate2             -- Ближайшая дата вылета, рассчитывается если прошол срок DeliveryNextDate	
      ,o.DeliveryDateToCustomer        -- Дата поставки клиенту	
      ,o.DeliveryTermToCustomer	       -- Срок поставки клиенту	
      ,o.DeliveryRestToCustomer        -- Остаток срока до поставки клиенту
	  ,o.DateDeparture                 -- Дата вылета 
	  ,o.DaysInWork                    -- Дней в работе                             
	  ,o.OverPricing                   -- превышение
	  ,o.Warning                       -- предупреждение/замечания
      ,o.Comment                       -- 
	  ,cast(b.Name as nvarchar(128)) as ReplacementManufacturer -- наименование бренда замены
	  ,o.ReplacementMakeLogo           -- бренд замены
	  ,o.ReplacementDetailNumber       -- номер замены
	  ,o.ReplacementPrice              -- Изменение цены
	  ,o.CustomerPriceLogo             -- Наименование прайса заказа от клиента
	  ,isnull(o.DestinationLogo, pd.DestinationLogo) as DestinationLogo     -- Направление отгрузки
      ,coalesce(pd.Name, o.DestinationName, o.DestinationLogo, pd.DestinationLogo) as DestinationName -- Направление отгрузки    
      ,o.Invoice                       -- номер инвойса
      ,o.FileDate                      -- Дата файла
      ,o.[UserID]
      ,u.[Name]                 as UserName
      ,o.[inDatetime]
      ,o.[updDatetime]
      ,c.SuppliersID
      ,ps.OrderUniqueCount      -- количество уникальных заказов
      ,o.PercentSupped          -- процент поставки детали
	  ,isnull(o.Flag, 0)        as Flag
      ,p.PriceID                       -- 
      ,p.Quantity               as PriceQuantity -- количество из прайса
      ,cast(Case 
              when p.Restrictions = 'NOAIR' then 1
              else 0
            end as bit)         as NoAir
      ,p.Fragile -- признак: хрупкий
      
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
 outer apply (
      select top 1 pd.DestinationLogo, pd.Name
        from tProfilesCustomer pc with (nolock)
        left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
               on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
       where pc.ClientID = c.ClientID
         and pd.DestinationLogo    = o.DestinationLogo
       order by case 
                  when pc.ClientPriceLogo = o.CustomerPriceLogo  then 1
                  else 555
                end
     ) as pd


  left join tMakes b with (nolock index=ao2) -- брент замены
         on cast(b.Code as nvarchar)= o.ReplacementMakeLogo

  left join tPrice p with (nolock index=ao1)
         on p.PriceID = o.PriceID	
         
  left join tPartsStatistics ps (nolock)
         on ps.Make      = o.MakeLogo
        and ps.DetailNum = o.DetailNumber

 where ua.UserID    = dbo.GetUserID()
   and ua.LinkType  = 7
go
grant select on vOrders to public
go
exec setOV 'vOrders', 'V', '20240822', '9'
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vOrders', @desc = 'Список заказов'

