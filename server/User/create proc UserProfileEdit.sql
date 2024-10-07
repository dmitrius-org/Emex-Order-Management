drop proc if exists UserProfileEdit
/*
  UserProfileEdit - Изменение сведений о пользователе
*/
go
create proc UserProfileEdit
              @UserID          numeric(18,0)  --  
             ,@Name	           nvarchar(512)  -- 
             ,@Email	       nvarchar(64) =null
as
  declare @r int = 0

  BEGIN TRY 
    delete tRetMessage from tRetMessage (rowlock) where spid=@@spid
    Begin tran         
      Update u
         set u.Name        = @Name
            ,u.Email       = @Email
            ,u.updDatetime = getdate()
        from tUser u (updlock)
       where u.UserID = @UserID

      declare @AuditID numeric(18, 0)
      exec AuditInsert
             @AuditID      = @AuditID out
            ,@ObjectID     = @UserID
            ,@ObjectTypeID = 2
            ,@ActionID     = 2
            ,@Comment      = 'Изменение профиля пользователя '

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
grant exec on UserProfileEdit to public
go
exec setOV 'UserProfileEdit', 'P', '20241007', '1'
go
