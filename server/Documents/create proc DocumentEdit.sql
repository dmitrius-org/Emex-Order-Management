DROP PROCEDURE IF EXISTS DocumentEdit
/*
  DocumentEdit - 

  Type    int  
             1 - дебит
            -1 - кредит    
*/
go
create proc DocumentEdit
              @DocumentID        numeric(18, 0) output   -- 
             ,@ClientID          numeric(18, 0)          --      
             ,@Date              datetime
             ,@Amount            money
             ,@Comment           nvarchar(512)           -- Комментарий
             ,@Number            nvarchar(255) = null    --
            -- ,@Type              int = null
             ,@PayType           int = null
as
  set nocount on

  declare @r               int = 0
         ,@UserID          numeric(18, 0) 

  BEGIN TRY 
    delete tRetMessage from tRetMessage (rowlock) where spid=@@spid

    Begin tran
    
    update tDocuments
       set                
           Number   = @Number             
          ,Date     = @Date               
          ,Amount   = @Amount             
         --- ,ClientID = @ClientID               
          ,Comment	= @Comment	 
         -- ,Type     = @Type      
          --,Flag     = @Flag      
          ,PayType  = @PayType 
      from tDocuments with (updlock index=PK_tDocuments_DocumentID)    
     where DocumentID = @DocumentID

    exec RestCalc  @ClientID  = @ClientID

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
grant exec on DocumentEdit to public
go
exec setOV 'DocumentEdit', 'P', '20241112', '3'
go