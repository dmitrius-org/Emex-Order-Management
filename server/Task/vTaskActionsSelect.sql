if OBJECT_ID('vTaskActionsSelect') is not null
    drop view vTaskActionsSelect
go
/* **********************************************************						
vTaskActionsSelect - список задач
********************************************************** */
create view vTaskActionsSelect
as

select t.TaskID
      ,t.TaskActionsID
	  ,t.Number
      ,t.Comment
	  ,t.TaskType
      ,case
	     when t.TaskType=0 then p.Brief
         when t.TaskType=1 then t.Field
         when t.TaskType=2 then t.Field
		 else ''
	   end Method
      ,t.Flag       
  from tTaskActions t (nolock)
  left join tProperty p (nolock)
         on p.PropertyID = t.LinkID
 where t.isActive = 1

go
grant all on vTaskActionsSelect to public
go
exec setOV 'vTaskActionsSelect', 'V', '20240307', '1'
go