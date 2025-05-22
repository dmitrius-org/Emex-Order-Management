if OBJECT_ID('ShipmentsRefresh') is not null
    drop proc ShipmentsRefresh
/*
  ShipmentsRefresh - загрузка заказов в БД


  pShipments - входящий набор данных

*/
go

Create proc ShipmentsRefresh           
as
  set nocount on;
  declare @r int = 0

  Update s 
     set --p.
         s.DestinationLogo     = o.DestinationLogo
        ,s.DestinationName     = o.DestinationName
        ,s.ShipmentsAmount     = o.ShipmentsAmount
        ,s.ShipmentsAmountR    = o.ShipmentsAmountR
        ,s.DetailCount         = o.DetailCount    
        ,s.WeightKG            = o.WeightKG       
        ,s.VolumeKG            = o.VolumeKG       
        ,s.WeightKGF           = o.WeightKGF      
        ,s.VolumeKGF           = o.VolumeKGF      
        ,s.WeightKGAmount      = o.WeightKGAmount 
        ,s.VolumeKGAmount      = o.VolumeKGAmount 
        ,s.WeightKGDiff        = o.WeightKGF - o.WeightKG    -- указать разницу сумм вес физический факт минус вес физический из прайса  
        ,s.VolumeKGDiff        = o.VolumeKGF - o.VolumeKG    -- указать разницу сумм вес объемный факт минус вес объемный из прайса   
        ,s.SuppliersID         = o.SuppliersID
        ,s.SupplierDelivery    = o.SupplierDelivery
        ,s.ReceiptDate         = cast((dateadd(dd, isnull(o.SupplierDelivery, 0), s.ShipmentsDate)) as date) -- дата отгрузки + срок доставки с профиля доставки      
    from pShipments s with (Updlock index=ao1)
   cross apply (select sum(o.AmountPurchaseF)                    as ShipmentsAmount
                      ,sum(o.Amount)                             as ShipmentsAmountR
                      ,min(o.DestinationLogo)                    as DestinationLogo
                      ,max(o.DestinationName)                    as DestinationName
                      ,sum(o.Quantity)                           as DetailCount
                      ,sum(isnull(o.WeightKG, 0)  * o.Quantity)  as WeightKG
                      ,sum(isnull(o.VolumeKG, 0)  * o.Quantity)  as VolumeKG
                      ,sum(coalesce(p.WeightKGF, o.WeightKG, 0) * o.Quantity) as WeightKGF
                      ,sum(coalesce(p.VolumeKGF, o.VolumeKG, 0) * o.Quantity) as VolumeKGF
                      ,Max(isnull(o.WeightKGAmount, 0))          as WeightKGAmount -- Стоимость кг физического веса. Данные из  tSupplierDeliveryProfiles.WeightKG 
                      ,max(isnull(o.VolumeKGAmount, 0))          as VolumeKGAmount -- Стоимость кг объемного веса. Данные из  tSupplierDeliveryProfiles.VolumeKG
                      ,min(sp.SuppliersID)                       as SuppliersID
                      ,max(sdp.DeliveryTermFromSupplier)         as SupplierDelivery -- “Поставщики” - “Профили доставки” - “Срок доставки”
                  from tOrders o with (nolock)
                  inner join tClients c with (nolock index=ao1)
                          on c.ClientID = o.ClientID
                  inner join tSuppliers sp with (nolock index=ao1)
                          on sp.SuppliersID = c.SuppliersID

                   left join vSupplierDeliveryParam sdp
                          on sdp.ProfilesDeliveryID = o.ProfilesDeliveryID

                   left join vPrice p 
                          on p.PriceID = o.PriceID
                  where o.Invoice = s.Invoice 
                ) o
   where s.Spid = @@SPID


  Update s 
     set s.ShipmentsDate = o.OperDate                    
    from pShipments s with (Updlock index=ao1)
   cross apply (select Max(p.OperDate)  OperDate
                  from tOrders o with (nolock index=ao1)
                  inner join tProtocol p with (nolock index=ao2)
                          on p.ObjectID = o.OrderID 
                  inner join tNodes n  with (nolock index=ao2)
                          on n.Brief  = 'Send'
                         and n.NodeID = p.NewStateID
                 where o.Invoice = s.Invoice
                ) o
   where s.Spid = @@SPID
     and isnull(s.ShipmentsDate, '') = ''  

  insert tShipments (       
                         
         ShipmentsDate              
        ,ReceiptDate                
        ,Invoice                    
        ,DestinationLogo   
        ,DestinationName
        ,ShipmentsAmount    
        ,ShipmentsAmountR
        ,DetailCount                
        ,WeightKG                   
        ,VolumeKG                         
        ,WeightKGF                  
        ,VolumeKGF    
        ,WeightKGDiff   
        ,VolumeKGDiff    
        ,WeightKGAmount             
        ,VolumeKGAmount	            
        
        ,SupplierWeightKG           
        ,SupplierVolumeKG           
        --,SupplierDiffVolumeWeigh    
        --считать доставку исходя из
        ,TransporterWeightKG        
        ,TransporterVolumeKG        
      --  ,TransporterDiffVolumeWeigh 
        ,SuppliersID
       )
