drop proc if exists TaskActionUpdate
/*
  TaskActionUpdate - 
*/
go
create proc TaskActionUpdate
               @ID               numeric(18,0)   
              ,@Number           int                 
              ,@Comment          nvarchar(255)  
              ,@LinkID           numeric(18,0)  = null
			  ,@Field            nvarchar(max)  = null
              ,@IsActive         int            
as
  declare @r       int = 0
		 ,@Type    int

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran

	  update pTaskActions
		 set Number	  = @Number
			,Comment  = @Comment
			,LinkID   = @LinkID
			,IsActive = @IsActive
			,Field    = @Field
			--,[updDatetime] = getDate()
	   where ID = @ID
		
	  if @r <> 0
	  begin 
		RAISERROR (15600, 16, 1, @r);
	  end

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
grant exec on TaskActionUpdate to public
go
exec setOV 'TaskActionUpdate', 'P', '20240307', '1'
go
