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

  update t
     set t.ReceiptDate2	   = @ReceiptDate
	from tShipments t (updlock)
   where t.ShipmentsID  = @ShipmentsID
    
     and isnull(t.ReceiptDate, '') <> ''
     
     and isnull(t.ReceiptDate2, '') <> @ReceiptDate

  if @@ROWCOUNT > 0
  begin
  
   -- update s
   --    set s.ReceiptDate2	   = @ReceiptDate
	  --from tShipments t (nolock)
   --  inner join tOrders s (updlock)
   --          on s.Invoice = t.Invoice
   --  where t.ShipmentsID  = @ShipmentsID

    exec AuditInsert
         @AuditID      = @AuditID out
        ,@ObjectID     = @ShipmentsID
        ,@ObjectTypeID = 10
        ,@ActionID     = 2
        ,@Comment      = 'Изменение tShipments.ReceiptDate '
        --  ,@UserID       = ''
        --  ,@HostInfoID   = ''
  end

 exit_:
 return @r
go
grant exec on SetShipmentsReceiptDate to public
go
exec setOV 'SetShipmentsReceiptDate', 'P', '20240101', '0'
go
 