drop proc if exists TaskActionAdd
/*
  TaskActionAdd - 
*/
go
create proc TaskActionAdd
               @ID               numeric(18,0)  out 
              ,@TaskID           numeric(18,0)  = null
              ,@Number           int 
              ,@Comment          nvarchar(255)  
              ,@TaskType         int
              ,@LinkID           numeric(18,0)  = null
			  ,@Field            nvarchar(max)  = null
              ,@IsActive         int            
as
  declare @r int = 0

  DECLARE @_ID TABLE (ID numeric(18,0));

  INSERT INTO pTaskActions
        ( Spid
		 ,TaskActionsID   
		 ,TaskID          
		 ,Number          
		 ,Comment         
		 ,TaskType        
		 ,LinkID          
		 ,IsActive        
		 ,Field
		)
  OUTPUT INSERTED.ID  INTO @_ID
  select  @@SPID
         ,null   
		 ,@TaskID          
		 ,@Number          
		 ,@Comment         
		 ,@TaskType        
		 ,@LinkID          
		 ,@IsActive 
		 ,@Field

  Select @ID = ID from @_ID

 exit_:
 return @r
go
grant exec on TaskActionAdd to public
go
exec setOV 'TaskActionAdd', 'P', '20240307', '1'
go

