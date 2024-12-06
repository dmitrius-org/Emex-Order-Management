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
    from tOrders o with (nolock index=ao2)
   where o.ClientID = @ClientID
    and o.[IsCancel] = 1
    and o.[Flag] & 4096 /*Отказ подтвержден*/= 0
    and o.[Flag] & 8192 /*Перезаказан*/= 0

  exit_:

  select @GetNotificationCount as NotificationCount

  return @r
GO
grant exec on GetNotificationCount to public
go
exec setOV 'GetNotificationCount', 'P', '20241118', '1'
go
 




