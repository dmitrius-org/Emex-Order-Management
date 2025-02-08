if OBJECT_ID('EmployeeOrdersProcessedSelect') is not null
    drop proc EmployeeOrdersProcessedSelect
/*
  EmployeeOrdersProcessedSelect - 
*/
go

Create proc EmployeeOrdersProcessedSelect
              @Employees   as ID READONLY, 
              @DateBegin   as datetime = null,
              @DateEnd     as datetime = null
as
  declare @r int = 0

  select @DateBegin = isnull(@DateBegin, '19000101'),
         @DateEnd   = isnull(@DateEnd, '27001231')

  delete pEmployeeOrdersProcessed
    from pEmployeeOrdersProcessed with (rowlock index=ao1)
   where Spid = @@Spid

  insert pEmployeeOrdersProcessed with (rowlock) -- итого
        (Spid, EmployeeID, Flag)
  SELECT distinct 
         @@Spid
        ,u.UserID
        ,1 --
    FROM tUser u WITH (NOLOCK INDEX = ao1)
    LEFT JOIN @Employees e
           ON e.ID= u.UserID
   WHERE 1=1
     AND (NOT EXISTS (SELECT 1 FROM @Employees) OR e.ID IS NOT NULL)

  insert pEmployeeOrdersProcessed with (rowlock) -- все обработанные строки
        (Spid, 
         EmployeeID, 
         OrderID, 
         Processed, 
         ProcessedSum,
         ConfirmedSum,
         IncorrectSum,
         Flag,
         InDateTime)
  select distinct
         @@Spid
        ,p.EmployeeID
        ,t.OrderID
        ,1--Processed
        ,isnull(e.ProcessedVal, e2.ProcessedVal)
        ,isnull(e.ConfirmedVal, e2.ConfirmedVal)
        ,isnull(e.IncorrectVal, e2.IncorrectVal)
        ,2  
        ,e.ValidFrom
    from pEmployeeOrdersProcessed p (nolock)
   inner join tEmployeeOrdersProcessed t (nolock)
           on t.EmployeeID = p.EmployeeID
          and cast(t.InDateIime as date) between @DateBegin and @DateEnd

   outer apply (select top 1 * -- веса
                  from tEmployeeParameters for system_time all as e
                 where e.EmployeeID = p.EmployeeID
                   and dateadd(hh, 3, e.ValidFrom) <= t.InDateIime
                 order by e.ValidFrom desc
                ) as e

   outer apply (select top 1 * -- веса
                  from tEmployeeParameters as e
                 where e.EmployeeID = p.EmployeeID
                ) as e2

   where p.Spid = @@spid

  Update pEmployeeOrdersProcessed
     set Processed    = t.Processed
        ,ProcessedSum = t.ProcessedSum
    from pEmployeeOrdersProcessed p
   cross apply (select sum(t.Processed) as Processed,
                       sum(t.Processed * t.ProcessedSum) as ProcessedSum
                  from pEmployeeOrdersProcessed t (nolock)
                 where t.Spid = @@spid
                   and t.EmployeeID = p.EmployeeID
                   and t.Flag = 2
                 group by t.EmployeeID   
                   ) t
   where p.Spid = @@spid
     and p.Flag = 1

  select p.EmployeeID
        ,u.Name          EmployeeName
        ,p.Processed     -- Количество обработанных строк
        ,p.Incorrect     -- Количество неправильно обработанных строк
        ,p.Confirmed     -- Количество правильно обработанных строк

        ,p.ProcessedSum   -- Сумма вознаграждения с момента последнего сброса          
        ,p.ConfirmedSum  -- Сумма верно обработанных строк (подтвержденные детали)
        ,p.IncorrectSum  -- Сумма неверно обработанных строк

        ,p.ProcessedSumAll  -- Сумма вознаграждения за всю историю 
        ,p.Flag
    from pEmployeeOrdersProcessed p with (nolock index=ao1)
   inner join tUser u with (nolock index=ao1)
           on u.UserID = p.EmployeeID
   where p.Spid = @@Spid
     and p.Flag = 1
  
  exit_:

  return @r
GO
grant exec on EmployeeOrdersProcessedSelect to public
go
exec setOV 'EmployeeOrdersProcessedSelect', 'P', '20250207', '0'
go
  exec EmployeeOrdersProcessedSelect
  select p.*
    from pEmployeeOrdersProcessed p with (nolock index=ao1)
   where p.Spid = @@Spid


