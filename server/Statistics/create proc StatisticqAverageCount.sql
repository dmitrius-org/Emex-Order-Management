drop proc if exists StatisticqAverageCount
/*
  StatisticqAverageCount - статистика 
*/
go
create proc StatisticqAverageCount
              @Clients     as ID READONLY, 
              @DateBegin   as datetime = null,
              @DateEnd     as datetime = null
as

declare @Orders as table(OrderID numeric(18, 0) PRIMARY KEY CLUSTERED);

select @DateBegin = isnull(@DateBegin, '19000101')
      ,@DateEnd   = isnull(@DateEnd,   '20700101')
     

;with t as
(
  Select o.OrderDate  , 
         o.Amount,
         o.Margin Margin,
         o.isCancel
    from tOrders o (nolock)
    LEFT JOIN @Clients c
           ON o.ClientID = c.ID
   where 1=1
     and o.OrderDate between @DateBegin  and @DateEnd
     AND (NOT EXISTS (SELECT 1 FROM @Clients) OR c.ID IS NOT NULL)
   --  !Client
)
  --  
  Select o.OrderDate   as OrderDate, 
         -- общие данные
         count(*)      as TotalCount,
         sum(o.Amount) as TotalSum,  
         -- взятов работу         
         sum(case 
                 when o.isCancel = 0 then 1
                 else 0
             end)      as WorkCount,
         sum(case 
                 when o.isCancel = 0 then o.Amount 
                 else 0
             end)      as WorkSum,
         -- отказано
         sum(case 
                 when o.isCancel = 1 then 1
                 else 0
             end)      as CancelCount,
         sum(case 
                 when o.isCancel = 1 then o.Amount 
                 else 0
             end)      as CancelSum,
         avg(o.Margin) as Margin -- наценка
  
    from t o (nolock)
   where 1=1
    
   group by o.OrderDate   
   order by o.OrderDate


go
grant exec on StatisticqAverageCount to public
go
exec setOV 'StatisticqAverageCount', 'P', '20241121', '1'
go
 
exec StatisticqAverageCount