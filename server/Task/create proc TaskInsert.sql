drop proc if exists TaskInsert
/*
  TaskInsert - 
*/
go
create proc TaskInsert
               @TaskID           numeric(18,0)  out 
              ,@Brief            nvarchar(60)       --
              ,@Name	         nvarchar(128) null  -- 
              ,@PeriodType       int
              ,@DateBegin        datetime
              ,@IsActive         int
			  ,@TimeBegin        Time
              ,@TimeEnd          Time
              ,@DayPeriod        int
              ,@TimePeriod       Time
              ,@Flag             int
as
  declare @r       int = 0
		 ,@Type    int




  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran

	  DECLARE @ID TABLE (ID numeric(18,0));

	  INSERT INTO [tTask]
			([Brief]
			,[Name]
			,[PeriodType]
			,[DateBegin]
			,[IsActive]
			,[inDatetime]
			,[updDatetime]
			,TimeBegin        
			,TimeEnd          
			,DayPeriod        
			,TimePeriod    
			,Flag
			)
	  OUTPUT INSERTED.TaskID  INTO @ID
	  select @Brief       
			,@Name	      
			,@PeriodType     
			,@DateBegin   
			,@IsActive  
			,getDate() 
			,getDate() 
			,@TimeBegin        
			,@TimeEnd          
			,@DayPeriod        
			,@TimePeriod  
			,@Flag

	  Select @TaskID = ID from @ID

	  exec @r= TaskActionLoad     
                 @TaskID    = @TaskID
                ,@Direction = 1
		
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
grant exec on TaskInsert to public
go
exec setOV 'TaskInsert', 'P', '20240101', '0'
go

