drop proc if exists OrderRefusalsInsert
/*
  TaskRefusals   
*/
go
create proc OrderRefusalsInsert
              @FileName nvarchar(128)
as
  set nocount on
  declare @r int

  if exists (select 1
               from tOrderRefusals (nolock)
              where FileName = @FileName
                and Flag&4=4
                and Flag&8=0) 
  begin
    select @r=525-- 'Данный файл уже в обработке!' 
    goto exit_
  end 

  delete tOrderRefusals
    from tOrderRefusals (rowlock)
   where FileName = @FileName
     and Flag&4=0
     --and Flag&8=0

  insert tOrderRefusals (FileName, Flag)
  select @FileName, 
         2 -- файл
   where not exists (select 1
                       from tOrderRefusals t (nolock)
                      where t.FileName = @FileName
                        and t.Flag&4   = 0 )

 exit_:
 return @r
go
grant exec on OrderRefusalsInsert to public
go
exec setOV 'OrderRefusalsInsert', 'P', '20240101', '0'
go
 