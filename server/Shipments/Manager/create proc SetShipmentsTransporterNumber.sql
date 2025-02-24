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


  if ISNUMERIC(@TransporterNumber) = 1
  begin
    select @TransporterNumber = s.SupplierBrief + ltrim(rtrim(@TransporterNumber)) + sd.Brief
      from vShipments s (nolock)
     inner join tSupplierDeliveryProfiles as sd (nolock)
             on sd.SuppliersID     = s.SuppliersID
            and sd.DestinationLogo = s.DestinationLogo
     where s.ShipmentsID = @ShipmentsID
  end

  update t
     set t.TransporterNumber	   = nullif(rtrim(ltrim(@TransporterNumber)), '')
	from tShipments t (updlock)
   where t.ShipmentsID = @ShipmentsID
  
  exec AuditInsert
         @AuditID      = @AuditID out
        ,@ObjectID     = @ShipmentsID
        ,@ObjectTypeID = 10
        ,@ActionID     = 2
        ,@Comment      = 'Изменение tShipments.TransporterNumber '

 exit_:
 return @r
go
grant exec on SetShipmentsTransporterNumber to public
go
exec setOV 'SetShipmentsTransporterNumber', 'P', '20240101', '1'
go
 