if OBJECT_ID('FindByNumberUpdate_PartNameRus', 'P') is not null
    drop proc FindByNumberUpdate_PartNameRus	 
go
/* --------------------------------------------------------
  FindByNumberUpdate_PartNameRus -
-------------------------------------------------------- */
create proc FindByNumberUpdate_PartNameRus              
              @PartNameRus nvarchar(256) 
as          
set nocount on;

declare @RetVal       int
Update pFindByNumber
   set PartNameRus = isnull(@PartNameRus, PartNameRus)
      ,Flag        = isnull(Flag, 0)|65536 
 where spid = @@spid
       
exit_:
return @RetVal    
go
grant all on FindByNumberUpdate_PartNameRus to public
go
exec setOV 'FindByNumberUpdate_PartNameRus', 'P', '20250217', '0'
go
 