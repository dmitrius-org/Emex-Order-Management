drop proc if exists SetShipmentsTransporterData
/*
  SetShipmentsTransporterData -
*/
go
create proc SetShipmentsTransporterData
             @ShipmentsID  numeric(18, 0)
            ,@Weight       float 
            ,@Volume       float 
as
  set nocount on;

  declare @r        int = 0
		 ,@AuditID  numeric(18,0)

  update t
     set t.TransporterWeightKG = @Weight
        ,t.TransporterVolumeKG = @Volume
        ,t.TransporterDiffVolumeWeigh = @Volume-@Weight
	from tShipments t (updlock)
   where t.ShipmentsID  = @ShipmentsID

  if @@ROWCOUNT > 0
  begin
    Update t
       set t.TransporterAmount  = t.TransporterWeightKG * t.WeightKGAmount + (iif(t.TransporterVolumeKG - t.TransporterWeightKG > 0, t.TransporterVolumeKG-t.TransporterWeightKG, 0) * t.VolumeKGAmount)  
      from tShipments t (updlock)
     where t.ShipmentsID = @ShipmentsID

    exec AuditInsert
         @AuditID      = @AuditID out
        ,@ObjectID     = @ShipmentsID
        ,@ObjectTypeID = 10
        ,@ActionID     = 2
        ,@Comment      = 'Изменение tShipments.TransporterWeightKG, TransporterVolumeKG '
        --  ,@UserID       = ''
        --  ,@HostInfoID   = ''
  end

 exit_:
 return @r
go
grant exec on SetShipmentsTransporterData to public
go
exec setOV 'SetShipmentsTransporterData', 'P', '20240101', '2'
go
 