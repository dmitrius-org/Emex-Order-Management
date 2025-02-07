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

  delete pEmployeeOrdersProcessed
    from pEmployeeOrdersProcessed with (rowlock index=ao1)
   where Spid = @@Spid

  insert pEmployeeOrdersProcessed with (rowlock)
        (Spid, EmployeeID)
  SELECT distinct 
         @@Spid
        ,u.UserID
    FROM tUser u WITH (NOLOCK INDEX = ao1)
    LEFT JOIN @Employees e
           ON e.ID= u.UserID

   WHERE 1=1--o.OrderDate BETWEEN @DateBegin AND @DateEnd
    -- AND o.isCancel = 1
     AND (NOT EXISTS (SELECT 1 FROM @Employees) OR e.ID IS NOT NULL)




  select p.EmployeeID
        ,u.Name          EmployeeName
        ,p.Processed     -- Количество обработанных строк
        ,p.Incorrect     -- Количество неправильно обработанных строк
        ,p.Confirmed     -- Количество обработанных строк
        ,p.AmountSum     -- Сумма вознаграждения с момента последнего сброса  
        ,p.AmountSumAll  -- Сумма вознаграждения за всю историю 
        ,p.ProcessedSum  -- Сумма верно обработанных строк 
        ,p.IncorrectSum  -- Сумма неверно обработанных строк
    from pEmployeeOrdersProcessed p with (nolock index=ao1)
   inner join tUser u with (nolock index=ao1)
           on u.UserID = p.EmployeeID
   where p.Spid = @@Spid
  
  exit_:

  return @r
GO
grant exec on EmployeeOrdersProcessedSelect to public
go
exec setOV 'EmployeeOrdersProcessedSelect', 'P', '20250207', '0'
go

exec EmployeeOrdersProcessedSelect