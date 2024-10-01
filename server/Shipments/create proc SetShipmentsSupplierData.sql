if OBJECT_ID('SetShipmentsSupplierData') is not null
    drop proc SetShipmentsSupplierData
/*
  SetShipmentsSupplierData - 

*/
go

Create proc SetShipmentsSupplierData  
              @SupplierWeightKG    money
             ,@SupplierVolumeKG    money
             ,@ShipmentsID         numeric(18, 0)
as
  set nocount on;
  declare @r int = 0

  update t
     set t.SupplierWeightKG    = @SupplierWeightKG
        ,t.SupplierVolumeKG    = @SupplierVolumeKG
        ,t.SupplierDiffVolumeWeigh= @SupplierVolumeKG - @SupplierWeightKG 
	from tShipments t (updlock)
   where t.ShipmentsID = @ShipmentsID

   Update t
      set t.SupplierAmount  = t.SupplierWeightKG * t.WeightKGAmount + (iif(t.SupplierVolumeKG - t.SupplierWeightKG > 0, t.SupplierVolumeKG-t.SupplierWeightKG, 0) * t.VolumeKGAmount)  
     from tShipments t (updlock)
    where t.ShipmentsID = @ShipmentsID


exit_:

return @r
GO
grant exec on SetShipmentsSupplierData to public
go
exec setOV 'SetShipmentsSupplierData', 'P', '20240927', '2'
go