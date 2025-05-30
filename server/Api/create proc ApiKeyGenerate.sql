if OBJECT_ID('ApiKeyGenerate', 'P') is not null
    drop proc ApiKeyGenerate     
go
/* --------------------------------------------------------
  ApiKeyGenerate - генерация и сохранение API-ключа
-------------------------------------------------------- */
create proc ApiKeyGenerate 
              @ClientID numeric(18, 0)
             ,@ApiKey   VARCHAR(32) = null out
as
BEGIN
set nocount on;

declare @RetVal       int

DECLARE @RawKey UNIQUEIDENTIFIER = NEWID();

-- Хешируем GUID в строку
--SET @ApiKey = CONVERT(NVARCHAR(128), HASHBYTES('SHA2_256', CAST(@RawKey AS NVARCHAR(36))), 2);
SET @ApiKey = LEFT(CONVERT(NVARCHAR(40), HASHBYTES('SHA1', CAST(@RawKey AS NVARCHAR(36))), 2), 16);

-- Сохраняем ключ в таблицу
insert tApiKeys
      (ClientID
      ,Name
      ,ApiKey
      ,ApiKeyMD5
      )
select @ClientID
      ,''
      ,@ApiKey
      ,CONVERT(VARCHAR(32), HASHBYTES('MD5', @ApiKey),2)
END
    
exit_:
return @RetVal    
go
grant exec on ApiKeyGenerate to public
go
exec setOV 'ApiKeyGenerate', 'P', '20250515', '1'
go
