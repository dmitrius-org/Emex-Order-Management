drop proc if exists StatisticBrandCalc
/*
  StatisticBrandCalc - 
*/
go
create proc StatisticBrandCalc
              @Clients     as ID READONLY, 
              @DateBegin   as datetime = null,
              @DateEnd     as datetime = null,
              @IsCancel    as bit = null 
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
          and o.isCancel = isnull(@IsCancel, o.isCancel)
else
  insert @Orders 
        (OrderID)
  select o.OrderID
    from tOrders o with (nolock index = ao2)
   where o.OrderDate between @DateBegin and @DateEnd
     and o.isCancel = isnull(@IsCancel, o.isCancel)

select o.Manufacturer 
      ,o.DetailNumber 
      ,o.DetailName
      ,sum(o.Quantity) DetailQuantity
      ,Sum(o.Amount)     DetailAmount
      ,Count(*)          Quantity  
from (
      select --o.ClientID
             o.Manufacturer 
            ,o.DetailNumber 
            ,ltrim(rtrim(Replace( case 
                                    when coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) in ('Автодеталь', 'Автозапчасть', 'Деталь', 'Запчасть')
                                    then p.DetailName
                                    else coalesce(nullif(p.[DetailNameF], ''), nullif(o.[DetailName], '')) 
                                  end  
                                 ,o.[DetailNumber]  
                                 ,'')))    as DetailName
            ,o.Quantity
            ,o.Amount
        from @Orders os
       inner join tOrders o with (nolock index=ao1)
               on o.OrderID = os.OrderID  
        left join tPrice p with (nolock index=ao1)
               on p.PriceID = o.PriceID

      ) as o
group by o.Manufacturer 
        ,o.DetailNumber
        ,o.DetailName

go
grant exec on StatisticBrandCalc to public
go
exec setOV 'StatisticBrandCalc', 'P', '20241107', '1'
go
 
exec StatisticBrandCalc