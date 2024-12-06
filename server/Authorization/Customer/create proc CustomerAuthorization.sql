drop proc if exists CustomerAuthorization
/*
  CustomerAuthorization - 
*/
go
create proc CustomerAuthorization
              @UserName        nvarchar(512)
             ,@Password        nvarchar(512) -- пароль в зашифровонном виде SHA2_512
             ,@ClientID        numeric(18, 0) output
as
  declare @r        int = 0
         ,@Cnt      int
         ,@IsActive bit
         ,@Pwd        nvarchar(512)
  
  Select @ClientID = ClientID,
         @IsActive = IsActive,
         @Pwd      = Password
    from tClients (nolock) 
   where Email    = @UserName 

  if isnull(@ClientID, 0) = 0
  begin
    set @r = 17 -- 'Имя пользователя или пароль неверны!'
    goto exit_
  end

  --провнряем количество попыток входа   
  select @Cnt = u.CNT 
    from tUsersAuthorization u (nolock)
   where u.UserName = @UserName

  if isnull(@Cnt, 0) >= 3
  begin
    set @r = 16 -- 'Пользователь заблокирован из-за неудачных попыток входа, повторите попытку через 30 минут!'
    goto AuthorizationCount_
  end

  if @Pwd <> @Password
  begin
    set @r = 17 -- 'Имя пользователя или пароль неверны!

    goto AuthorizationCount_
  end

  if isnull(@IsActive, 0) = 0
  begin
    set @r = 18 --  'Доступ отключен!'
    goto exit_
  end

  update tUsersAuthorization 
     set CNT        = 0
        ,inDatetime = null
   where UserName = @UserName
  
  goto exit_ 

  -- сохраняем количество попыток входа   
  AuthorizationCount_:  

  if @Cnt is null
  begin
    insert tUsersAuthorization (UserName, CNT, inDatetime)
    select @UserName, 1, GetDate()
  end
  else
  begin
    set @Cnt = isnull(@Cnt, 0) + 1

    update tUsersAuthorization 
       set CNT        = @Cnt
          ,inDatetime = GetDate()
     where UserName = @UserName
  end

 exit_:
 return @r
go
grant exec on CustomerAuthorization to public
go
exec setOV 'CustomerAuthorization', 'P', '20240327', '1'
go
