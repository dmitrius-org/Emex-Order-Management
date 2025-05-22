drop proc if exists ShipmentsTransporterSelect
                     
/*
  ShipmentsTransporterSelect -

*/
go
create proc ShipmentsTransporterSelect
              @TransporterNumber varchar(64)
             ,@Invoice           varchar(64)
as
  set nocount on;
  declare @r        int = 0
  delete pShipmentsBoxes from pShipmentsBoxes (rowlock) where spid = @@SPID
  insert pShipmentsBoxes with (rowlock)
  (
         Spid
        ,ShipmentsBoxesID           
        ,TransporterNumber          
        ,Invoice                    
        ,BoxNumber                  
        ,SupplierPhysicalWeight     
        ,TransporterPhysicalWeight  
        ,SupplierVolumetricWeight   
        ,TransporterVolumetricWeight
        --,SupplierWidth              
        --,TransporterWidth           
        --,SupplierLength             
        --,TransporterLength          
        --,SupplierHeight             
        --,TransporterHeight          
        --,ImageLinks  
        ,Type
  )
  select @@SPID
        ,t.ShipmentsBoxesID           
        ,t.TransporterNumber          
        ,@Invoice --t.Invoice                    
        ,t.BoxNumber     
      
        ,t.SupplierPhysicalWeight        --
        ,t.TransporterPhysicalWeight  
        ,t.SupplierVolumetricWeight   
        ,t.TransporterVolumetricWeight
      --
      --,t.SupplierWidth              
      --,t.TransporterWidth           
      --,t.SupplierLength             
      --,t.TransporterLength          
      --,t.SupplierHeight             
      --,t.TransporterHeight          
      --,t.ImageLinks    
        ,1
    from tShipmentsBoxes t (nolock)
   where t.TransporterNumber = @TransporterNumber

  insert pShipmentsBoxes
        (Spid
        ,N
        ,BoxNumber
        ,OrderID
        ,ClientName
        ,Manufacturer
        ,DetailNumber
        ,DetailName
        ,ManufacturerReplacement
        ,DetailNumberReplacement
        ,Quantity
        ,PricePurchase 
        ,AmountPurchase
        ,WeightKGOld 
        ,VolumeKGOld 
        ,WeightKG
        ,VolumeKG
        ,WeightKGS  
        ,VolumeKGS  
        ,Reference        
        ,OrderDetailSubId 
        ,CustomerSubId 
        ,Type
         )
  select @@SPID
        ,ROW_NUMBER() over(partition by r.BoxNumber order by o.OrderID)
        ,r.BoxNumber
        ,o.OrderID
        ,c.Brief--Клиент
        ,o.Manufacturer --Производитель
        ,o.DetailNumber
        ,ltrim(rtrim(Replace( case 
                              when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                              then p.DetailName
                              else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                            end  
                           ,o.[DetailNumber]  
                           ,'')))  
        ,b.Name  
        ,nullif(o.ReplacementDetailNumber, '')
        ,o.Quantity
        ,o.Price
        ,o.Amount
        ,sbd.[Weight]    -- WeightKGOld 
        ,sbd.[Volume]    -- VolumeKGOld 
        ,isnull(p.[WeightKGF],o.[WeightKG])
        ,isnull(p.[VolumeKGF],o.[VolumeKG])
        ,isnull(p.[WeightKGF],o.[WeightKG])*o.Quantity
        ,isnull(p.[VolumeKGF],o.[VolumeKG])*o.Quantity
        ,o.Reference        
        ,o.OrderDetailSubId 
        ,o.CustomerSubId 
        ,2
    from pShipmentsBoxes r with (nolock)
   inner join tShipmentsBoxesDetail sbd (nolock)
           on sbd.ShipmentsBoxesID = r.ShipmentsBoxesID
   inner join tOrders o with (nolock index=ao1)
           on o.OrderID = sbd.OrderID
          --and o.box     = r.BoxNumber          
   inner join tClients c with (nolock index=PK_tClients_ClientID)
           on c.ClientID = o.ClientID
    left join tMakes b with (nolock index=ao2) -- брент замены
           on cast(b.Code as nvarchar)= o.ReplacementMakeLogo
  left join vPrice p 
         on p.PriceID = o.PriceID	
  --left join tPrice p with (nolock index=PK_tPrice_ID)
  --       on p.PriceID = o.PriceID	
  --left join tParts pt with (nolock index=PK_tParts_ID)
  --       on pt.PartID = p.PartID
   where r.spid = @@spid 

   Update r
      set r.SupplierPhysicalWeight      = r2.SupplierPhysicalWeight
         ,r.TransporterPhysicalWeight   = r2.TransporterPhysicalWeight
         ,r.SupplierVolumetricWeight    = r2.SupplierVolumetricWeight
         ,r.TransporterVolumetricWeight = r2.TransporterVolumetricWeight
     from pShipmentsBoxes r with (updlock)
    inner join pShipmentsBoxes r2 with (nolock)
            on r2.spid = @@spid 
           and r2.BoxNumber = r.BoxNumber
           and r2.Type      = 1
   where r.spid = @@spid 
     and r.n    = 1
     and r.Type = 2

   select r.ID
         ,r.N
         ,r.ShipmentsBoxesID
         ,r.TransporterNumber
         ,r.Invoice
         ,r.BoxNumber                     --Коробка	
         ,r.ClientName                    --Клиент	
         ,r.Manufacturer                  --Производитель	
         ,r.DetailNumber                  --Номер детали	
         ,r.DetailName                    --Наименование детали	
         ,r.ManufacturerReplacement       --Производитель замены	
         ,r.DetailNumberReplacement       --Номер детали замены	
         ,r.Quantity                      --Количество	
         ,r.PricePurchase                 --Цена закупки руб	
         ,r.AmountPurchase                --Сумма закупки руб	
         ,r.WeightKG                      --Вес Физический Факт	
         ,r.WeightKGS                     --Вес Физический Факт Сумма	
         ,r.SupplierPhysicalWeight        --Вес Физический Поставщик Сумма	
         ,r.TransporterPhysicalWeight     --Вес Физический Перевозчик Сумма	
         ,0 WeightL                       --Вес Физический Превышение	
         ,r.VolumeKG                      --Вес Объемный Факт	
         ,r.VolumeKGS                     --Вес Объемный Факт Сумма	
         ,r.SupplierVolumetricWeight      --Вес Объемный Поставщик Сумма	
         ,r.TransporterVolumetricWeight   --Вес Объемный Перевозчик Сумма	
         ,0 VolumeL                       --Вес Объемный Превышение	
         ,r.OrderDetailSubId              --Штрих-код	
         ,r.CustomerSubId                 --SubID	
         ,r.Reference                     --reference
         ,r.OrderID

         ,r.WeightKGOld                   -- веса при загрузке отгрузки
         ,r.VolumeKGOld                   -- веса при загрузке отгрузки
        --Фото коробки
        --,SupplierWidth              
        --,TransporterWidth           
        --,SupplierLength             
        --,TransporterLength          
        --,SupplierHeight             
        --,TransporterHeight          
        --,ImageLinks        
    from pShipmentsBoxes r (nolock)
   where r.spid = @@spid 
     and r.Type = 2
   order by TransporterNumber

 exit_:
 return @r
go
grant exec on ShipmentsTransporterSelect to public
go
exec setOV 'ShipmentsTransporterSelect', 'P', '20250531', '5'
go

exec ShipmentsTransporterSelect @TransporterNumber= 'QBLS169C', @Invoice = '250219'
 