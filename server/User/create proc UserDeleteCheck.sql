if OBJECT_ID('UserDeleteCheck') is not null
    drop proc UserDeleteCheck
/*
  UserDeleteCheck - проверка возможности удаления пользователя
*/
go
create proc UserDeleteCheck
              @UserID          numeric(18,0)  --  
as
  declare @r int = 0

  if exists (select 1 
               from tOrders u (nolock)
              where u.UserID  = @UserID)
  begin
    set @r = 6 -- 'Удаление запрещено, пользователь используется в таблице заказов!'
    goto exit_
  end


  if exists (select 1 
               from tUserReliation u (nolock)
              where u.LinkType= 2
                and u.UserID  = @UserID)
  begin
    set @r = 11 -- Удаление запрещено, пользователь входит в группу прав!
    goto exit_
  end

 exit_:
 return @r
go
grant exec on UserDeleteCheck to public
go
exec setOV 'UserDeleteCheck', 'P', '20240101', '1.0.0.0'
go

