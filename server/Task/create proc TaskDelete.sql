drop proc if exists TaskDelete
/*
  TaskDelete - 
*/
go
create proc TaskDelete
              @TaskID           numeric(18,0) 
as
  declare @r int = 0

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran
 
        delete tTaskActions from tTaskActions (rowlock) where TaskID=@TaskID 
        delete tTask from tTask (rowlock) where TaskID=@TaskID 
		
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
grant exec on TaskDelete to public
go
exec setOV 'TaskDelete', 'P', '20240101', '1.0.0.0'
go
