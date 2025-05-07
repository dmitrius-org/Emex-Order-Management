-- сумма не сходится с количеством и ценой
Select o.OrderID, Quantity, o.PricePurchaseF * o.Quantity 'calc sum',PricePurchaseF,  o.AmountPurchaseF
  from tOrders o (nolock)
 where isnull(o.PricePurchaseF, 0) * o.Quantity <> o.AmountPurchaseF



 Select o.OrderID, Quantity, o.PricePurchaseF * o.Quantity 'calc sum', PricePurchase, AmountPurchase
  from tOrders o (nolock)
 where isnull(o.PricePurchase, 0) * o.Quantity <> o.AmountPurchase


  Select o.OrderID, Quantity, o.Price * o.Quantity 'calc sum',Price,  o.Amount
  from tOrders o (nolock)
 where isnull(o.Price, 0) * o.Quantity <> o.Amount

/* -- исправление
  update o 
     set o.AmountPurchaseF = o.Quantity * o.PricePurchaseF
    from tOrders o 
   where o.PricePurchaseF * o.Quantity <> o.AmountPurchaseF


  update o 
     set o.AmountPurchase = o.Quantity * o.PricePurchase
    from tOrders o 
   where o.PricePurchase * o.Quantity <> o.AmountPurchase

  update o 
     set o.Amount = o.Quantity * o.Price
    from tOrders o 
   where o.Price * o.Quantity <> o.Amount

  */


-- не проставлен признак отказан и статус нет в наличи
select 'не проставлен признак отказан и статус нет в наличи', StatusID, p.NewStateID, o.OrderNum, o.DetailNumber,  *
  from tOrders o  (nolock)
 cross apply (select  * 
                from tProtocol p  (nolock)
               where p.ObjectID = o.OrderID
            --   order by p.ProtocolID desc
               ) as p
 where o.StatusID = 9	--NotAvailable
   and o.isCancel = 0

order by o.OrderID

/* -- исправление
update tOrders
   set isCancel = 1
  from tOrders
 where StatusID = 9	--NotAvailable
   and isCancel = 0
  */

-- проставлен признак отказан ...
select 'проставлен признак отказан', *
  from tOrders  (nolock)
 where StatusID in (1	--New
                   ,2	--InChecked
                   ,3	--InBasket
                   ,4	--InWork
                   ,5	--Purchased
                   ,6	--ReceivedOnStock
                   ,7	--ReadyToSend
                   ,8	--Send
                    )
   and isCancel = 1

  -- select * from tNodes

/* -- исправление
update tOrders
   set isCancel = 0
  from tOrders
 where StatusID in (1	--New
                   ,2	--InChecked
                   ,3	--InBasket
                   ,4	--InWork
                   ,5	--Purchased
                   ,6	--ReceivedOnStock
                   ,7	--ReadyToSend
                   ,8	--Send
                    )
   and isCancel = 1
  */

/*-- Протоколы без заказа
Select 'Протоколы без заказа', *
  from tProtocol p (nolock)
 where not exists (select 1
                    from tOrders o (nolock)
				   where o.OrderID = p.ObjectID
				   )

-- исправление
delete p
  from tProtocol p
 where not exists (select 1
                    from tOrders o (nolock)
				   where o.OrderID = p.ObjectID
				   )
*/


--
select 'Заказы, которые не удалось разбить на части',*
  from tMovement (nolock)
 where OrderID is null
 order by OrderNumber


----delete
----  from tMovement 
---- where OrderID is null

-- заказы, которых нет в emex
Select 'Заказы, которых нет в emex', c.Brief, p.EmexOrderID, p.EmexQuantity, P.Reference, n.Brief, n.Name, p.OrderNum, p.DetailNumber, p.Quantity,  *
  from tOrders p  (nolock)
 inner join tClients c (nolock)
         on c.ClientID = p.ClientID 
 inner join tNodes n (nolock)
         on n.NodeID  = p.StatusID
 where not exists (select 1
                     from tMovement m (nolock)
				    where m.OrderID = p.OrderID
				   )
--   and p.OrderDate >= '20240310'
   and StatusID in (--1	--New
                   --,2	--InChecked
                   -- 3	--InBasket
                   --,4	--InWork
                    5	--Purchased
                   ,6	--ReceivedOnStock
                   ,7	--ReadyToSend
                   ,8	--Send
				   ,9	--NotAvailable
                    )
               -- and p.Quantity < 0
  order by p.OrderDate, p.OrderNum,  p.DetailNumber


select *
  from tOrders p
 where p.Quantity < 0

/* -- исправление
delete p
  from tOrders p
 where p.Quantity < 0

delete p
  from tOrders p
 where not exists (select 1
                    from tMovement m (nolock)
				   where m.OrderID = p.OrderID
				   )
   --and p.isCancel = 0
   and StatusID in (--1	--New
                   --,2	--InChecked
                    3	--InBasket
                   ,4	--InWork
                   ,5	--Purchased
                   ,6	--ReceivedOnStock
                   ,7	--ReadyToSend
                   ,8	--Send
				   ,9	--NotAvailable
                    )
*/


--
select 'Смапили разное количество', m.Quantity QuantityM , o.Quantity QuantityQ, o.EmexQuantity, c.Brief, o.OrderDetailSubId, 
       o.OrderNum, o.DetailNumber,
       *
  from tMovement m (nolock)
  inner join tOrders o (nolock)
          on o.OrderID = m.OrderID
  inner join tClients c (nolock)
          on c.ClientID = o.ClientID
where m.Quantity <> o.Quantity

--
select 'Смапили не те детали', m.OrderDetailSubId, o.DetailNumber, m.DetailNum, o.EmexOrderID, m.OrderNumber,  o.DetailNumber, o.CustomerSubId, o.Reference, m.DetailNum, m.CustomerSubId, m.Reference ,    *
  from tMovement m (nolock)
  inner join tOrders o (nolock)
          on o.OrderDetailSubId = m.OrderDetailSubId
		 and ( (o.DetailNumber    <> m.DetailNum)
		    or (o.Reference <> m.Reference and o.CustomerSubId = m.CustomerSubId))
where isnull(m.OrderDetailSubId, '') <> '' 
	--	 and o.Manufacturer <> m.MakeLogo


/* -- исправление
begin tran
Update o
   set o.OrderDetailSubId = null
  from tMovement m (nolock)
  inner join tOrders o (nolock)
          on o.OrderDetailSubId = m.OrderDetailSubId
		 and o.DetailNumber <> m.DetailNum
where isnull(m.OrderDetailSubId, '') <> '' 
--commit tran
---where m.Quantity <> o.Quantity
*/


--select * from tMovement 
--where DetailNum = '86300D9700'


--select * from tOrders
--where DetailNumber = '86300D9700'

