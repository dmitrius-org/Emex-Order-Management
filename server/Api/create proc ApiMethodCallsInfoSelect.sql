if OBJECT_ID('ApiMethodCallsInfoSelect', 'P') is not null
    drop proc ApiMethodCallsInfoSelect	 
go
/* --------------------------------------------------------
  ApiMethodCallsInfoSelect - 
-------------------------------------------------------- */
create proc ApiMethodCallsInfoSelect
               @ClientID     numeric(18, 0)
    
as
set nocount on;

declare @RetVal   int  = 0

SELECT MethodName, CallCount 
 FROM tApiMethodCalls (nolock) 
WHERE ClientID = @ClientID

exit_:
return @RetVal    
go
grant exec on ApiMethodCallsInfoSelect to public
go
exec setOV 'ApiMethodCallsInfoSelect', 'P', '20250515', '0'
go
 