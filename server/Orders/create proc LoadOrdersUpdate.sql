if OBJECT_ID('LoadOrdersUpdate') is not null
    drop proc LoadOrdersUpdate
/*
  LoadOrdersUpdate - обновление параметров загруженных заказов из файла


  pOrders - входящий набор данных
*/
go

Create proc LoadOrdersUpdate          
as
  set nocount on;
  declare @r int = 0

  Update t
     set 
         t.CustomerClientNum  = o.CustomerClientNum -- № Клиента
        ,t.CustomerClientSign = o.CustomerClientSign -- Пометки Клиента
        ,t.CustomerOrder      = o.CustomerOrder -- Заказ
    from pOrders o (nolock)
   inner join tOrders  t with (updlock)
           on t.ClientID          = o.ClientID
          and t.OrderNum          = o.OrderNum
          and t.DetailNumber = o.DetailNumber
          and t.DetailID     = o.DetailID
          and t.Manufacturer = o.Manufacturer
   where o.Spid = @@Spid
     and t.CustomerClientNum  is null  -- № Клиента
     and t.CustomerClientSign is null  -- Пометки Клиента
     and t.CustomerOrder      is null  -- Заказ
exit_:

return @r
go
grant exec on LoadOrdersUpdate to public
go
exec setOV 'LoadOrdersUpdate', 'P', '20250408', '13'
go
 