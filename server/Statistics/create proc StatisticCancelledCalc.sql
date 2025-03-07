drop proc if exists StatisticCancelledCalc
/*
  StatisticCancelledCalc - статистика по отказам
*/
go
create proc StatisticCancelledCalc
              @Clients     as ID READONLY, 
              @Prices      as SID READONLY, 
              @PricesF     as SID READONLY, --фактический поставщик
              @PricesFCan  as bit      = null,
              @DateBegin   as datetime = null,
              @DateEnd     as datetime = null
as

declare @Orders as table(OrderID numeric(18, 0) PRIMARY KEY CLUSTERED);

select @DateBegin = isnull(@DateBegin, '19000101')
      ,@DateEnd   = isnull(@DateEnd,   '20700101')
      ,@PricesFCan= isnull(@PricesFCan, 0)

  insert @Orders 
        (OrderID)
  SELECT distinct o.OrderID
    FROM tOrders o WITH (NOLOCK)-- INDEX = ao2)
    LEFT JOIN @Clients c
           ON o.ClientID = c.ID
    -- поставщик из заказа
    LEFT JOIN @Prices p
           ON p.Name = o.CustomerPriceLogo
    -- поставщик факт
    LEFT JOIN @PricesF pа
           ON (@PricesFCan = 0 and pа.Name = o.PriceLogo )
           or (@PricesFCan = 1 and pа.Name <> o.PriceLogo)
   WHERE o.OrderDate BETWEEN @DateBegin AND @DateEnd
     --AND o.isCancel = 1
     AND (NOT EXISTS (SELECT 1 FROM @Clients) OR c.ID IS NOT NULL)
     AND (NOT EXISTS (SELECT 1 FROM @Prices)  OR p.Name IS NOT NULL)
     AND (NOT EXISTS (SELECT 1 FROM @PricesF) OR pа.Name IS NOT NULL);


select 

       o.OrderDate
      ,Quantity
      ,Amount
      ,QuantityCancel
      ,AmountCancel
      ,QuantityCancelEmex
      ,AmountCancelEmex
      ,QuantityCancelManager
      ,AmountCancelManger
      ,round(cast(case
                    when QuantityCancel = 0 then 0.00
                    when Quantity > 0 and Quantity = QuantityCancel then 100.00
                    else ((QuantityCancel * 100.00 / Quantity)) 
                  end as float), 2) PrcCancel
 from (
      select 
             o.OrderDate
            ,sum(o.Quantity) Quantity
            ,sum(o.Amount)   Amount
            ,sum(case when o.isCancel = 1 then o.Quantity else 0 end)   QuantityCancel
            ,sum(case when o.isCancel = 1 then o.Amount else 0  end)    AmountCancel

            ,sum(case when o.isCancel = 1 and p.UserID = 1 /* autotask */ then o.Quantity else 0 end)   QuantityCancelEmex
            ,sum(case when o.isCancel = 1 and p.UserID = 1 /* autotask */ then o.Amount else 0  end)    AmountCancelEmex

            ,sum(case when o.isCancel = 1 and p.UserID <> 1 /* autotask */ then o.Quantity else 0 end)   QuantityCancelManager
            ,sum(case when o.isCancel = 1 and p.UserID <> 1 /* autotask */ then o.Amount else 0  end)    AmountCancelManger


        from @Orders os
       inner join tOrders o with (nolock index=ao1)
               on o.OrderID = os.OrderID 
               
       outer apply (select top 1 p.UserID
                      from tProtocol p (nolock)
                     inner join tNodes n (nolock)
                             on n.NodeID = p.NewStateID
                            and n.SearchBrief = 'Отказ'
                     where p.ObjectID = o.OrderID
                     order by p.ProtocolID desc
                   ) as p

      left join tUser u (nolock)
              on u.UserID = p.UserID
       group by o.OrderDate
      ) as o
order by o.OrderDate


go
grant exec on StatisticCancelledCalc to public
go
exec setOV 'StatisticCancelledCalc', 'P', '20250305', '3'
go
 