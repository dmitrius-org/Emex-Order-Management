drop proc if exists InstructionInsert
/*
  InstructionInsert - 
*/
go
create proc InstructionInsert
              @InstructionID numeric(18,0) out
             ,@ParentID      numeric(18,0) 
             ,@Name          nvarchar(256)
             ,@Comment       nvarchar(512)= null  
			 ,@Type          int
     
as
  declare @r int = 0

  declare @ID as table (ID numeric(18, 0))
  insert into tInstructions
         (
          ParentID
         ,Name
         ,Comment
		 ,Type
         ,UserID
         )
  OUTPUT INSERTED.InstructionID INTO @ID
  select @ParentID    
        ,@Name	     
        ,@Comment	 
		,@Type
		,dbo.GetUserID()


   Select @InstructionID = ID from @ID

 exit_:
 return @r
go
grant exec on InstructionInsert to public
go
exec setOV 'InstructionInsert', 'P', '20240412', '1'
go
