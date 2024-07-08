if OBJECT_ID('MassAuditInsert') is not null
    drop proc MassAuditInsert
/*
  MassAuditInsert - массовое добавление аудита по заказам
*/
go
create proc MassAuditInsert
as
  set nocount on;

  declare @r           int = 0
         ,@UserID      numeric(18, 0)
  DECLARE @ID TABLE (ID numeric(18,0), ObjectID numeric(18,0));

  select @UserID     = dbo.getUserID()
     --   ,@HostInfoID = nullif(@HostInfoID, '')

 BEGIN TRY 
    delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
    --Begin tran
    insert into tAudit
          (           
           ObjectID         
          ,ObjectTypeID     
          ,ActionID         
          ,Comment
          ,Flag
          ,UserID
          ,HostInfoID)
    OUTPUT INSERTED.AuditID, INSERTED.ObjectID INTO @ID (ID, ObjectID)
    select p.ObjectID	     
          ,p.ObjectTypeID	 
          ,p.ActionID 
          ,p.Comment
          ,p.Flag
          ,isnull(p.UserID, @UserID)
          ,p.HostInfoID
      from pAuditInsert p (nolock)
     where p.Spid = @@spid
       and isnull(p.Retval, 0) = 0

    update p
       set p.AuditID = i.ID
      from pAuditInsert p (updlock)
     inner join @ID i
             on i.ObjectID = p.ObjectID
     where p.Spid = @@spid

    --commit tran
  END TRY  
  BEGIN CATCH  
    --if @@TRANCOUNT > 0
    --  rollback tran
    
    set @r = -1
    insert tRetMessage(RetCode, Message) select @r,  ERROR_MESSAGE()  

    goto exit_     
  END CATCH  

exit_:
return @r
go
grant exec on MassAuditInsert to public
go
exec setOV 'MassAuditInsert', 'P', '20240708', '1'
go
