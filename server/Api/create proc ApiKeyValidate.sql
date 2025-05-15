if OBJECT_ID('ApiKeyValidate', 'P') is not null
    drop proc ApiKeyValidate	 
go
/* --------------------------------------------------------
  ApiKeyValidate - 
-------------------------------------------------------- */
create proc ApiKeyValidate
               @ClientID     numeric(18, 0) out 
              ,@ApiKey       nvarchar(256) 
    
as
set nocount on;

declare @RetVal       int  = 0

SELECT @ClientID = ClientID 
  FROM tApiKeys with (nolock index=ao2) 
 WHERE ApiKeyMD5 = @ApiKey   
       
exit_:
return @RetVal    
go
grant exec on ApiKeyValidate to public
go
exec setOV 'ApiKeyValidate', 'P', '20250515', '0'
go
 