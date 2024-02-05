if OBJECT_ID('OrderNum') is not null
    drop proc OrderNum
/*
  OrderNum - генерация номера клиентского заказа сделанного через сайт
  
  
  номер, он же Референс. Состоит из нескольких частей:
  Формат: XXDDMMYY00001
  XX назначается в зависимости от типа клиента
  Физическое лицо - FL
  Малый опт - WS
  Большой опт - WX
  DDMMYY - день, месяц, год по два символа с предшествующими нулями, если значение односимвольное. Пример: 060923
  00001 - порядковый номер заказа клиента, считается среди всех клиентских заказов в базе за сутки. Как только дата сменилась, нумерация начинается снова с 0001
*/
go
create proc OrderNum
              @ClientID numeric(18,0) 
             ,@OrderNum nvarchar(128) out
as
set nocount on;
  declare @r int = 0
         ,@s varchar(max)

  Declare @OrderNumMask nvarchar(10) -- константа для номера заказа
         ,@OrderCount   int -- количество заказов за сутки

  Select @OrderNumMask = ct.OrderNumMask
    from tClients c (nolock)
   inner join tClientType ct (nolock)
           on ct.ClientTypeID = c.ClientTypeID
   where c.ClientID = @ClientID 

  select @OrderNum = isnull(@OrderNumMask, '') + REPLACE(convert(varchar(10), getdate(), 3), '/', '')

  select @OrderCount = count(distinct OrderNum)
    from tOrders (nolock)
   where ClientID = @ClientID
     and cast(OrderDate as date) = cast(getdate() as date)

  select @OrderCount = isnull(@OrderCount, 0) + 1

  select @OrderNum = @OrderNum + right('000000'+ rtrim(@OrderCount), 5) 
	
 exit_:
 return @r
go
grant exec on OrderNum to public
go
 
 --exec OrdersReferenceCalc