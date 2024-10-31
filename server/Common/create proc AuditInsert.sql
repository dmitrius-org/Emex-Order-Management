if OBJECT_ID('AuditInsert') is not null
    drop proc AuditInsert
/*
  AuditInsert - 
*/
go
create proc AuditInsert
              @AuditID          numeric(18, 0) Output  --             
             ,@ObjectID         numeric(18, 0)   -- ИД объекта по которому ведется аудит

             ,@ObjectTypeID     numeric(18, 0)   -- тип объекта 
             ,@ActionID         numeric(18, 0)   -- ИД выполняемое дейстие из tAction
             ,@Comment          varchar(1024)   -- Комментарий
             ,@UserID           numeric(18, 0) = null  -- 
             ,@HostInfoID       varchar(256)  = null
             ,@Flag             int = null
as
  set nocount on

  declare @r int = 0
  DECLARE @ID TABLE (ID numeric(18,0));

  select @UserID     = isnull(nullif(@UserID, 0), dbo.getUserID())
        ,@HostInfoID = nullif(@HostInfoID, '')

 BEGIN TRY 
    delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
    --Begin tran
    insert into tAudit
          (           
           ObjectID         
          ,ObjectTypeID     
          ,ActionID         
          ,Comment
          ,UserID
          ,HostInfoID
          ,Flag)
    OUTPUT INSERTED.AuditID INTO @ID
    select      
           @ObjectID	     
          ,@ObjectTypeID	 
          ,@ActionID 
          ,@Comment
          ,@UserID
          ,@HostInfoID
          ,@Flag
    --commit tran
  END TRY  
  BEGIN CATCH  
    --if @@TRANCOUNT > 0
    --  rollback tran
    
    set @r = -1
    insert tRetMessage(RetCode, Message) select @r,  ERROR_MESSAGE()  

    goto exit_     
  END CATCH  

Select @AuditID = ID from @ID

exit_:
return @r
go
grant exec on AuditInsert to public
go
exec setOV 'AuditInsert', 'P', '20241031', '2'
go
