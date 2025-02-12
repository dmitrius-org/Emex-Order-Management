drop view if exists vOrderNotificationFilter
go
create view vOrderNotificationFilter
/*
  vOrderNotificationFilter -
*/
as

  select o.OrderID
    from vUserAccess ua 
   inner join tOrders o with (nolock)-- index=ao2)
         on o.ClientID = ua.LinkID         
    left join tOrdersDeliverySupplier od with (nolock index=PK_tOrdersDeliverySupplier_OrderID)
           on od.OrderID = o.OrderID
    where ua.UserID    = dbo.GetUserID()
      and ua.LinkType  = 7
      and (
          /**/
          (o.[IsCancel] = 0
          and isnull(od.DeliveryRestTermSupplier, o.DeliveryRestTermSupplier) <= 0 -- 
          and o.OrderDate >= '20250201')
          
          /**/
          or (o.[Flag] & 2048 /*Сообщение от клиента*/> 0)
        
          )
 
go
grant all on vOrderNotificationFilter to public
go
exec setOV 'vOrderNotificationFilter', 'V', '20250206', '0'
go
