if OBJECT_ID('vTaskDetail') is not null
    drop view vTaskDetail
go
/* **********************************************************						
vTaskDetail.sql - 
********************************************************** */
create view vTaskDetail
as

select a.ObjectID as TaskID
      ,a.Comment
      ,a.ActionID
      ,a.UserID
      ,a.InDateTime
      ,a.Flag
  from tAudit a with (nolock index=ao2)
 where a.ObjectTypeID = 11

go
grant select on vTaskDetail to public
go
exec setOV 'vTaskDetail', 'V', '20241031', '0'
go
 
select * 
  from vTaskDetail
 order by InDateTime desc

