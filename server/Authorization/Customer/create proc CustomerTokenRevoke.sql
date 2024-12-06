if OBJECT_ID('CustomerTokenRevoke') is not null
    drop proc ClientTokenRevoke
/*
  CustomerTokenRevoke - 
*/
go
create proc CustomerTokenRevoke
              @Token NVARCHAR(512)  
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

        UPDATE system.tCustomerTokens 
           SET Status     = 0 
              ,Expiration = SYSDATETIME() 
         WHERE Token = @Token

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
grant exec on CustomerTokenRevoke to public
go
exec setOV 'CustomerTokenRevoke', 'P', '20240618', '1'
go