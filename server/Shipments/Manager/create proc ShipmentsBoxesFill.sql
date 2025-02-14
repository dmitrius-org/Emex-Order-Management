drop proc if exists ShipmentsBoxesFill
                     
/*
  ShipmentsBoxesFill - 
*/
go
create proc ShipmentsBoxesFill
              @IsSave bit = null
as
  set nocount on;

  declare @r        int = 0

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
                         from tShipmentsBoxes t (nolock)
                        where t.BoxNumber = p.BoxNumber
                       )
    Update t
       set           
           t.TransporterNumber           = p.TransporterNumber           
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
      from pShipmentsBoxesData p with (nolock index=ao1)
     inner join tShipmentsBoxes t with (Updlock index=ao3)
             on t.BoxNumber = p.BoxNumber
     where p.Spid = @@SPid

    --delete pAuditInsert from pAuditInsert (rowlock) where spid=@@spid
    --insert pAuditInsert with (rowlock)
    --      (Spid
    --      ,ObjectID
    --      ,ObjectTypeID
    --      ,ActionID
    --      ,Comment
    --      )
    --select @@Spid 
    --      ,t.ShipmentsID       	         
    --      ,10        
    --      ,2      
    --      ,'Изменение информации о грузе'
    --   from pShipmentsTransporterData p with (nolock index=ao1)
    --  inner join tShipments t with (nolock index=ao2)
    --          on t.Invoice = p.Invoice
    --  where p.Spid = @@SPid
            
    --exec MassAuditInsert

  end

  --if @@ROWCOUNT > 0
  --begin
  --  Update t
  --     set t.TransporterAmount  = t.TransporterWeightKG * t.WeightKGAmount + (iif(t.TransporterVolumeKG - t.TransporterWeightKG > 0, t.TransporterVolumeKG-t.TransporterWeightKG, 0) * t.VolumeKGAmount)  
  --    from tShipments t (updlock)
  --   where t.ShipmentsID = @ShipmentsID

  --  exec AuditInsert
  --       @AuditID      = @AuditID out
  --      ,@ObjectID     = @ShipmentsID
  --      ,@ObjectTypeID = 10
  --      ,@ActionID     = 2
  --      ,@Comment      = 'Изменение tShipments.TransporterWeightKG, TransporterVolumeKG '
  --      --  ,@UserID       = ''
  --      --  ,@HostInfoID   = ''
  --end

 exit_:
 return @r
go
grant exec on ShipmentsBoxesFill to public
go
exec setOV 'ShipmentsBoxesFill', 'P', '20250213', '0'
go
 