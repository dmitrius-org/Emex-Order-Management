IF (SELECT COUNT(*) FROM sys.services WHERE NAME = 'TaskManager') <> 0 
  drop SERVICE [TaskManager];

IF OBJECT_ID('TaskManager') IS not NULL 
  drop QUEUE [TaskManager];

CREATE SERVICE [TaskManager] ON QUEUE [TaskManager]     ([http://schemas.microsoft.com/SQL/Notifications/PostQueryNotification]);   
