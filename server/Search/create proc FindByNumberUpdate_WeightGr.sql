if OBJECT_ID('FindByNumberUpdate_WeightGr', 'P') is not null
    drop proc FindByNumberUpdate_WeightGr	 
go
/* --------------------------------------------------------
  FindByNumberUpdate_WeightGr -
-------------------------------------------------------- */
create proc FindByNumberUpdate_WeightGr              
              @WeightGr money
as          
set nocount on;

declare @RetVal       int
Update pFindByNumber
   set WeightGr = isnull(@WeightGr, WeightGr)
      ,Flag     = isnull(Flag, 0)| 512 -- Вес изменен клиентом
 where spid = @@spid
       
exit_:
return @RetVal    
go
grant all on FindByNumberUpdate_WeightGr to public
go
exec setOV 'FindByNumberUpdate_WeightGr', 'P', '20250217', '0'
go
 