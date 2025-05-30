if OBJECT_ID('GetRetMsg') is not null
    drop function GetRetMsg
/*
  GetRetMsg - получение описания ошибки по коду
*/
go

create function dbo.GetRetMsg
              (@RetCode numeric(18,0))
RETURNS varchar(512)
WITH EXECUTE AS CALLER
AS
BEGIN
  declare @Message varchar(512)

  if @RetCode > 0
    Select @Message = case 
                        when SESSION_CONTEXT(N'language') = 'en' then MessageEn 
                        when SESSION_CONTEXT(N'language') = 'ru' then Message
                        else Message
                      end
      from tRetCode with (nolock index=ao1)  
     where RetCode = @RetCode
  else
    Select @Message = Message 
      from tRetMessage with (nolock index=ao1) 
     where spid     = @@spid
       and RetCode  = @RetCode

  RETURN(@Message);
END
go
grant exec on dbo.GetRetMsg to public
go
exec setOV 'GetRetMsg', 'FN', '20250529', '2'
go
