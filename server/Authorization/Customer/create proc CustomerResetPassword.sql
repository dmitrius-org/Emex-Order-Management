if OBJECT_ID('CustomerResetPassword') is not null
    drop proc CustomerResetPassword
go
create proc CustomerResetPassword
			 @Hash      nvarchar(1024),
			 @Password  nvarchar(64)
/*
  CustomerResetPassword - сброс пароля
                        - 
*/
as
  declare @r           int = 0
         ,@AuditID     numeric(18, 0)
		 ,@ClientID    numeric(18, 0)

  delete tRetMessage from tRetMessage with (rowlock index=ao1) where spid=@@spid

  if isnull(@Password, '') = ''
  begin
	  select @r= 15 -- 
	  goto exit_
  end

  select @ClientID = u.ClientID 
    from tClients u (nolock)
   where u.[Hash] = @Hash

  if isnull(@ClientID, 0) > 0
  begin
      Update tClients
         set Password     = master.dbo.fn_varbintohexstr(HashBytes('SHA2_512', @Password))
            ,PasswordDate = SYSDATETIME()
		    ,Hash         = null
       where ClientID = @ClientID  

      -- аудит
      exec AuditInsert
              @AuditID          = @AuditID out         
             ,@ObjectID         = @ClientID
             ,@ObjectTypeID     = 7	--Клиенты
             ,@ActionID         = 13	--acReset
             ,@Comment          = 'Сброс пароля' 
  end
  else 
  begin
	  select @r= 14 --  'Ошибка сброса пароля!'
	  goto exit_
  end

exit_:

return @r
go
grant exec on CustomerResetPassword to public
go
exec setOV 'CustomerResetPassword', 'P', '20240205', '1'
go