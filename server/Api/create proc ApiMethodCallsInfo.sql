
CREATE OR ALTER PROCEDURE ApiMethodCallsInfo
              @ClientID         numeric(18, 0)  
             ,@ApiKey           varchar(64)
             ,@MethodName       varchar(64)
/*
  ApiMethodCallsInfo - 
*/
as
  set nocount on
  declare @r int

  select @R         = 0
  
  MERGE INTO tApiMethodCalls WITH (HOLDLOCK) AS target
  USING (SELECT @ClientID   AS ClientID, 
                @ApiKey     AS ApiKey,
                @MethodName AS MethodName) AS source
      ON target.ClientID   = source.ClientID 
     AND target.ApiKey     = source.ApiKey
     AND target.MethodName = source.MethodName
  WHEN MATCHED THEN
      UPDATE 
         SET CallCount = target.CallCount + 1
  WHEN NOT MATCHED THEN
      INSERT (ClientID, ApiKey, MethodName, CallCount) 
      VALUES (source.ClientID, source.ApiKey, source.MethodName, 1);
  
  --SELECT CallCount 
  --  FROM tApiMethodCalls (nolock)
  -- WHERE ClientID = @ClientID 
  --   AND MethodName = @MethodName;
 -- BEGIN TRANSACTION;
    -- Попытка обновления существующей записи
    --UPDATE tApiMethodCalls WITH (ROWLOCK)
    --   SET CallCount = CallCount + 1
    -- WHERE ClientID = @ClientID
    --   AND MethodName = @MethodName;

    ---- Если запись не была обновлена (не существует), выполняем вставку
    --IF @@ROWCOUNT = 0
    --BEGIN
    --    INSERT INTO tApiMethodCalls WITH (ROWLOCK)
    --           (ClientID, MethodName, CallCount)
    --    VALUES (@ClientID, @MethodName, 1);
    --END

 -- WAITFOR DELAY '00:00:5'
  
   -- COMMIT TRANSACTION;
exit_:
return @r
go
grant exec on ApiMethodCallsInfo to public
go
exec setOV 'ApiMethodCallsInfo', 'P', '20250217', '1'
go

