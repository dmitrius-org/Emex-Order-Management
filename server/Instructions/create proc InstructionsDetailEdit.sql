drop proc if exists InstructionsDetailEdit
/*
  InstructionsDetailEdit - 
*/
go
create proc InstructionsDetailEdit
              @InstructionID  numeric(18,0)
             ,@Text           varchar(max)  
as
  declare @r       int = 0


  if not exists (select 1
                   from tInstructionsDetail (nolock)
				  where InstructionID = @InstructionID)

  begin
    insert tInstructionsDetail ( InstructionID, [Text] ) select @InstructionID, @Text
  end
  else
  begin
    Update tInstructionsDetail
       set [Text]        = @Text
     where InstructionID = @InstructionID
  end


 exit_:
 return @r
go
grant exec on InstructionUpdate to public
go
exec setOV 'InstructionUpdate', 'P', '20240325', '0'
go
