drop proc if exists ShipmentsEdit
/*
  ShipmentsEdit -
*/
go
create proc ShipmentsEdit
             @ShipmentsID        numeric(18, 0)

            ,@TransporterNumber       nvarchar(64) = null -- Наименование факт
            ,@ReceiptDate             datetime     = null 
            ,@SupplierWeightKG        money
	        ,@SupplierVolumeKG        money 
            ,@TransporterWeightKG     money
	        ,@TransporterVolumeKG     money 

            ,@DeliverySumF            money       = null 

as
  set nocount on;
  declare @r       int = 0
		 ,@AuditID  numeric(18,0)

  exec SetShipmentsTransporterNumber
         @ShipmentsID       = @ShipmentsID
        ,@TransporterNumber = @TransporterNumber

  exec SetShipmentsReceiptDate
         @ShipmentsID = @ShipmentsID
        ,@ReceiptDate = @ReceiptDate

  exec SetShipmentsTransporterData
             @ShipmentsID  = @ShipmentsID
            ,@Weight       = @TransporterWeightKG
            ,@Volume       = @TransporterVolumeKG


  exec SetShipmentsSupplierData
             @ShipmentsID       = @ShipmentsID
            ,@SupplierWeightKG  = @SupplierWeightKG
            ,@SupplierVolumeKG  = @SupplierVolumeKG

  update t
     set t.DeliverySumF        = @DeliverySumF
	from tShipments t (updlock)
   where t.ShipmentsID = @ShipmentsID



 -- update t
 --    set t.ReceiptDate2	   = @ReceiptDate
	--from tShipments t (updlock)
 --  where t.ShipmentsID  = @ShipmentsID
    
 --    and isnull(t.ReceiptDate, '') <> ''
     
 --    and isnull(t.ReceiptDate2, '') <> @ReceiptDate
  
 -- exec AuditInsert
 --        @AuditID      = @AuditID out
 --       ,@ObjectID     = @ShipmentsID
 --       ,@ObjectTypeID = 10
 --       ,@ActionID     = 2
 --       ,@Comment      = 'Изменение tShipments.TransporterNumber '
 --     --  ,@UserID       = ''
 --     --  ,@HostInfoID   = ''

 exit_:
 return @r
go
grant exec on ShipmentsEdit to public
go
exec setOV 'ShipmentsEdit', 'P', '20240101', '1'
go
 