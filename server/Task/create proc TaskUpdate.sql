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

 exit_:
 return @r
go
grant exec on TaskUpdate to public
go
exec setOV 'TaskUpdate', 'P', '20240101', '1.0.0.0'
go
