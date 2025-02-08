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
    from vUserAccess ua 
   inner join tOrders o with (nolock index=ao2)
         on o.ClientID = ua.LinkID 
        and o.[IsCancel] = 0
    left join tOrdersDeliverySupplier od with (nolock index=PK_tOrdersDeliverySupplier_OrderID)
           on od.OrderID = o.OrderID
    where ua.UserID    = dbo.GetUserID()
      and ua.LinkType  = 7
      and isnull(od.DeliveryRestTermSupplier, o.DeliveryRestTermSupplier) <= 0 -- 
      and o.OrderDate >= '20250201'

    --and o.[Flag] & 4096 /*Отказ подтвержден*/= 0
    --and o.[Flag] & 8192 /*Перезаказан*/= 0

  select @NotificationCount as NotificationCount

  return @r
GO
grant exec on GetOrderNotificationCount to public
go
exec setOV 'GetOrderNotificationCount', 'P', '20250206', '0'
go
 