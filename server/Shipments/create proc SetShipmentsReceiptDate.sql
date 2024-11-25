drop proc if exists SetShipmentsReceiptDate
/*
  SetShipmentsReceiptDate -
*/
go
create proc SetShipmentsReceiptDate
             @ShipmentsID  numeric(18, 0)
            ,@ReceiptDate  datetime     
as
  set nocount on;

  declare @r        int = 0
		 ,@AuditID  numeric(18,0)
         ,@Comment  nvarchar(256)

  if not exists (select 1 
                   from tShipments t (nolock)
                  where t.ShipmentsID = @ShipmentsID 
                    and isnull(t.ReceiptDate, '') <> '')
  begin
      set @Comment = 'Изменение tShipments.ReceiptDate '
      update t
         set t.ReceiptDate = @ReceiptDate
	    from tShipments t (updlock)
       where t.ShipmentsID = @ShipmentsID        
  end
  else 
  begin
      set @Comment = 'Изменение tShipments.ReceiptDate2 '
      update t
         set t.ReceiptDate2 = case 
                                when t.ReceiptDate = @ReceiptDate then null
                                else @ReceiptDate
                              end
	    from tShipments t (updlock)
       where t.ShipmentsID = @ShipmentsID         
  end

  if @@ROWCOUNT > 0
  begin
    exec AuditInsert
         @AuditID      = @AuditID out
        ,@ObjectID     = @ShipmentsID
        ,@ObjectTypeID = 10
        ,@ActionID     = 2
        ,@Comment      = @Comment
  end

 exit_:
 return @r
go
grant exec on SetShipmentsReceiptDate to public
go
exec setOV 'SetShipmentsReceiptDate', 'P', '20241125', '2'
go
 