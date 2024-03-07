
if OBJECT_ID('BasketCheck') is not null
    drop proc BasketCheck
/*
  BasketCheck - проверка данных в корзине и данных на нашей стороне
*/
go
create proc BasketCheck
as
  declare @r int = 0

  Delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid

  insert into pAccrualAction
        (Spid, ObjectID, Retval, Message)
  Select @@Spid, 0, 506,
		 'В корзине EMEX имеются детали которые не найдены в системе: BasketId=' + convert(varchar(20), p.BasketId) + ', MakeLogo=' + p.MakeLogo + ', PriceLogo=' + p.PriceLogo + ', DetailNum=' +p.DetailNum
    from pBasketDetails p (nolock)
    left join tOrders o with (nolock)
           on o.BasketId = p.BasketId
   where p.spid = @@spid
     and o.OrderID is null
  

  insert into pAccrualAction
        (Spid, ObjectID, Retval, Message)
  Select @@Spid, 0, 506, 'Состояние заказа должно быть "В корзине"!'
    from pBasketDetails p (nolock)
   inner join tOrders o with (nolock)
           on o.BasketId = p.BasketId
   inner join tNodes n (nolock)	
           on n.NodeID = o.StatusID
		  and n.brief <> 'InBasket'
   where p.spid = @@spid


 exit_:
 return @r
go
grant exec on BasketCheck to public
go
exec setOV 'BasketCheck', 'P', '20240101', '1.0.0.1'
go
  