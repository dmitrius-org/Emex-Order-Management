if OBJECT_ID('ApiBasketOrderSelect') is not null
    drop proc ApiBasketOrderSelect
go
/* **********************************************************						
ApiBasketOrderSelect - получение списка заказов
********************************************************** */

create proc ApiBasketOrderSelect
               @ClientID numeric(18, 0)
              ,@OrderNum varchar(32)
as

SELECT OrderID
      ,ClientID
      ,cast(OrderNum as varchar) OrderNum
      ,1                       Status
      ,Count(*) over(partition by ClientID)         PositionsQuantity
      ,Sum(Amount) over(partition by ClientID)      TotalSum
      ,OrderDate               OrderDate
      
      ,Manufacturer          Brand
      ,DetailNumber          DetailNumber
      ,DetailName            DetailName
      ,Quantity              Quantity
      ,Price                 Price
      ,Amount                Amount
      ,itemKey               itemKey
      ,Comment2              Comment2 -- комментарий к позиции
      ,Comment3              Comment3 -- комментарий к заказу
  FROM tOrders o with (nolock index=ao2)
  --left join tMakes b with (nolock index=ao2) -- брент замены
  --       on cast(b.Code as nvarchar)= o.ReplacementMakeLogo
 WHERE o.ClientID = @ClientID
   and o.OrderNum = @OrderNum
go
grant exec on ApiBasketOrderSelect to public
go
exec setOV 'ApiBasketOrderSelect', 'P', '20250305', '0'
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vApiOrdersSelect', @desc = 'Список заказов'

exec ApiBasketOrderSelect 
       @ClientID = 57
      ,@OrderNum ='FL19032500001'
