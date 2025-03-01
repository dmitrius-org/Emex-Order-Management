
CREATE OR ALTER PROCEDURE ApiMethodCallsInfo
              @ClientID         numeric(18, 0)  
             ,@MethodName       varchar(100)
/*
  ApiMethodCallsInfo - 
*/
as
  set nocount on
  declare @r int

  select @R         = 0

  MERGE INTO tApiMethodCalls AS target
  USING (SELECT @ClientID   AS ClientID, 
                @MethodName AS MethodName) AS source
     ON target.ClientID = source.ClientID 
     AND target.MethodName = source.MethodName
  WHEN MATCHED THEN
      UPDATE SET CallCount = target.CallCount + 1
  WHEN NOT MATCHED THEN
      INSERT (ClientID, MethodName, CallCount) 
      VALUES (source.ClientID, source.MethodName, 1);
  
  --SELECT CallCount 
  --  FROM tApiMethodCalls (nolock)
  -- WHERE ClientID = @ClientID 
  --   AND MethodName = @MethodName;
  WAITFOR DELAY '00:00:5'
exit_:
return @r
go
grant exec on ApiMethodCallsInfo to public
go
exec setOV 'ApiMethodCallsInfo', 'P', '20250217', '1'
go

