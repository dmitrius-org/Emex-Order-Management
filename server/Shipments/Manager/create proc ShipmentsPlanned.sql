if OBJECT_ID('ShipmentsPlanned') is not null
    drop proc ShipmentsPlanned
/*
  ShipmentsPlanned - Плановые отгрузки


  pShipments - исходящий набор данных

*/
go

Create proc ShipmentsPlanned           
as
set nocount on;
declare @r int = 0
 
delete pShipments from pShipments where Spid = @@SPID

insert pShipments (       
       Spid   
      ,ShipmentsID
      ,ShipmentsDate              
      ,ReceiptDate                
     -- ,Invoice                    
      ,DestinationLogo   
      ,DestinationName
      ,ShipmentsAmount    
      ,ShipmentsAmountR
      ,DetailCount                
      ,WeightKG                   
      ,VolumeKG                         
      ,WeightKGF                  
      ,VolumeKGF    
     -- ,WeightKGDiff   
     -- ,VolumeKGDiff    
      ,WeightKGAmount             
      ,VolumeKGAmount	            
      
      --,SupplierWeightKG           
     -- ,SupplierVolumeKG           
      --,SupplierDiffVolumeWeigh    
      --считать доставку исходя из
     -- ,TransporterWeightKG        
     -- ,TransporterVolumeKG        
    --  ,TransporterDiffVolumeWeigh 
      ,SuppliersID
     )
Select 
       @@SPID
      ,DENSE_RANK() OVER (
            ORDER BY 
                o.SuppliersID, 
                o.DestinationLogo,
                o.DestinationName,
                ISNULL(o.DeliveryNextDate2, o.DeliveryNextDate)
        ) 
      ,isnull(o.DeliveryNextDate2, o.DeliveryNextDate) ShipmentsDate                   -- дата отгрузки
      ,dateadd(dd, coalesce(nullif(o.DeliveryTermFromSupplier2, 0), nullif(o.DeliveryTermFromSupplier, 0), sdp.DeliveryTermFromSupplier), isnull(o.DeliveryNextDate2, o.DeliveryNextDate)) ReceiptDate -- ожидаемая дата поступления (расчетное поле)
      ,o.DestinationLogo   -- тип отправки
      ,o.DestinationName 
      ,o.AmountPurchaseF                                  ShipmentsAmount   -- сумма отгрузки в долларах
      ,o.Amount                                           ShipmentsAmountR
      ,o.Quantity                                         DetailCount       -- количество деталей
      ,isnull(o.WeightKG, 0)  * o.Quantity                WeightKG          -- вес физический (по прайсу)
      ,isnull(o.VolumeKG, 0)  * o.Quantity                VolumeKG          -- вес объемный (по прайсу)
      ,coalesce(p.WeightKGF, o.WeightKG, 0) * o.Quantity  WeightKGF         -- указать сумму вес физический факт
      ,coalesce(p.VolumeKGF, o.VolumeKG, 0) * o.Quantity  VolumeKGF         -- указать сумму вес объемный факт              --
      ,isnull(o.WeightKGAmount, 0)                        WeightKGAmount    -- выводить ставки за физ кг и объем кг исходя из типа доставки
      ,isnull(o.VolumeKGAmount, 0)                        VolumeKGAmount
      ,o.SuppliersID
  from tNodes n (nolock)
 inner join tOrders o (nolock)
         on o.StatusID = n.NodeID 
 inner join tSuppliers s (nolock)
         on s.SuppliersID = o.SuppliersID
  left join vSupplierDeliveryParam sdp
         on sdp.ProfilesDeliveryID = o.ProfilesDeliveryID
  left join vPrice p 
         on p.PriceID = o.PriceID	
 where n.NodeID in (
                     6--ReceivedOnStock	Получено на склад в ОАЭ
                    ,7--ReadyToSend	Готово к отправке из ОАЭ
                   )
 order by ShipmentsDate asc

Update p
   set p.Amount         = p.WeightKG  * p.WeightKGAmount + (iif(p.VolumeKG  - p.WeightKG  > 0, p.VolumeKG  - p.WeightKG, 0) * p.VolumeKGAmount)  
      ,p.AmountF        = p.WeightKGF * p.WeightKGAmount + (iif(p.VolumeKGF - p.WeightKGF > 0, p.VolumeKGF - p.WeightKGF, 0) * p.VolumeKGAmount)  
      ,p.WeightKGDiff   = p.WeightKGF - p.WeightKG    -- указать разницу сумм вес физический факт минус вес физический из прайса  
      ,p.VolumeKGDiff   = p.VolumeKGF - p.VolumeKG    -- указать разницу сумм вес объемный факт минус вес объемный из прайса   
  from pShipments p with (Updlock index=ao1)
 where p.Spid = @@SPid

exit_:

return @r
GO
grant exec on ShipmentsPlanned to public
go
exec setOV 'ShipmentsPlanned', 'P', '20250531', '5'
go