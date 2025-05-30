if OBJECT_ID('vBasketOrderCount') is not null
    drop view vBasketOrderCount
go
/* **********************************************************						
vBasketOrderCount - 
********************************************************** */
create view vBasketOrderCount
as
select 
       isnull((Sum(b.Quantity)), 0)            DetailPosCount
      ,isnull((Count(*)       ), 0)            DetailCount
      ,isnull((Sum(b.Amount  )), 0)            OrderAmount
      ,isnull((Sum(b.Weightkg*b.Quantity)), 0) OrderWeight
  from tMarks m (nolock)
 inner join tBasket b (nolock)
         on b.BasketID = m.ID
 where m.spid = @@spid   
   and m.Type = 6--Корзина
go
grant all on vBasketOrderCount to public
go
exec setOV 'vBasketOrderCount', 'V', '20250218', '1'
