drop proc if exists TaskDateExecCalc
/*
  TaskDateExecCalc - перерасчет даты следующего запуска задания
*/
go
create proc TaskDateExecCalc
               @TaskID           numeric(18,0) 
			  ,@Message          nvarchar(255)
as
  declare @r       int = 0
		 ,@Type    int

  update [tTask]
     set DateExec	   = case
	                       When PeriodType = 0 then '20700101'                                         --Только один раз
						   When PeriodType = 1 then  dateadd(ss, DATEPART(ss, TimePeriod),             --выбрать, период
						                               dateadd(mi, DATEPART(mi, TimePeriod),
						                                 dateadd(hh, DATEPART(HH, TimePeriod),
						                                                dateadd(d, DayPeriod, isnull(DateExec,  getdate()) )
													     ) 
													   )
												     )
															--Выбрать
						   When PeriodType = 2 then dateadd(d, 1,     ( cast( cast(getdate() as date) as datetime ) + cast( cast(DateBegin as time) as datetime ) )) --Ежедневно
						   When PeriodType = 3 then dateadd(week, 1,  ( cast( cast(getdate() as date) as datetime ) + cast( cast(DateBegin as time) as datetime ) )) --Еженедельно
						   When PeriodType = 4 then dateadd(month, 1, ( cast( cast(getdate() as date) as datetime ) + cast( cast(DateBegin as time) as datetime ) )) --Ежемесячно
						   When PeriodType = 5 then dateadd(year, 1,  ( cast( cast(getdate() as date) as datetime ) + cast( cast(DateBegin as time) as datetime ) )) --Ежегодно

						   else '20700101'
	                     end
        ,Message = @Message
   where TaskID = @TaskID


 exit_:
 return @r
go
grant exec on TaskDateExecCalc to public
go


--select DATEPART ( dd , null )  