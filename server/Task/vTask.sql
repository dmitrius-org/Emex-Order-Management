if OBJECT_ID('vTask') is not null
    drop view vTask
go
/* **********************************************************						
vTask - 
********************************************************** */

create view vTask

as

--SET DATEFIRST 1;
SELECT [TaskID]
      ,[Brief]
      ,[Name]
      ,[TaskType]
      ,[DateBegin]
	  ,[DateExec]
      ,[IsActive]
	  ,[Message]
      ,[inDatetime]
      ,[updDatetime]
  FROM [tTask] (nolock)
go
grant select on vTask to public
go
select * from vTask