select 
         p.ShipmentsDate              
        ,p.ReceiptDate                
        ,p.Invoice                    
        ,p.DestinationLogo   
        ,p.DestinationName  
        ,p.ShipmentsAmount  
        ,p.ShipmentsAmountR
        ,p.DetailCount                
        ,p.WeightKG                   
        ,p.VolumeKG                          
        ,p.WeightKGF                  
        ,p.VolumeKGF        
        ,p.WeightKGDiff 
        ,p.VolumeKGDiff 
        ,p.WeightKGAmount             
        ,p.VolumeKGAmount	            
        
        ,p.SupplierWeightKG           
        ,p.SupplierVolumeKG           
        --,p.SupplierDiffVolumeWeigh    
        --считать доставку исходя из
        ,p.TransporterWeightKG        
        ,p.TransporterVolumeKG        
       -- ,p.TransporterDiffVolumeWeigh 
        ,SuppliersID
  from pShipments p with (nolock index=ao1)
 where p.Spid = @@SPid
   and p.ShipmentsDate is not null
   and not exists (select 1
                     from tShipments t with (nolock index=ao2)
                    where t.Invoice = p.Invoice)




  Update p
     set p.Amount   = p.WeightKG  * p.WeightKGAmount + (iif(p.VolumeKG - p.WeightKG > 0, p.VolumeKG-p.WeightKG, 0) * p.VolumeKGAmount)  
        ,p.AmountF  = p.WeightKGF * p.WeightKGAmount + (iif(p.VolumeKGF - p.WeightKGF > 0, p.VolumeKGF - p.WeightKGF, 0) * p.VolumeKGAmount)  
    from pShipments p with (Updlock index=ao1)
   --inner join tShipments t (updlock)
   --        on t.Invoice = p.Invoice
   where p.Spid = @@SPid

  Update t
     set           
         t.ReceiptDate       = isnull(p.ReceiptDate, t.ReceiptDate) -- Ожидаемая дата поступления                                  
        ,t.ShipmentsAmount   = p.ShipmentsAmount   
        ,t.ShipmentsAmountR  = p.ShipmentsAmountR  
        ,t.DetailCount       = p.DetailCount           
        ,t.WeightKG          = p.WeightKG           
        ,t.VolumeKG          = p.VolumeKG           
        ,t.WeightKGDiff      = p.WeightKGDiff    -- указать разницу сумм вес физический факт минус вес физический из прайса        
        ,t.WeightKGF         = p.WeightKGF           
        ,t.VolumeKGF         = p.VolumeKGF           
        ,t.VolumeKGDiff      = p.VolumeKGDiff   -- указать разницу сумм вес объемный факт минус вес объемный из прайса        
        ,t.WeightKGAmount    = p.WeightKGAmount          
        ,t.VolumeKGAmount	 = p.VolumeKGAmount  
        ,t.Amount            = p.Amount
        ,t.AmountF           = p.AmountF
        ,t.DestinationName   = p.DestinationName
    from pShipments p with (nolock index=ao1)
   inner join tShipments t with (Updlock index=ao2)
           on t.Invoice = p.Invoice
   where p.Spid = @@SPid

   -- пересчет баланса
   -- пока так, нужна массовая процедура !!!
    DECLARE @ClientID numeric(18, 0)

    -- Определение курсора для выборки всех идентификаторов клиентов из таблицы tClients
    DECLARE ClientCursor CURSOR FOR
    select distinct
           o.ClientID
      from pShipments p with (nolock index=ao1)
     inner join tOrders o with (Updlock index=ao3)
             on o.Invoice = p.Invoice
    where p.Spid = @@SPid

    -- Открываем курсор и начинаем обработку каждой записи
    OPEN ClientCursor

    FETCH NEXT FROM ClientCursor INTO @ClientID

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Вызов процедуры RestCalc для текущего ClientID
        EXEC RestCalc @ClientID = @ClientID

        -- Переход к следующей записи в курсоре
        FETCH NEXT FROM ClientCursor INTO @ClientID
    END

    -- Закрываем и освобождаем курсор после завершения обработки
    CLOSE ClientCursor
    DEALLOCATE ClientCursor



exit_:

return @r
GO
grant exec on ShipmentsRefresh to public
go
exec setOV 'ShipmentsRefresh', 'P', '20250531', '5'
go