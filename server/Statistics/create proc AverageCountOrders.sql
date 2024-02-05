drop proc if exists AverageCountOrders
/*
  AverageCountOrders - Среднее количество заказов за период

*/
--go
--create proc AverageCountOrders
--              @DateBegin datetime
--             ,@DateEnd   datetime
--as
--  set nocount on
--  declare @r int

--  Select p.d, 
--         count(*)      orderCount ,
--         sum(o.Amount) orderSum
    
--    from tOrders o (nolock)
--   cross apply ( select top 1 cast(p.InDateTime as date) d
--                   from tProtocol p with (nolock index=ao2)
--                 inner join tNodes n (nolock)
--                         on n.NodeId = p.NewStateID
--                        and n.Brief in ('InWork')
--                  where p.objectID  = o.OrderID
                    
--                  order by p.OperDate desc
--                ) p
--   where 1=1
--     and p.d between @DateBegin and @DateEnd
--     and o.isCancel = 0
--   group by p.d     
--   order by p.d

-- exit_:
-- return 0
--go
--grant exec on AverageCountOrders to public
--go


--exec AverageCountOrders
--       @DateBegin = '20231001'
--      ,@DateEnd   = '20231123'