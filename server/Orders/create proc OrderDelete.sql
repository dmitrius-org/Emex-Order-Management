if OBJECT_ID('OrderDelete') is not null
    drop proc OrderDelete
/*
  OrderDelete - удаление заказа
*/
go
create proc OrderDelete
              @OrderID numeric(18,0)  --  
as
  declare @r int = 0
  declare @Archiving ID
  --DECLARE @ID TABLE (ID numeric(18,0));

  --if exists (select 1 
  --             from tOrders o (nolock)
  --            where o.OrderID  = @OrderID
  --           )
  --begin
  --  set @r = 0-- 'Удаление запрещено,
  --  goto exit_
  --end 

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran
        
        insert @Archiving (ID)
        select @OrderID

        exec OrderArchiving
               @OrderID = @Archiving
		
		if @r <> 0
		begin 
		  RAISERROR (15600, 16, 1, @r);
		end

		Delete tOrders
		  from tOrders with (rowlock index=ao1)
		 where OrderID  = @OrderID

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
grant exec on OrderDelete to public
go
exec setOV 'OrderDelete', 'P', '20250514', '0'
go

 