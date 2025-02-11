drop proc if exists GetOrderNotificationCount
go
create proc GetOrderNotificationCount 
/*
  GetOrderNotificationCount -
*/
as
declare @r int = 0
       ,@NotificationCount int

  select @NotificationCount = count(*) 
    from vOrderNotificationFilter

  select @NotificationCount as NotificationCount

  return @r
GO
grant exec on GetOrderNotificationCount to public
go
exec setOV 'GetOrderNotificationCount', 'P', '20250206', '0'
go
 