if OBJECT_ID('OrderArchive') is not null
    drop proc OrderArchive
/*
  OrderArchive - Архив синхронизационных данных по заказу.
                 
*/
go

Create proc OrderArchive
as
 set nocount on; 
 declare @r int = 0

--сохранение в архив
INSERT INTO [hOrders]
      ([ClientID]
      ,[OrderDate]
      ,[OrderNum]
      ,[StatusID]
      ,[isCancel]
      ,[isCancelToClient]
      ,[Manufacturer]
      ,[CustomerPriceLogo]
      ,[PriceLogo]
      ,[DetailNumber]
      ,[DetailName]
      ,[MakeLogo]
      ,[DetailID]
      ,[Quantity]
      ,[Price]
      ,[Amount]
      ,[PricePurchase]
      ,[PricePurchaseOrg]
      ,[AmountPurchase]
      ,[Discount]
      ,[PricePurchaseF]
      ,[AmountPurchaseF]
      ,[WeightKG]
      ,[VolumeKG]
      ,[Margin]
      ,[MarginF]
      ,[Profit]
      ,[Income]
      ,[IncomePRC]
      ,[DeliveryPlanDateSupplier]
      ,[DeliveryRestTermSupplier]
      ,[DeliveredDateToSupplier]
      ,[ProfilesDeliveryID]
      ,[DeliveryDaysReserve]
      ,[DeliveryNextDate]
      ,[DeliveryDateToCustomer]
      ,[DeliveryTermToCustomer]
      ,[DeliveryRestToCustomer]
      ,[ReplacementMakeLogo]
      ,[ReplacementDetailNumber]
      ,[PriceID]
      ,[BasketId]
      ,[EmexOrderID]
      ,[CustomerSubId]
      ,[OrderDetailSubId]
      ,[Reference]
      ,[EmexQuantity]
      ,[OverPricing]
      ,[Warning]
      ,[Flag]
      ,[UserID]
      ,[inDatetime]
      ,[updDatetime]
      ,[ReplacementPrice]
      ,[ParentID]
      ,[OrderID]
      ,[Invoice]      
	  ,[FileDate]
	  ,[DestinationLogo]
      ,[Commission]          -- Комиссия от продажи	
      ,[CommissionAmount]
      ,[Taxes]
      ,[WeightKGAmount]
      ,[VolumeKGAmount]
      ,[ExtraKurs]
	  ,[Reliability]
      ,[ClientOrderNum]
      ,[hInDatetime]
      )
select distinct
       o.[ClientID]
      ,o.[OrderDate]
      ,o.[OrderNum]
      ,o.[StatusID]
      ,o.[isCancel]
      ,o.[isCancelToClient]
      ,o.[Manufacturer]
      ,o.[CustomerPriceLogo]
      ,o.[PriceLogo]
      ,o.[DetailNumber]
      ,o.[DetailName]
      ,o.[MakeLogo]
      ,o.[DetailID]
      ,o.[Quantity]
      ,o.[Price]
      ,o.[Amount]
      ,o.[PricePurchase]
      ,o.[PricePurchaseOrg]
      ,o.[AmountPurchase]
      ,o.[Discount]
      ,o.[PricePurchaseF]
      ,o.[AmountPurchaseF]
      ,o.[WeightKG]
      ,o.[VolumeKG]
      ,o.[Margin]
      ,o.[MarginF]
      ,o.[Profit]
      ,o.[Income]
      ,o.[IncomePRC]
      ,o.[DeliveryPlanDateSupplier]
      ,o.[DeliveryRestTermSupplier]
      ,o.[DeliveredDateToSupplier]
      ,o.[ProfilesDeliveryID]
      ,o.[DeliveryDaysReserve]
      ,o.[DeliveryNextDate]
      ,o.[DeliveryDateToCustomer]
      ,o.[DeliveryTermToCustomer]
      ,o.[DeliveryRestToCustomer]
      ,o.[ReplacementMakeLogo]
      ,o.[ReplacementDetailNumber]
      ,o.[PriceID]
      ,o.[BasketId]
      ,o.[EmexOrderID]
      ,o.[CustomerSubId]
      ,o.[OrderDetailSubId]
      ,o.[Reference]
      ,o.[EmexQuantity]
      ,o.[OverPricing]
      ,o.[Warning]
      ,o.[Flag]
      ,o.[UserID]
      ,o.[inDatetime]
      ,o.[updDatetime]
      ,o.[ReplacementPrice]
      ,o.[ParentID]
      ,o.[OrderID]
      ,o.[Invoice]
      ,o.[FileDate]
	  ,o.[DestinationLogo]
      ,o.[Commission]          -- Комиссия от продажи	
      ,o.[CommissionAmount]
      ,o.[Taxes]
      ,o.[WeightKGAmount]
      ,o.[VolumeKGAmount]
      ,o.[ExtraKurs]
	  ,o.[Reliability]
      ,o.[ClientOrderNum]
      ,GetDate()
  from pMovement p (nolock)
 inner join tOrders o (rowlock) 
         on p.OrderNumber      = o.EmexOrderID
        and p.DetailNum        = o.DetailNumber
        and p.CustomerSubId    = o.CustomerSubId
        and p.Reference        = o.Reference 
 where p.spid = @@spid

  exit_:

  return @r

GO
grant exec on OrderArchive to public
go
