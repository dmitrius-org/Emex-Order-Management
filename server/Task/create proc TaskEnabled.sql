drop proc if exists TaskEnabled
/*
  TaskEnabled - 
*/
go
create proc TaskEnabled
               @TaskID           numeric(18,0) 
              ,@IsActive         bit
as
  declare @r       int = 0
		 ,@Type    int

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran

	  update [tTask]
		 set [IsActive]	   = @IsActive
			,[updDatetime] = getDate()
	   where TaskID = @TaskID
		
		--if @r <> 0
		--begin 
		--  RAISERROR (15600, 16, 1, @r);
		--end

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
grant exec on TaskEnabled to public
go
exec setOV 'TaskEnabled', 'P', '20250217', '0'
go
