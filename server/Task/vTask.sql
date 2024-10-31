if OBJECT_ID('vTask') is not null
    drop view vTask
go
/* **********************************************************						
vTask - 
********************************************************** */
create view vTask
as

SELECT [TaskID]
      ,[Brief]
      ,[Name]
      ,[DateBegin]
	  ,[DateExec]
      ,[IsActive]
	  ,[Message]
      ,[inDatetime]
      ,[updDatetime]
      ,[Flag]
  FROM [tTask] (nolock)

go
grant select on vTask to public
go
exec setOV 'vTask', 'V', '20241031', '2'
go
 

select * from vTask
