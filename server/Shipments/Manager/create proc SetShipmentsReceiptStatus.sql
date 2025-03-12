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

  delete pShipmentsProtocol from pShipmentsProtocol with (rowlock index=ao2) where spid = @@Spid

  delete pAccrualAction from pAccrualAction with (rowlock index=ao2) where spid = @@Spid

  delete tRetMessage from tRetMessage with (rowlock index=ao1) where spid=@@spid

  BEGIN TRY       
 
      Begin tran 

          update t
              set t.ReceiptDate2 = @ReceiptDate
	         from tShipments t with (updlock index=ao1)
            where t.ShipmentsID  = @ShipmentsID

          insert pShipmentsProtocol with (rowlock)
                 (Spid, ShipmentsID, StateID, NewStateID, ActionID, OperDate, Message, ord)
           select @@Spid, 
                  s.ShipmentsID,
                  s.StatusID, 
                  24,  -- Received    Готовим к выдаче клиенту в РФ
                  25,  -- ToReceived  Получено
                  @ReceiptDate,
                  'Получено',
                  0
             from tShipments s (nolock)
            where s.ShipmentsID  = @ShipmentsID
              and isnull(s.StatusID, 0) <> 24 --	Received	Готовим к выдаче в РФ   
          
          --insert pAccrualAction with (rowlock) 
          --      (Spid, ObjectID,  StateID, NewStateID, ActionID, OperDate, Message,  ord)
          --select @@Spid, 
          --       o.OrderID, 
          --       o.StatusID, 
          --       24, --	Received	Готовим к выдаче клиенту в РФ
          --       25, --	ToReceived	Получено
          --       @ReceiptDate,
          --       'Автоматический перевод в Получено из Отгрузки',
          --       0
          --  from tShipments t (nolock)
          -- inner join tOrders o (nolock)
          --         on o.Invoice = t.Invoice
          -- where t.ShipmentsID  = @ShipmentsID
          

          exec ShipmentsProtocolAdd

          --exec ProtocolAdd


        --exec AuditInsert
        --     @AuditID      = @AuditID out
        --    ,@ObjectID     = @ShipmentsID
        --    ,@ObjectTypeID = 10
        --    ,@ActionID     = 2
        --    ,@Comment      = 'Изменение tShipments.ReceiptDate ReceiptStatus'
            --  ,@UserID       = ''
            --  ,@HostInfoID   = ''
		
		if @r <> 0
		begin 
		  RAISERROR (15600, 16, 1, @r);
		end

      commit tran
  END TRY  
  BEGIN CATCH  
      if @@TRANCOUNT > 0
        rollback tran
    
      set @r = -1
      insert tRetMessage(RetCode, Message) select @r,  ERROR_MESSAGE()  

      goto exit_     
  END CATCH 
  

 exit_:
 return @r
go
grant exec on SetShipmentsReceiptStatus to public
go
exec setOV 'SetShipmentsReceiptStatus', 'P', '20250311', '4'
go
 