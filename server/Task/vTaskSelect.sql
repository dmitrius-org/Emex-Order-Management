if OBJECT_ID('vTaskSelect') is not null
    drop view vTaskSelect
go
/* **********************************************************						
vTaskSelect - список задач
********************************************************** */
create view vTaskSelect
as

select t.TaskID
      ,t.Brief      as TaskBrief
      ,t.PeriodType
	  ,t.DateBegin
	  ,t.DateExec
      ,t.Message
      ,t.Flag       
  from tTask t (nolock)
 where t.isActive = 1
   and isnull(t.DateExec, t.DateBegin /*case 
                            when t.DateBegin < getDate() then cast( cast(getdate() as date) as datetime ) + cast( cast(t.DateBegin as time) as datetime )
							else t.DateBegin
						  end*/
			  ) <= getDate()

   and ( (t.PeriodType=1 and convert(time, getDate(), 108) between t.TimeBegin and TimeEnd)
      or (t.PeriodType<>1) )

go
grant all on vTaskSelect to public;
go
exec setOV 'vTaskSelect', 'V', '20240311', '0';
go