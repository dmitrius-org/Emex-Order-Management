drop proc if exists TaskWriteErrorMessage
/*
  askWriteErrorMessage - 
*/
go
create proc TaskWriteErrorMessage
               @TaskID           numeric(18,0) 
              ,@Message          nvarchar(Max)   
          
as
  declare @r       int = 0
		

  --BEGIN TRY 
  --    delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
  --    Begin tran

        Update tTask              
           set Message      = SUBSTRING(@Message, 1, 2000)
              ,updDatetime  = getDate() 
              --,IsActive     = 0 
          where TaskID    = @TaskID
		
		--if @r <> 0
		--begin 
		--  RAISERROR (15600, 16, 1, @r);
		--end

  --    commit tran
  --END TRY  
  --BEGIN CATCH  
  --    if @@TRANCOUNT > 0
  --      rollback tran
    
  --    set @r = -1
  --    insert tRetMessage(RetCode, Message) select @r,  ERROR_MESSAGE()  

  --    goto exit_     
  --END CATCH  

      
  exit_:
 return @r
go
grant exec on TaskWriteErrorMessage to public
go
exec setOV 'TaskWriteErrorMessage', 'P', '20240311', '1.0.0.1'
go
