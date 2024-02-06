if OBJECT_ID('OrderAutoSetStatus') is not null
    drop proc OrderAutoSetStatus
/*
  OrderAutoSetStatus - Автоматический перевод по статусам 
 
 #Order - входящий набор данных

  
  Помечать детали которые переведены в статус "в работе" как проверенные. После этого сразу проставлять им статус "проверено" при получении нового заказа
  https://trello.com/c/JAZVDzHf/77-%D0%B8%D0%BD%D1%82%D0%B5%D1%80%D1%84%D0%B5%D0%B9%D1%81-%D0%B0%D0%B2%D1%82%D0%BE%D0%BC%D0%B0%D1%82%D0%B8%D1%87%D0%B5%D1%81%D0%BA%D0%B0%D1%8F-%D0%BF%D1%80%D0%BE%D0%B2%D0%B5%D1%80%D0%BA%D0%B0
  
*/
go

Create proc OrderAutoSetStatus
           
as
  set nocount on;
  declare @r int = 0

  declare @InChecked numeric(18, 0)
  select @InChecked = NodeID
    from tNodes (nolock)
   Where Brief = 'InChecked'

  declare @AutomaticToChecked numeric(18, 0)
  select @AutomaticToChecked = NodeID
    from tNodes (nolock)
   Where Brief = 'AutomaticToChecked'

  delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid

  --Помечать детали которые переведены в статус "в работе" как проверенные. После этого сразу проставлять им статус "проверено" при получении нового заказа
  insert into pAccrualAction
        (Spid,
		 ObjectID,
		 ActionID,
		 StateID,
		 NewStateID)
  Select @@Spid,
         o.OrderID ,
		 @AutomaticToChecked,
		 o.StatusID,
		 @InChecked
    from #Order p (nolock)
   inner join tOrders o (nolock)
           on o.OrderID = p.OrderID
   where exists  (select top 1 *
                    from tOrders t (nolock)
                   inner join tProtocol pr (nolock)
                           on pr.ObjectID =t.OrderID
                   inner join tNodes n (nolock)
                           on n.NodeID = pr.NewStateID
                          and n.brief  = 'InWork'
                   where t.Manufacturer = o.Manufacturer
                     and t.DetailNumber = o.DetailNumber
                  ) 

  exec ProtocolAdd

exit_:

return @r
GO
grant exec on OrderAutoSetStatus to public
go