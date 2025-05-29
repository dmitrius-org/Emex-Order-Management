if OBJECT_ID('CustomerOrderFilter_Status') is not null
    drop proc CustomerOrderFilter_Status
/*
  CustomerOrderFilter_Status - формирование значений для фильтра статус
*/
go
create proc CustomerOrderFilter_Status
as
    declare @r          int = 0

    SELECT distinct
           n.SearchID    as ID
          ,n.SearchBrief as Name
      FROM [tNodes] n (nolock)
     where n.Type   = 0 -- состояния
     order by ID

 exit_:
 return @r
go
grant exec on CustomerOrderFilter_Status to public
go
exec setOV 'CustomerOrderFilter_Status', 'P', '20250529', '1'
go
exec CustomerOrderFilter_Status 



