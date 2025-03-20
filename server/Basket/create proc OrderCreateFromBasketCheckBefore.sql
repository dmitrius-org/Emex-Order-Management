drop proc if exists OrderCreateFromBasketCheckBefore
/*
  OrderCreateFromBasketCheckBefore - проверки перед созданием заказа


  @ClientID  - ид клиента
  @PartID    - ид детали с формы поиска детали
*/
go

create proc OrderCreateFromBasketCheckBefore          
as
declare @r int = 0

  if exists (select 1
               from tMarks m with (nolock index=pk_tMarks)
              inner join tBasket b with (nolock index=ao1)
                      on b.BasketID = m.ID
                     and datediff(hh, b.InDateTime, getdate()) >= 24 -- прошло 24 часа, необходимо обновить цену
		      where m.Spid = @@spid
			    and m.Type = 6 -- Корзина
                )
  begin
    set @r = 701 -- 'Имеются позиции по которым необходимо обновить цену!'
	goto exit_
  end

  exit_:

  return @r
GO
grant exec on OrderCreateFromBasketCheckBefore to public
go
exec setOV 'OrderCreateFromBasketCheckBefore', 'P', '20240423', '1'
go
 