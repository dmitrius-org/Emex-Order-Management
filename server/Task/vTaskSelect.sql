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
      ,t.TaskType
      ,t.PeriodType
	  ,t.DateBegin
	  ,t.DateExec
      ,t.Message
      ,case
	     when t.TaskType=0 then p.Brief
         when t.TaskType=1 then t.Field
         when t.TaskType=2 then t.Field
		 else ''
	   end Method
      ,Flag       
  from tTask t (nolock)
  left join tProperty p (nolock)
         on p.PropertyID = t.LinkID
 where t.isActive = 1
   and isnull(t.DateExec, '19000101') <= getDate()

   and ( (t.PeriodType=1 and convert(time, getDate(), 108) between t.TimeBegin and TimeEnd)
      or (t.PeriodType<>1) )

go
grant all on vTaskSelect to public
go
exec setOV 'vTaskSelect', 'V', '20240101', '1.0.0.0'
go

