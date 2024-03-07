if OBJECT_ID('vTaskActions') is not null
    drop view vTaskActions
go
/* **********************************************************						
vTaskActions - 
********************************************************** */
create view vTaskActions
as

SELECT [TaskID]
      ,[TaskActionsID]
      ,[Comment]
      ,[TaskType]
      ,case
	     when TaskType=0 then '���������'
         when TaskType=1 then 'Bat ���� (*.bat)'
         when TaskType=2 then 'Sql ������'
		 else ''
	   end [TaskTypeName]
      ,[IsActive]          
      ,[LinkID]        
      ,[Field]         
      ,[Flag]          
      ,[inDatetime]    
      ,[updDatetime]   
  FROM pTaskActions (nolock)
 where spid = @@spid
 
go
grant select on vTaskActions to public
go
exec setOV 'vTaskActions', 'V', '20240101', '1.0.0.0'
go
 


