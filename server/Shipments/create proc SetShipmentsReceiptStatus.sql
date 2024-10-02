drop proc if exists SetShipmentsReceiptStatus
/*
  SetShipmentsReceiptStatus -
*/
go
create proc SetShipmentsReceiptStatus
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
    
   --  and isnull(t.ReceiptDate, '') <> ''
     
     --and isnull(t.ReceiptDate2, '') <> @ReceiptDate

  if @@ROWCOUNT > 0
  begin
  
    
    delete pAccrualAction from pAccrualAction (rowlock) where spid = @@Spid
    insert pAccrualAction 
          (Spid,   ObjectID,  StateID, NewStateID, ActionID, OperDate, Message,  ord)
    select @@Spid, 
           o.OrderID, 
           o.StatusID, 
           24, --	Received	Готовим к выдаче клиенту в РФ
           25, --	ToReceived	Получено
           @ReceiptDate,
           'Автоматический перевод в Получено из Отгрузки',
           0
      from tShipments t (nolock)
     inner join tOrders o (nolock)
             on o.Invoice = t.Invoice
     where t.ShipmentsID  = @ShipmentsID

    exec ProtocolAdd


    exec AuditInsert
         @AuditID      = @AuditID out
        ,@ObjectID     = @ShipmentsID
        ,@ObjectTypeID = 10
        ,@ActionID     = 2
        ,@Comment      = 'Изменение tShipments.ReceiptDate ReceiptStatus'
        --  ,@UserID       = ''
        --  ,@HostInfoID   = ''
  end

 exit_:
 return @r
go
grant exec on SetShipmentsReceiptStatus to public
go
exec setOV 'SetShipmentsReceiptStatus', 'P', '20240101', '2'
go
 