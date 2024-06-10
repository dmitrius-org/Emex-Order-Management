if OBJECT_ID('DashBoardDataLoad') is not null
    drop proc DashBoardDataLoad
/*
  DashBoardDataLoad -


status:
info
warning 
danger
success


*/
go
create proc DashBoardDataLoad
as
  SET NOCOUNT ON; SET DATEFIRST 1 ;  
  declare @r int = 0


  if OBJECT_ID('tempdb..#result') is not null
      drop table #result
  CREATE TABLE #result
  (
      id     int,
      name   nvarchar(30),
      status nvarchar(30), 
      icon   nvarchar(30), 
  );
  
  insert #result (id, name, status, icon) 
  select 1,
         'Загрузка курсов',
         case 
             when datepart(dw, getdate()) = 1 and datediff(dd, t.OnDate, getdate()) >= 3 then 'panel-danger'
             when datediff(dd, OnDate, getdate()) >= 1 then 'panel-danger'
             else 'panel-success'
         end,
         'fa4-usd'
    from
          (select top 1* 
             from tCurrencyRate (nolock) 
            order by OnDate desc
          ) as t
  


  select * 
    from #result (nolock)

exit_:
return @r
go
grant exec on DashBoardDataLoad to public
go
exec setOV 'DashBoardDataLoad', 'P', '20240610', '1'
go


exec DashBoardDataLoad