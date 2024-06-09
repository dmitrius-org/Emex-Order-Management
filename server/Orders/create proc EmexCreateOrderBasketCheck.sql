if OBJECT_ID('EmexCreateOrderBasketCheck') is not null
    drop proc EmexCreateOrderBasketCheck
/*
  EmexCreateOrderBasketCheck - процедура проверки корзины перед созданием заказа

*/
go
create proc EmexCreateOrderBasketCheck
as
  set nocount on;
  declare @r int = 0;
  
  Update pBasketDetails
     set RetVal  = 536 -- 'В корзине emex имеются отказанные детали!'
    from pBasketDetails p with (updlock index=ao2)
   inner join tOrders o with (nolock)
           on o.BasketId = p.BasketId
   inner join tNodes n with (nolock index=ao1)
           on n.NodeID  = o.StatusID
          and n.Brief  <> 'InBasket'
   where p.Spid = @@SPID
     and isnull(p.RetVal, 0) = 0
  
  Update pBasketDetails
     set RetVal  = 506  -- В корзине EMEX имеются детали которые не найдены в системе
    from pBasketDetails p with (updlock index=ao2)
    left join tOrders o with (nolock)
           on o.BasketId = p.BasketId
   where p.spid = @@spid
     and isnull(p.RetVal, 0) = 0
     and o.OrderID is null
  
  exit_:
  return @r
go
grant exec on EmexCreateOrderBasketCheck to public
go
exec setOV 'EmexCreateOrderBasketCheck', 'P', '20240606', '1'
go
