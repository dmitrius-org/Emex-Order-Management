if OBJECT_ID('ApiFindByNumberDelete', 'P') is not null
    drop proc ApiFindByNumberDelete	 
go
/* --------------------------------------------------------
  ApiFindByNumberDelete - 

-------------------------------------------------------- */
create proc ApiFindByNumberDelete   
as
set nocount on;

declare @RetVal       int  = 0

delete pFindByNumber from pFindByNumber with (rowlock) where spid = @@Spid
  
       
exit_:
return @RetVal    
go
grant exec on ApiFindByNumberDelete to public
go
exec setOV 'ApiFindByNumberDelete', 'P', '20250303', '0'
go
 