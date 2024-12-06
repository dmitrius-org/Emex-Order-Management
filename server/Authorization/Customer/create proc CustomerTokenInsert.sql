if OBJECT_ID('CustomerTokenInsert') is not null
    drop proc CustomerTokenInsert
/*
  CustomerTokenInsert - 
*/
go
create proc CustomerTokenInsert
             @ClientID	  numeric(18, 0)
            ,@Token       nvarchar(512)  
            ,@Expiration  datetime2

as
  declare @r int = 0

  --if exists (select 1 
  --             from  (nolock)
  --            where )
  --begin
  --  set @r = 0
  --  goto exit_
  --end

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran

        INSERT INTO system.tCustomerTokens 
               (ClientID, Token, Expiration, Status)
        VALUES (@ClientID, @Token, @Expiration, 1)

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
grant exec on CustomerTokenInsert to public
go
exec setOV 'CustomerTokenInsert', 'P', '20241205', '1'
go