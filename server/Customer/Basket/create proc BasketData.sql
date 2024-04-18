drop proc if exists BasketData
/*
  BasketData - агригирующие данные по корзине
*/
go

create proc BasketData
             @ClientID numeric(18, 0)
           
as
declare @r int = 0

select isnull(sum(t.Quantity * t.PriceRub), 0) Amount    -- Сумма
      ,Count(*)                                Cnt	     -- Количество
      ,isnull(Sum(WeightKG), 0)           WeightKG  -- Вес
  from tBasket t (nolock)
 where t.ClientID  = @ClientID

                       
  exit_:

  return @r
GO
grant exec on BasketData to public
go
exec setOV 'BasketData', 'P', '20240404', '1'
go

exec BasketData @ClientID=31


