if OBJECT_ID('ShipmentsUpdate') is not null
    drop proc ShipmentsUpdate
/*
  ShipmentsUpdate - 
*/
go

Create proc ShipmentsUpdate  
              @SupplierWeightKG    money
             ,@SupplierVolumeKG    money
             ,@TransporterWeightKG money
             ,@TransporterVolumeKG money 
             ,@ShipmentsID         numeric(18, 0)
as
  set nocount on;
  declare @r int = 0

UPDATE tShipments
   SET SupplierWeightKG       = @SupplierWeightKG, 
       SupplierVolumeKG       = @SupplierVolumeKG , 
       
       SupplierDiffVolumeWeigh= @SupplierVolumeKG - @SupplierWeightKG, 
       
       TransporterWeightKG = @TransporterWeightKG, 
       TransporterVolumeKG = @TransporterVolumeKG,

       TransporterDiffVolumeWeigh = @TransporterVolumeKG- @TransporterWeightKG
 WHERE ShipmentsID = @ShipmentsID



  Update t
     set t.SupplierAmount     = t.SupplierWeightKG * t.WeightKGAmount + (iif(t.SupplierVolumeKG > t.SupplierWeightKG, (t.SupplierVolumeKG-t.SupplierWeightKG) * t.VolumeKGAmount, 0))  
        ,t.TransporterAmount  = t.TransporterVolumeKG * t.WeightKGAmount + (iif(t.TransporterVolumeKG > t.TransporterWeightKG, (t.TransporterVolumeKG-t.TransporterWeightKG) * t.VolumeKGAmount, 0))  
     
    from tShipments t (updlock)
   --inner join tShipments t (updlock)
   --        on t.Invoice = p.Invoice
   where t.ShipmentsID = @ShipmentsID

exit_:

return @r
GO
grant exec on ShipmentsUpdate to public
go