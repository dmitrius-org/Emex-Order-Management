drop proc if exists TaskActionAdd
/*
  TaskActionAdd - 
*/
go
create proc TaskActionAdd
               @ID               numeric(18,0)  out 
              ,@TaskID           nvarchar(60)   null    --
              ,@Number           int            null    -- 
              ,@Comment          nvarchar(255)  null
              ,@TaskType         int
              ,@LinkID           numeric(18,0)  null
              ,@IsActive         int            null
as
  declare @r       int = 0

  DECLARE @_ID TABLE (ID numeric(18,0));

  INSERT INTO pTaskActions
        ( TaskActionsID   
		 ,TaskID          
		 ,Number          
		 ,Comment         
		 ,TaskType        
		 ,LinkID          
		 ,IsActive        

		)
  OUTPUT INSERTED.ID  INTO @_ID
  select  null   
		 ,@TaskID          
		 ,@Number          
		 ,@Comment         
		 ,@TaskType        
		 ,@LinkID          
		 ,@IsActive        

  Select @ID = ID from @_ID

 exit_:
 return @r
go
grant exec on TaskActionAdd to public
go
exec setOV 'TaskActionAdd', 'P', '20240307', '1.0.0.1'
go

