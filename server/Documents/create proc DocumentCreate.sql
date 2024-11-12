DROP PROCEDURE IF EXISTS DocumentCreate
/*
  DocumentCreate - 

  Type                     int  
                              1 - дебит
                             -1 - кредит    
*/
go
create proc DocumentCreate
              @DocumentID        numeric(18, 0) output   -- 
             ,@ClientID          numeric(18, 0)   --      
             ,@Date              datetime
             ,@Amount            money
             ,@Comment           nvarchar(512)  -- Комментарий
             ,@Number            nvarchar(255) = null  --
             ,@Type              int 
             ,@PayType           int = null
as
  set nocount on

  declare @r               int = 0
         ,@UserID          numeric(18, 0)

  declare @ID table (DocumentID numeric(18,0));

  select @UserID     = isnull(nullif(@UserID, 0), dbo.getUserID())
  

  BEGIN TRY 
    delete tRetMessage from tRetMessage (rowlock) where spid=@@spid

    Begin tran

    insert into tDocuments
          (                 
           Number            
          ,Date              
          ,Amount            
          ,ClientID              
          ,Comment	
          ,Type
          ,Flag
          ,PayType
          )
    OUTPUT INSERTED.DocumentID INTO @ID
    select null	     
          ,@Date	 
          ,@Amount 
          ,@ClientID
          ,@Comment
          ,@Type
          ,1
          ,@PayType


    if not exists (Select 1
                     from tRest r (nolock)
                    where r.ClientID = @ClientID)
      insert tRest (ClientID, Amount) select @ClientID, 0.0

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

Select @DocumentID = DocumentID from @ID

exit_:
return @r
go
grant exec on DocumentCreate to public
go
exec setOV 'DocumentCreate', 'P', '20241112', '3'
go