drop proc if exists SetShipmentsTransporterNumber
/*
  SetShipmentsTransporterNumber -
*/
go
create proc SetShipmentsTransporterNumber
             @ShipmentsID        numeric(18, 0)
            ,@TransporterNumber  nvarchar(64) = null -- Наименование факт            
as
  set nocount on;
  declare @r       int = 0
		 ,@AuditID  numeric(18,0)

  update t
     set t.TransporterNumber	   = nullif(@TransporterNumber, '')
	from tShipments t (updlock)
   where t.ShipmentsID = @ShipmentsID
  
  exec AuditInsert
         @AuditID      = @AuditID out
        ,@ObjectID     = @ShipmentsID
        ,@ObjectTypeID = 10
        ,@ActionID     = 2
        ,@Comment      = 'Изменение tShipments.TransporterNumber '
      --  ,@UserID       = ''
      --  ,@HostInfoID   = ''

 exit_:
 return @r
go
grant exec on SetShipmentsTransporterNumber to public
go
exec setOV 'SetShipmentsTransporterNumber', 'P', '20240101', '0'
go
 