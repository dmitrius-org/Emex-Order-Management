drop proc if exists ShipmentsTransporterSelect
                     
/*
  ShipmentsTransporterSelect -

*/
go
create proc ShipmentsTransporterSelect
              @TransporterNumber           varchar(64)
as
  set nocount on;
  declare @r        int = 0


  if OBJECT_ID('tempdb..#r') is not null
    drop table #r
  CREATE TABLE #r
  (
      N                           int,
      ShipmentsBoxesID            numeric(18,0), --
      TransporterNumber           varchar(64),  -- Номер груза
      Invoice                     varchar(64), 
      BoxNumber                   numeric(18, 0), -- Номер коробки
      SupplierPhysicalWeight      float, -- Физический вес по данным поставщика
      TransporterPhysicalWeight   float, -- Физический вес по данным перевозчика
      SupplierVolumetricWeight    float, -- Объемный вес по данным поставщика
      TransporterVolumetricWeight float, -- Объемный вес по данным перевозчик
  
      --SupplierWidth               float, -- Ширина по данным поставщика 
      --TransporterWidth            float, -- Ширина по данным перевозчика
      --SupplierLength              float, -- Длина по данным поставщика
      --TransporterLength           float, -- Длина по данным перевозчика
      --SupplierHeight              float, -- Высота по данным поставщика 
      --TransporterHeight           float, -- Высота по данным перевозчика
      ImageLinks                  varchar(MAX),

      OrderID                     numeric(18,0) --
     ,WeightKG                    money         -- Вес Физический
     ,VolumeKG                    money         -- Вес Объемный
     ,WeightKGS                   money         -- Вес Физический
     ,VolumeKGS                   money         -- Вес Объемный
     ,Quantity                    int           -- Количество
     ,Manufacturer                varchar(64)   -- Производитель
     ,DetailNumber                varchar(32)   -- Номер детали
     ,ManufacturerReplacement     varchar(64)   -- Производитель замены
     ,DetailNumberReplacement     varchar(32)   -- Номер детали замены
     ,DetailName                  varchar(256)  -- Название детали
     ,PricePurchase               money         -- Цена закупки факт
     ,AmountPurchase              money         -- Сумма закупки факт
     ,Reference                   varchar(32) 
     ,OrderDetailSubId            varchar(32) 
     ,CustomerSubId               varchar(32) 
     ,ClientName                  varchar(256) 
     ,Type                        int
  );

  insert #r
  (
         ShipmentsBoxesID           
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
  select
         t.ShipmentsBoxesID           
        ,t.TransporterNumber          
        ,t.Invoice                    
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
 -- t.BoxNumber  in  (101376929, 101376932, 101376934)
  insert #r
        (N
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
        ,WeightKG
        ,VolumeKG
        ,WeightKGS  
        ,VolumeKGS  
        ,Reference        
        ,OrderDetailSubId 
        ,CustomerSubId 
        ,Type
         )
  select ROW_NUMBER() over(partition by r.BoxNumber order by o.OrderID)
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
        ,o.PricePurchaseF
        ,o.AmountPurchaseF
        ,isnull(p.[WeightKGF],o.[WeightKG])
        ,isnull(p.[VolumeKGF],o.[VolumeKG])
        ,isnull(p.[WeightKGF],o.[WeightKG])*o.Quantity
        ,isnull(p.[VolumeKGF],o.[VolumeKG])*o.Quantity
        ,o.Reference        
        ,o.OrderDetailSubId 
        ,o.CustomerSubId 
        ,2
    from #r r with (nolock)
   inner join tOrders o with (nolock index=ao4)
           on o.box = r.BoxNumber
   inner join tClients c with (nolock index=PK_tClients_ClientID)
           on c.ClientID = o.ClientID
    left join tMakes b with (nolock index=ao2) -- брент замены
           on cast(b.Code as nvarchar)= o.ReplacementMakeLogo
    left join tPrice p with (nolock index=ao1)
           on p.PriceID = o.PriceID	

   Update r
      set r.SupplierPhysicalWeight      = r2.SupplierPhysicalWeight
         ,r.TransporterPhysicalWeight   = r2.TransporterPhysicalWeight
         ,r.SupplierVolumetricWeight    = r2.SupplierVolumetricWeight
         ,r.TransporterVolumetricWeight = r2.TransporterVolumetricWeight
     from #r r with (updlock)
    inner join #r r2 with (nolock)
            on r2.BoxNumber = r.BoxNumber
           and r2.Type      = 1
   where r.n    = 1
     and r.Type = 2

   select 
          r.N
         ,r.ShipmentsBoxesID
         ,r.TransporterNumber
         --,r.Invoice
         ,r.BoxNumber--Коробка	
         ,r.ClientName--Клиент	
         ,r.Manufacturer--Производитель	
         ,r.DetailNumber--Номер детали	
         ,r.DetailName--Наименование детали	
         ,r.ManufacturerReplacement--Производитель замены	
         ,r.DetailNumberReplacement--Номер детали замены	
         ,r.Quantity--Количество	
         ,r.PricePurchase--Цена закупки руб	
         ,r.AmountPurchase--Сумма закупки руб	
         ,r.WeightKG--Вес Физический Факт	
         ,r.WeightKGS--Вес Физический Факт Сумма	
         ,r.SupplierPhysicalWeight--Вес Физический Поставщик Сумма	
         ,r.TransporterPhysicalWeight--Вес Физический Перевозчик Сумма	
         ,0 WeightL --Вес Физический Превышение	
         ,r.VolumeKG--Вес Объемный Факт	
         ,r.VolumeKGS--Вес Объемный Факт Сумма	
         ,r.SupplierVolumetricWeight--Вес Объемный Поставщик Сумма	
         ,r.TransporterVolumetricWeight--Вес Объемный Перевозчик Сумма	
         ,0 VolumeL--Вес Объемный Превышение	
         ,r.OrderDetailSubId--Штрих-код	
         ,r.CustomerSubId--SubID	
         ,r.Reference--reference	
        --Фото коробки
        --,SupplierWidth              
        --,TransporterWidth           
        --,SupplierLength             
        --,TransporterLength          
        --,SupplierHeight             
        --,TransporterHeight          
        --,ImageLinks        
    from #r r (nolock)
   where r.Type = 2
   order by TransporterNumber

 exit_:
 return @r
go
grant exec on ShipmentsTransporterSelect to public
go
exec setOV 'ShipmentsTransporterSelect', 'P', '20250213', '0'
go

exec ShipmentsTransporterSelect @TransporterNumber= ''
 