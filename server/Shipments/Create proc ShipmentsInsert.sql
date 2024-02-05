if OBJECT_ID('ShipmentsInsert') is not null
    drop proc ShipmentsInsert
/*
  ShipmentsInsert - загрузка заказов в БД


  pShipments - входящий набор данных

*/
go

Create proc ShipmentsInsert           
as
  set nocount on;
  declare @r int = 0

  Update s 
     set --p.
         s.ShipmentsType       = o.DestinationLogo
        ,s.ShipmentsAmount     = o.ShipmentsAmount
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
    from pShipments s (Updlock)
   cross apply (select Sum(o.AmountPurchaseF)            ShipmentsAmount
                      ,min(o.DestinationLogo)            DestinationLogo
                      ,sum(o.Quantity)                   DetailCount
                      ,sum(isnull(o.WeightKG, 0))        WeightKG
                      ,sum(isnull(o.VolumeKG, 0))        VolumeKG
                      ,sum(isnull(p.WeightKGF, 0))       WeightKGF
                      ,sum(isnull(p.VolumeKGF, 0))       VolumeKGF
                      ,Max(isnull(o.WeightKGAmount, 0))  WeightKGAmount
                      ,max(isnull(o.VolumeKGAmount, 0))  VolumeKGAmount
                      ,min(sp.SuppliersID)               SuppliersID
                  from tOrders o with (nolock)
                  inner join tClients c with (nolock index=ao1)
                          on c.ClientID = o.ClientID
                  inner join tSuppliers sp with (nolock index=ao1)
                          on sp.SuppliersID = c.SuppliersID
                  left join tPrice p with (nolock index=ao1)
                         on p.PriceID = o.PriceID	
                 where o.Invoice = s.Invoice 
                ) o
   where s.Spid = @@SPID

  insert tShipments (       
                         
         ShipmentsDate              
        ,ReceiptDate                
        ,Invoice                    
        ,ShipmentsType              
        ,ShipmentsAmount            
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
        ,p.ShipmentsType              
        ,p.ShipmentsAmount            
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
  from pShipments p (nolock)
 where p.Spid = @@SPid
   and not exists (select 1
                     from tShipments t (nolock)
                    where t.Invoice = p.Invoice)




  Update p
     set p.Amount  = p.WeightKGF * p.WeightKGAmount + (iif(p.VolumeKGF > p.WeightKGF, (p.VolumeKGF-p.WeightKGF) * p.VolumeKGAmount, 0))  
     
    from pShipments p (updlock)
   --inner join tShipments t (updlock)
   --        on t.Invoice = p.Invoice
   where p.Spid = @@SPid

  Update t
     set           
         t.ReceiptDate      = p.ReceiptDate                                        
        ,t.ShipmentsAmount  = p.ShipmentsAmount           
        ,t.DetailCount      = p.DetailCount           
        ,t.WeightKG         = p.WeightKG           
        ,t.VolumeKG         = p.VolumeKG           
        ,t.WeightKGDiff     = p.WeightKGDiff    -- указать разницу сумм вес физический факт минус вес физический из прайса        
        ,t.WeightKGF        = p.WeightKGF           
        ,t.VolumeKGF        = p.VolumeKGF           
        ,t.VolumeKGDiff     = p.VolumeKGDiff   -- указать разницу сумм вес объемный факт минус вес объемный из прайса        
        ,t.WeightKGAmount   = p.WeightKGAmount          
        ,t.VolumeKGAmount	= p.VolumeKGAmount  
        ,t.Amount           = p.Amount
  from pShipments p (nolock)
 inner join tShipments t (updlock)
         on t.Invoice = p.Invoice
 where p.Spid = @@SPid




 --        - (Вес физический факт * WeightKGF из соответствующего профиля доставки) + (если Вес Объемный Факт > Вес Физический Факт, то (Вес Объемный Факт - Вес Физический Факт) * VolumeKGF из соответствующего профиля доставки)

exit_:

return @r
GO
grant exec on ShipmentsInsert to public
go