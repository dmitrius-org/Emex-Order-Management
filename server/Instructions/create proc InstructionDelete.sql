drop proc if exists InstructionDelete
/*
  InstructionDelete - Удаление инструкции
*/
go
create proc InstructionDelete
              @InstructionID            numeric(18,0) 
as
  declare @r       int = 0

  --if @Type = 0
  --  and exists (select 1 
  --                from tOrders o (nolock)
  --               where o.StatusID  = @NodeID
		--	   )
  --begin
  --  set @r = 0-- ''
  --  goto exit_
  --end

  BEGIN TRY 
      delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
      Begin tran
 

      delete tInstructions
        from tInstructions (rowlock)       
       where InstructionID = @InstructionID

      delete tInstructionsDetail
        from tInstructionsDetail (rowlock)       
       where InstructionID = @InstructionID

      commit tran
  END TRY  
  BEGIN CATCH  
      if @@TRANCOUNT > 0
        rollback tran
    
      set @r = -1
      insert tRetMessage(RetCode, Message) select @r,  ERROR_MESSAGE()  

      goto exit_     
  END CATCH  


 exit_:
 return @r
go
grant exec on InstructionDelete to public
go
exec setOV 'InstructionDelete', 'P', '20240326', '1'
go
