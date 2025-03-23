drop proc if exists ShipmentsBoxesFill
                     
/*
  ShipmentsBoxesFill - 
*/
go
create proc ShipmentsBoxesFill
              @IsSave bit = null
as
  set nocount on;

  declare @r int = 0

  declare @ID as ID

  if isnull(@IsSave, 0) = 1
  begin
    Insert tShipmentsBoxes with (rowlock)
           (        
            TransporterNumber          
           ,Invoice                    
           ,BoxNumber                  
           ,SupplierPhysicalWeight     
           ,TransporterPhysicalWeight  
           ,SupplierVolumetricWeight   
           ,TransporterVolumetricWeight           
           ,SupplierWidth              
           ,TransporterWidth           
           ,SupplierLength             
           ,TransporterLength          
           ,SupplierHeight             
           ,TransporterHeight          
           ,ImageLinks                            
           ) 
    select
           p.TransporterNumber          
          ,p.Invoice                    
          ,p.BoxNumber                  
          ,p.SupplierPhysicalWeight     
          ,p.TransporterPhysicalWeight  
          ,p.SupplierVolumetricWeight   
          ,p.TransporterVolumetricWeight           
          ,p.SupplierWidth              
          ,p.TransporterWidth           
          ,p.SupplierLength             
          ,p.TransporterLength          
          ,p.SupplierHeight             
          ,p.TransporterHeight          
          ,p.ImageLinks 
      from pShipmentsBoxesData p with (nolock index=ao1)
     where p.Spid = @@SPid
       and not exists (select 1
                         from tShipmentsBoxes t with (nolock index=ao3)
                        where t.BoxNumber = p.BoxNumber
                       )


    Update t
       set t.TransporterNumber           = p.TransporterNumber           
          ,t.Invoice                     = p.Invoice                    
          ,t.BoxNumber                   = p.BoxNumber                  
          ,t.SupplierPhysicalWeight      = p.SupplierPhysicalWeight     
          ,t.TransporterPhysicalWeight   = p.TransporterPhysicalWeight  
          ,t.SupplierVolumetricWeight    = p.SupplierVolumetricWeight   
          ,t.TransporterVolumetricWeight = p.TransporterVolumetricWeight          
          ,t.SupplierWidth               = p.SupplierWidth              
          ,t.TransporterWidth            = p.TransporterWidth           
          ,t.SupplierLength              = p.SupplierLength             
          ,t.TransporterLength           = p.TransporterLength          
          ,t.SupplierHeight              = p.SupplierHeight             
          ,t.TransporterHeight           = p.TransporterHeight          
          ,t.ImageLinks                  = p.ImageLinks    
    output inserted.ShipmentsBoxesID into @ID 
      from pShipmentsBoxesData p with (nolock index=ao1)
     inner join tShipmentsBoxes t with (Updlock index=ao3)
             on t.BoxNumber = p.BoxNumber
     where p.Spid = @@SPid


  insert tShipmentsBoxesDetail with (rowlock)
        (ShipmentsBoxesID
        ,OrderID
        ,TransporterNumber
        ,Invoice
        ,BoxNumber
        ,Weight
        ,Volume)
  select sb.ShipmentsBoxesID
        ,o.OrderID
        ,sb.TransporterNumber
        ,o.Invoice
        ,sb.BoxNumber
        ,isnull(p.[WeightKGF],o.[WeightKG])
        ,isnull(p.[VolumeKGF],o.[VolumeKG])
    from @ID r 
   inner join tShipmentsBoxes sb (nolock)
           on sb.ShipmentsBoxesID = r.ID
   inner join tOrders o with (nolock index=ao3)
           on o.box = sb.BoxNumber          
    left join tPrice p with (nolock index=ao1)
           on p.PriceID = o.PriceID	
  end


 exit_:
 return @r
go
grant exec on ShipmentsBoxesFill to public
go
exec setOV 'ShipmentsBoxesFill', 'P', '20250213', '0'
go
 