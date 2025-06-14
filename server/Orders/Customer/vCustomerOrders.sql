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
      ,o.[SuppliersID]
      ,c.[Brief]         as ClientName
      ,o.[OrderDate]
      ,o.[PriceLogo]
      ,o.[OrderNum]
      ,o.[StatusID]
      ,s.[Name]          as StatusName -- статус/состояние
      ,o.[isCancel]
      ,o.[Manufacturer]
      ,o.[DetailNumber]
      ,o.MakeLogo
      ,ltrim(rtrim(Replace( case 
                  when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                  then p.DetailName
                  else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                end  
               ,o.[DetailNumber]  
               ,'')))    as DetailName
      ,o.[Quantity]
      ,o.[Price]
      ,o.[Amount]
      ,o.[PricePurchase] -- используем в форме редактирования
      ,o.[WeightKG]
      ,o.[VolumeKG]
      ,p.[WeightKGF]
      ,p.[VolumeKGF]
      --
      ,o.[DeliveryPlanDateSupplier]    -- Плановая дата поступления поставщику
      ,nullif(od.[DeliveryPlanDateSupplier], o.[DeliveryPlanDateSupplier]) as DeliveryPlanDateSupplier2-- Плановая дата поступления поставщику после изменения
      -- 
      ,isnull(od.[DeliveryRestTermSupplier], o.[DeliveryRestTermSupplier]) as DeliveryRestTermSupplier-- Остаток срока до поступления поставщику	
      --
      ,o.DeliveryTerm as DeliveryTermSupplier  -- Срок до поступления поставщику
      ,nullif(od.DeliveryTermSupplier, o.[DeliveryTerm]) as DeliveryTermSupplier2 -- Срок доставки поставщику после изменения
      --
      ,o.DeliveredDateToSupplier               -- Доставлена поставщику
      --
      ,o.DeliveryDaysReserve                   -- Дней запаса до вылета	
      ,nullif(o.DeliveryDaysReserve2, o.DeliveryDaysReserve) as DeliveryDaysReserve2 --
      --
      ,o.DeliveryNextDate                      -- Ближайшая дата вылета
      ,nullif(o.DeliveryNextDate2, o.DeliveryNextDate) as DeliveryNextDate2-- Ближайшая дата вылета, рассчитывается если прошёл срок DeliveryNextDate
      --
      ,o.DeliveryDateToCustomer                -- Дата поставки клиенту	
      ,nullif(oc.DeliveryDateToCustomer, o.DeliveryDateToCustomer) as DeliveryDateToCustomer2 --
      ,o.DeliveryTermToCustomer	               -- Срок поставки клиенту	
      ,nullif(oc.DeliveryTermToCustomer, o.DeliveryTermToCustomer) as DeliveryTermToCustomer2 --
      ,o.DeliveryRestToCustomer                -- Остаток срока до поставки клиенту
	 
     ,o.OverPricing                            -- превышение
      ,o.Comment                
	  ,cast(b.Name as nvarchar(128)) as ReplacementManufacturer -- наименование бренда замены
	  ,o.ReplacementDetailNumber               -- номер замены
      ,cast(o.Invoice as varchar(64)) as Invoice -- номер инвойса
      ,coalesce(o.DestinationName, pd.DestinationName) as DestinationName -- Направление отгрузки       
      ,coalesce(o.DestinationLogo, pd.DestinationLogo) as DestinationLogo -- используем в форме редактирования
      ,coalesce(o.ProfilesCustomerID, pd.ProfilesCustomerID) ProfilesCustomerID
      ,coalesce(sh.ReceiptDate2, sh.ReceiptDate) ReceiptDate -- Ожидаемая дата поступления
      ,o.OrderDetailSubId
      ,o.Comment2
      ,um.UnreadMessagesCount
      ,um.AllMessageCount

      ,o.[inDatetime]
      ,o.[updDatetime]
      ,o.Flag
  FROM tOrders o with (nolock index=ao2)
 inner join tNodes s with (nolock index=ao1)
         on s.NodeID = o.[StatusID]
        and s.Type   = 0 
 inner join tClients c with (nolock index=ao1)
         on c.ClientID = o.ClientID

 --outer apply (
 --      select top 1 
 --             pc.ProfilesCustomerID,
 --             pd.DestinationLogo,
 --             pd.Name
 --        from tProfilesCustomer pc with (nolock index=ao2)
 --        left join t SupplierDeliveryProfiles pd with (nolock index=ao1)
 --               on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
 --       where pc.ClientID = c.ClientID
 --         and (pc.ProfilesCustomerID = o.ProfilesCustomerID 
 --           or pd.DestinationLogo    = o.DestinationLogo)
 --       order by case
 --                  when pc.ProfilesCustomerID = o.ProfilesCustomerID  then 1
 --                  when pc.ClientPriceLogo = o.CustomerPriceLogo  then 2
 --                  else 555
 --                end
 --      ) as pd


 outer apply (
       select top 1 
              cp.DestinationLogo, 
              cp.DestinationName, 
              --cp.DeliveryTermFromSupplier,
              --cp.DeliveryTermCustomer,
              cp.ProfilesCustomerID
         from vClientProfilesParam cp 
        where cp.ProfilesCustomerID = o.ProfilesCustomerID
        order by case
                   when cp.ProfilesCustomerID = o.ProfilesCustomerID  then 1
                   when cp.ProfilesDeliveryID = o.ProfilesDeliveryID  then 2
                  -- when pc.ClientPriceLogo = o.CustomerPriceLogo  then 2
                   else 555
                 end
     ) as pd

  left join vOrdersDeliverySupplier od  
         on od.OrderID = o.OrderID

  left join vOrdersDeliveryCustomer oc  
         on oc.OrderID = o.OrderID

  left join tMakes b with (nolock index=ao2)
         on b.Code = o.ReplacementMakeLogo

  left join tPrice p with (nolock index=ao1)
         on p.PriceID = o.PriceID	
         
  left join tShipments sh with (nolock index=ao2)
         on sh.Invoice = o.Invoice

 outer apply (
              select count(*) AllMessageCount
                    ,sum(case 
                             when cm.Flag&2 = 0 then 1
                             else 0
                         end) UnreadMessagesCount
                from tChats ct with (nolock index=ao3)
               inner join tChatsMessage cm with (nolock index=ao2)
                       on cm.ChatID = ct.ChatID
                      and cm.Flag&1 = 1
               where ct.OrderID = o.OrderID
              ) as um
  
go
grant select on vCustomerOrders to public
go
exec setOV 'vCustomerOrders', 'V', '20250613', '38'
go
