if OBJECT_ID('BasketClear', 'P') is not null
    drop proc BasketClear	 
go
/* --------------------------------------------------------
  BasketClear - очистка корзины
-------------------------------------------------------- */
create proc BasketClear
              @ClientID	numeric(18, 0)
as
set nocount on;

declare @RetVal             int

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran
		
		--if @RetVal <> 0
		--begin 
		--  RAISERROR (15600, 16, 1, @RetVal);
		--end

		Delete tBasket
		  from tBasket with (rowlock index=ao2)
		 where ClientID  = @ClientID

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
grant all on BasketClear to public
go
exec setOV 'BasketClear', 'P', '20250530', '0'
go
