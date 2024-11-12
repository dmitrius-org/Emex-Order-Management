drop proc if exists StatisticCancelledCalc
/*
  StatisticCancelledCalc - 
*/
go
create proc StatisticCancelledCalc
              @Clients     as ID READONLY, 
              @DateBegin   as datetime = null,
              @DateEnd     as datetime = null
as

declare @Orders as table(OrderID numeric(18, 0));

select @DateBegin = '19000101'
      ,@DateEnd   = '20700101'

if exists (select 1 from @Clients )
  insert @Orders 
        (OrderID)
  select o.OrderID
    from @Clients c 
   inner join tOrders o with (nolock index = ao2)
           on o.ClientID = c.ID
          and o.OrderDate between @DateBegin and @DateEnd
else
  insert @Orders 
        (OrderID)
  select o.OrderID
    from tOrders o with (nolock)
   where o.OrderDate between @DateBegin and @DateEnd
   and o.DetailNumber = '564583'

select 
--      o.Manufacturer 
--      ,o.DetailNumber 
--      ,o.DetailName
       o.PriceLogo
      ,sum(o.Quantity) DetailQuantity
      ,sum(o.Amount)   DetailAmount
      ,sum(case
               when o.isCancel = 1 then o.Quantity
               else 0
           end)        DetailQuantityCancel

      ,sum(case
               when o.isCancel = 1 then o.Amount
               else 0
           end)        DetailAmountCancel
      --,Sum(o.Amount)     DetailAmount
      --,Count(0)          Quantity  
from (
      select 
            -- o.Manufacturer 
            --,o.DetailNumber 
            o.PriceLogo
            --,ltrim(rtrim(Replace( case 
            --                        when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
            --                        then p.DetailName
            --                        else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
            --                      end  
            --                     ,o.[DetailNumber]  
            --                     ,'')))    as DetailName
            ,o.Quantity
            ,o.Amount
            ,o.isCancel
        from @Orders os
       inner join tOrders o with (nolock index=ao1)
               on o.OrderID = os.OrderID  
        left join tPrice p with (nolock index=ao1)
               on p.PriceID = o.PriceID

      ) as o
group by 
        -- o.Manufacturer 
        --,o.DetailNumber
         o.PriceLogo
        --,o.DetailName

go
grant exec on StatisticCancelledCalc to public
go
exec setOV 'StatisticCancelledCalc', 'P', '20241107', '1'
go
 
exec StatisticCancelledCalc