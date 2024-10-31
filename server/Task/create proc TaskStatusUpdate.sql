drop proc if exists TaskProgress
/*
  TaskProgress - 
*/
go
create proc TaskProgress
               @TaskID           numeric(18,0) 
              ,@IsActive         bit
as
  declare @r       int = 0
		 --,@Type    int

  --BEGIN TRY 
      --delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      --Begin tran

	  update [tTask]
		 set Flag   = case 
                        when @IsActive = 1 then Flag|1
                        else Flag & ~ 1
                      end
	   where TaskID = @TaskID

		
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
grant exec on TaskProgress to public
go
exec setOV 'TaskProgress', 'P', '20241031', '0'
go
