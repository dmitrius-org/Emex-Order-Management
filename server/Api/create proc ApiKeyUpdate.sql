if OBJECT_ID('ApiKeyUpdate', 'P') is not null
    drop proc ApiKeyUpdate     
go
/* --------------------------------------------------------
  ApiKeyUpdate - генерация и сохранение API-ключа
-------------------------------------------------------- */
create proc ApiKeyUpdate 
              @ApiKeysID int
             ,@Name       VARCHAR(255) = null 
as
BEGIN
    set nocount on;

    declare @RetVal       int

    Update tApiKeys
       set Name = @Name
     where ApiKeysID= @ApiKeysID

END
    
exit_:
return @RetVal    
go
grant exec on ApiKeyUpdate to public
go
exec setOV 'ApiKeyUpdate', 'P', '20250423', '0'
go
