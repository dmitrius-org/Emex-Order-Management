if OBJECT_ID('BasketDeleteByID', 'P') is not null
    drop proc BasketDeleteByID	 
go
/* --------------------------------------------------------
  BasketDeleteByID - удаление позиции из корзины
-------------------------------------------------------- */
create proc BasketDeleteByID
              @BasketID	numeric(18, 0)
as
set nocount on;

declare @RetVal             int
       --,@Comment   nvarchar(1024)
       --,@AuditID   numeric(18, 0)

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran

        --select @Comment = 'Удаление детали: ClientID= ' + convert(varchar, ClientID) + ', Make=' + Make + ', MakeName=' + MakeName + ', DetailNum=' + DetailNum
        --  from tBasket (nolock)
        -- where BasketID=@BasketID

        ---- аудит
        --exec AuditInsert
        --         @AuditID        = @AuditID out
        --        ,@ObjectID       = @BasketID
        --        ,@ObjectTypeID   = 6	-- Корзина
        --        ,@ActionID       = 3	-- acDelete
        --        ,@Comment        = @Comment

        Delete tBasket
		  from tBasket with (rowlock index=ao2)
		 where BasketID  = @BasketID

      commit tran
  END TRY  
  BEGIN CATCH  
      if @@TRANCOUNT > 0
        rollback tran
    
      set @RetVal = -1
      insert tRetMessage(RetCode, Message) select @RetVal,  ERROR_MESSAGE()  

      goto exit_     
  END CATCH  

exit_:

return @RetVal 

go
grant all on BasketDeleteByID to public
go
exec setOV 'BasketDeleteByID', 'P', '20250530', '0'
go
