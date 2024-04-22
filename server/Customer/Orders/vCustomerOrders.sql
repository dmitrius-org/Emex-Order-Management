if OBJECT_ID('vCustomerOrders') is not null
    drop view vCustomerOrders
go
/* **********************************************************						
vCustomerOrders - список заказов
********************************************************** */

create view vCustomerOrders
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
	  --,o.[isCancelToClient] -- отказ отправлен клиенту
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
      --,o.[DetailID]
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
      ,o.[Margin]
      ,o.[MarginF]
      ,o.[Profit]
      ,o.[Income]
      ,o.[IncomePRC]
      --,o.[PlanDate]
      --,o.[Rest]
      ,o.[DeliveryPlanDateSupplier]
      ,case 
         when isnull(o.DeliveredDateToSupplier, '') = ''
         then DATEDIFF(dd, getDate(), o.[DeliveryPlanDateSupplier])
         else DATEDIFF(dd, o.DeliveredDateToSupplier, o.[DeliveryPlanDateSupplier])
       end  [DeliveryRestTermSupplier] -- Остаток срока до поступления поставщику	
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
      ,o.Comment                
	  ,cast(b.Name as nvarchar(128)) as ReplacementManufacturer -- наименование бренда замены
	  ,o.ReplacementMakeLogo           -- бренд замены
	  ,o.ReplacementDetailNumber       -- номер замены
	  ,o.ReplacementPrice              -- Изменение цены
	  ,o.CustomerPriceLogo             -- Наименование прайса заказа от клиента

    --  ,u.Name as UserName
      ,p.Restrictions                  -- ограничение
      ,o.Invoice                       -- номер инвойса

      ,o.[inDatetime]
      ,o.[updDatetime]
      ,o.OrderNum              Reference
	  ,o.Flag&1 /*1 - начальное состояние */ 
                                as IsStartState
      ,o.Flag
  FROM [tOrders] o (nolock)
 inner join tUser u with (nolock index=ao1)
         on u.UserID = o.UserID
 inner join tNodes s with (nolock index=ao1)
         on s.NodeID = o.[StatusID]
        and s.Type   = 0 

 --left join tProfilesCustomer pc with (nolock)
 --        on pc.ClientPriceLogo = o.CustomerPriceLogo
 --left join tProfilesDelivery pd with (nolock)
 --        on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
 
 inner join tClients c with (nolock index=ao1)
         on c.ClientID = o.ClientID

  left join tMakes b (nolock)
         on b.Code = o.ReplacementMakeLogo

  left join tPrice p with (nolock index=ao1)
         on p.PriceID = o.PriceID		 
  
go
grant select on vCustomerOrders to public
go
exec setOV 'vCustomerOrders', 'V', '20240419', '2'
go
 
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vOrders', @desc = 'Список заказов'

select * from vCustomerOrders  where ClientID =31
