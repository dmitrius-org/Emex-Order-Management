if OBJECT_ID('MarksDelete') is not null
    drop proc MarksDelete
go
/* 						
create proc MarksDelete - 
*/
create proc MarksDelete
              @Type int = null
as
 
if @Type is null
  Delete tMarks 
    from tMarks with (rowlock index=pk_tMarks) 
   where Spid=@@Spid 
else
  Delete tMarks 
    from tMarks with (rowlock index=pk_tMarks) 
   where Spid=@@Spid 
     and Type=@Type

go
grant execute on MarksDelete to public
go
exec setOV 'MarksDelete', 'P', '20250531', '1'
go