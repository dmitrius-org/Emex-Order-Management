drop proc if exists GetNotificationCount
/*
  GetNotificationCount -


  @OrderID  - ид заказа
*/
go

create proc GetNotificationCount  
              @ClientID numeric(15, 0)
as
declare @r int = 0
       ,@GetNotificationCount int

  select @GetNotificationCount = count(*) 
    from vCustomerOrderNotificationFilter
   where ClientID = @ClientID

  exit_:

  select @GetNotificationCount as NotificationCount

  return @r
GO
grant exec on GetNotificationCount to public
go
exec setOV 'GetNotificationCount', 'P', '20250211', '3'
go
