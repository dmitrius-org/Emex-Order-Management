if OBJECT_ID('ClientRegistrationConfirmed') is not null
    drop proc ClientRegistrationConfirmed
/*
  ClientRegistrationConfirmed - подтверждение регистрации
*/
go
create proc ClientRegistrationConfirmed
              @Hash      nvarchar(512)
as
  SET NOCOUNT ON;
  declare @r        int = 0
         ,@ClientID numeric(18, 0)

  select @ClientID = u.ClientID 
    from tClients u (nolock)
   where u.Hash                   = @Hash
     and isnull(u.IsConfirmed, 0) = 0
              
  if isnull(@ClientID, 0) <> 0
  begin
    set @r = 999

    Update tClients
       set IsActive       = 1 
          ,IsConfirmed    = 1
          ,IsConfirmedDate = GetDate()
     where ClientID = @ClientID      
  end
 
exit_:

return @r
go
grant exec on ClientRegistrationConfirmed to public
go
exec setOV 'ClientRegistrationConfirmed', 'P', '20240101', '1.0.0.0'
go
