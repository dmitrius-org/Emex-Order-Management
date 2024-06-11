 -- Данные по инвойсам
 delete from tShipments
 delete pShipments from pShipments (rowlock) where Spid = @@Spid 


 insert pShipments
       (Spid, Invoice/*, ShipmentsDate*/)           
 select distinct @@Spid, Invoice--, GetDate()
   from tOrders 
  where  Invoice = '224812'

 
 --exec ShipmentsInsert
    
   select
         ShipmentsType       = o.DestinationLogo
        ,ShipmentsAmount     = o.ShipmentsAmount
        ,DetailCount         = o.DetailCount    
        ,WeightKG            = o.WeightKG       
        ,VolumeKG            = o.VolumeKG       
        ,WeightKGF           = o.WeightKGF      
        ,VolumeKGF           = o.VolumeKGF      
        ,WeightKGAmount      = o.WeightKGAmount 
        ,VolumeKGAmount      = o.VolumeKGAmount 
        ,WeightKGDiff        = o.WeightKGF - o.WeightKG    -- указать разницу сумм вес физический факт минус вес физический из прайса  
        ,VolumeKGDiff        = o.VolumeKGF - o.VolumeKG    -- указать разницу сумм вес объемный факт минус вес объемный из прайса   
        ,SuppliersID         = o.SuppliersID
    from pShipments s with (Updlock index=ao1)
   cross apply (select Sum(o.AmountPurchaseF)                    as ShipmentsAmount
                      ,max(o.DestinationLogo)                    as DestinationLogo
                      ,sum(o.Quantity)                           as DetailCount
                      ,sum(isnull(o.WeightKG, 0)  * o.Quantity)  as WeightKG
                      ,sum(isnull(o.VolumeKG, 0)  * o.Quantity)  as VolumeKG
                      ,sum(coalesce(p.WeightKGF, o.WeightKG, 0) * o.Quantity) as WeightKGF
                      ,sum(coalesce(p.VolumeKGF, o.VolumeKG, 0) * o.Quantity) as VolumeKGF
                      ,Max(isnull(o.WeightKGAmount, 0))          as WeightKGAmount -- Стоимость кг физического веса. Данные из  tSupplierDeliveryProfiles.WeightKG 
                      ,max(isnull(o.VolumeKGAmount, 0))          as VolumeKGAmount -- Стоимость кг объемного веса. Данные из  tSupplierDeliveryProfiles.VolumeKG
                      ,min(sp.SuppliersID)                       as SuppliersID
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


select *
                  from tOrders
                  where Invoice = '224812'
    
   select
          o.*
       
    from pShipments s with (Updlock index=ao1)
   cross apply (select o.*
                  from tOrders o with (nolock)
                  left join tClients c with (nolock index=ao1)
                          on c.ClientID = o.ClientID
                  left join tSuppliers sp with (nolock index=ao1)
                          on sp.SuppliersID = c.SuppliersID
                  left join tPrice p with (nolock index=ao1)
                         on p.PriceID = o.PriceID	
                 where o.Invoice = s.Invoice 
                ) o
   where s.Spid = @@SPID

select *   from tShipments (nolock) 
--where Invoice = '225221'