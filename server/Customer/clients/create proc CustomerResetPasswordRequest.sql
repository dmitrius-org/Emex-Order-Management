if OBJECT_ID('CustomerResetPasswordRequest') is not null
    drop proc CustomerResetPasswordRequest
/*
  CustomerResetPasswordRequest - запрос на сброс пароля
                        - 
*/
go
create proc CustomerResetPasswordRequest
              @ClientID  numeric(18,0) output -- 
			 ,@Hash      nvarchar(512) output
			 ,@Email     nvarchar(64)
as
  declare @r        int = 0
         ,@AuditID  numeric(18, 0)

  delete tRetMessage from tRetMessage (rowlock) where spid=@@spid

  if exists (select 1 
               from tClients u (nolock)
              where u.Email = @Email)
  begin

    Select @ClientID    = ClientID 
	  from tClients (nolock)
     where Email = @Email	

   set @Hash = master.dbo.fn_varbintohexstr(HashBytes('SHA2_512', 'reset' + @Email + convert(varchar(30), getdate())))

   Update tClients
      set Hash     = @Hash 
	     ,HashDate = getdate()
		 ,IsActive = 1
		 --,IsActive = 1
		 
    where ClientID = @ClientID	
	
    -- аудит
    exec AuditInsert
              @AuditID          = @AuditID out         
             ,@ObjectID         = @ClientID
             ,@ObjectTypeID     = 7	--Клиенты
             ,@ActionID         = 13--acReset
             ,@Comment          = 'Запрос на сброс пароля' 
  end
  else 
  begin
	  select @r= 13 --  'Email в системе не зарегистрирован!'
	  goto exit_
  end

exit_:

return @r
go
grant exec on CustomerResetPasswordRequest to public
go
exec setOV 'CustomerResetPasswordRequest', 'P', '20240320', '0'
go