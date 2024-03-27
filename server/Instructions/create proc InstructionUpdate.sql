drop proc if exists InstructionUpdate
/*
  InstructionUpdate - 
*/
go
create proc InstructionUpdate
              @InstructionID    numeric(18,0) 
             ,@ParentID          numeric(18,0) = null
             ,@Name              nvarchar(256)
             ,@Comment           nvarchar(512)= null  
as
  declare @r       int = 0

  Update tInstructions
     set ParentID= isnull(@ParentID, ParentID)	
        ,Name    = @Name
	    ,Comment = @Comment        
   where InstructionID = @InstructionID

 exit_:
 return @r
go
grant exec on InstructionUpdate to public
go
exec setOV 'InstructionUpdate', 'P', '20240325', '0'
go
