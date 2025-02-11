if OBJECT_ID('ChatsFilter_Status') is not null
    drop proc ChatsFilter_Status
/*
  ChatsFilter_Status - формирование значений для фильтра статус
*/
go
create proc ChatsFilter_Status
as
    declare @r          int = 0

    SELECT 1 as ID, 'Открытые'   as Name union all
    SELECT 2 as ID, 'В ожидании' as Name union all
    SELECT 3 as ID, 'Закрытые'   as Name   

 exit_:
 return @r
go
grant execute on ChatsFilter_Status to public
go
exec setOV 'ChatsFilter_Status', 'P', '20250127', '1'
go


exec ChatsFilter_Status
