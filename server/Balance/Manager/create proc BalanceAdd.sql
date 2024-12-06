DROP PROCEDURE IF EXISTS BalanceAdd
/*
  BalanceAdd - 
*/
go
create proc BalanceAdd
              @ClientID numeric(18, 0)
             ,@Date     datetime
             ,@Amount   money
             ,@Comment  nvarchar(512) -- Комментарий
             ,@Number   nvarchar(255) = null
             ,@PayType  int
as
  set nocount on;

  declare @r          int = 0
         ,@UserID     numeric(18, 0)
         ,@DocumentID numeric(18, 0)

  select @UserID = isnull(nullif(@UserID, 0), dbo.getUserID())

  BEGIN TRY 
    delete tRetMessage from tRetMessage (rowlock) where spid=@@spid

    exec @r = DocumentCreate
                @DocumentID = @DocumentID out
               ,@ClientID   = @ClientID
               ,@Date       = @Date
               ,@Amount     = @Amount
               ,@Comment    = @Comment
               ,@Number     = @Number
               ,@Type       = 1
               ,@PayType    = @PayType

  END TRY
  BEGIN CATCH
    set @r = -1
    insert tRetMessage(RetCode, Message) select @r,  ERROR_MESSAGE()

    goto exit_
  END CATCH

exit_:
return @r
go
grant exec on BalanceAdd to public
go
exec setOV 'BalanceAdd', 'P', '20240917', '2'
go
