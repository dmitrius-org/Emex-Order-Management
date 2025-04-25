if OBJECT_ID('ApiKeyDelete', 'P') is not null
    drop proc ApiKeyDelete     
go
/* --------------------------------------------------------
  ApiKeyDelete - удаление API-ключа
-------------------------------------------------------- */
create proc ApiKeyDelete 
              @ApiKeysID int
as
BEGIN
  set nocount on;

  declare @RetVal       int

  delete tApiKeys from tApiKeys with (rowlock index=PK_tApiKeys_ApiKeysID) where ApiKeysID= @ApiKeysID
 
END
    
exit_:
return @RetVal    
go
grant exec on ApiKeyDelete to public
go
exec setOV 'ApiKeyDelete', 'P', '20250423', '0'
go
