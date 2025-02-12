drop view if exists vCustomerOrderNotificationFilter
/*
  vCustomerOrderNotificationFilter -
*/
go

create view vCustomerOrderNotificationFilter
as

  select o.OrderID, 
         o.ClientID 
    from tOrders o with (nolock)-- index=ao1)
   where ( (o.[IsCancel] = 1
        and o.[Flag] & 4096 /*Отказ подтвержден*/= 0
        and o.[Flag] & 8192 /*Перезаказан*/= 0)
       
       or o.[Flag] & 32 /*Сообщение от менеджера*/> 0
      )
go
grant all on vCustomerOrderNotificationFilter to public
go
exec setOV 'vCustomerOrderNotificationFilter', 'V', '20250211', '0'

select * 
from vCustomerOrderNotificationFilter
where ClientID = 57


