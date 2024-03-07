drop proc if exists TaskUpdate
/*
  TaskUpdate - 
*/
go
create proc TaskUpdate
               @TaskID           numeric(18,0) 
              ,@Brief            nvarchar(60)   --
              ,@Name	         nvarchar(128)   -- 
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

	  update [tTask]
		 set [Brief]	   = @Brief
			,[Name]		   = @Name
			,[PeriodType]  = @PeriodType
			,[DateBegin]   = @DateBegin
			,[IsActive]	   = @IsActive
			,[updDatetime] = getDate()
			,TimeBegin 	   = @TimeBegin        
			,TimeEnd       = @TimeEnd          
			,DayPeriod     = @DayPeriod        
			,TimePeriod    = @TimePeriod    
			,Flag          = @Flag
	   where TaskID = @TaskID

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
grant exec on TaskUpdate to public
go
exec setOV 'TaskUpdate', 'P', '20240101', '1.0.0.0'
go
