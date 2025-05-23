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

select @DateBegin = isnull(@DateBegin, dateadd(mm, -1, cast(getdate() as date)))
      ,@DateEnd   = isnull(@DateEnd,   '20700101')


;with t as
(
  Select o.OrderDate  , 
         o.Amount,
         o.Margin Margin,
         o.isCancel,
         o.StatusID
    from tOrders o (nolock)
    LEFT JOIN @Clients c
           ON o.ClientID = c.ID
   where 1=1
     and o.OrderDate between @DateBegin  and @DateEnd
     AND (NOT EXISTS (SELECT 1 FROM @Clients) OR c.ID IS NOT NULL)

)
  --  
  Select o.OrderDate   as OrderDate, 
         -- общие данные
         count(*)      as TotalCount,
         sum(o.Amount) as TotalSum,  

         -- взятов работу         
         sum(iif(o.isCancel = 0, 1, 0))         as WorkCount,
         sum(iif(o.isCancel = 0, o.Amount , 0)) as WorkSum,

         -- отказано
         sum(iif(o.isCancel = 1, 1, 0))         as CancelCount,
         sum(iif(o.isCancel = 1, o.Amount , 0)) as CancelSum,

         -- отказано отказано нами
         sum(iif(o.isCancel = 1 and o.StatusID = 12, 1, 0))         as CancelOurCount,
         sum(iif(o.isCancel = 1 and o.StatusID = 12, o.Amount , 0)) as CancelOurSum,

         -- отказано поставщиком (emex)
         sum(iif(o.isCancel = 1 and o.StatusID <> 12, 1, 0))         as CancelSupplierCount,
         sum(iif(o.isCancel = 1 and o.StatusID <> 12, o.Amount , 0)) as CancelSupplierSum,

         avg(o.Margin) as Margin -- наценка
  
    from t o (nolock)
   where 1=1
    
   group by o.OrderDate   
   order by o.OrderDate 


go
grant exec on StatisticqAverageCount to public
go
exec setOV 'StatisticqAverageCount', 'P', '20250523', '2'
go
 
exec StatisticqAverageCount