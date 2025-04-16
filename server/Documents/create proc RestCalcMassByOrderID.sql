if OBJECT_ID('RestCalcMassByOrderID') is not null
    drop proc RestCalcMassByOrderID
/*
  RestCalcMassByOrderID - расчет баланса для клиента
*/
go
create proc RestCalcMassByOrderID
              @ID    ID readonly
as
  set nocount on
  declare @r        int = 0
         ,@ClientID numeric(18, 0)

-- Определение курсора для выборки всех идентификаторов клиентов из таблицы tClients
DECLARE ClientCursor CURSOR FOR
SELECT distinct 
       o.ClientID
  FROM @ID I
 inner join tOrders o with (nolock index = ao1)
         on o.OrderID = i.id

-- Открываем курсор и начинаем обработку каждой записи
OPEN ClientCursor
FETCH NEXT FROM ClientCursor INTO @ClientID
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Вызов процедуры RestCalc для текущего ClientID
    EXEC RestCalc @ClientID = @ClientID

    -- Переход к следующей записи в курсоре
    FETCH NEXT FROM ClientCursor INTO @ClientID
END

-- Закрываем и освобождаем курсор после завершения обработки
CLOSE ClientCursor
DEALLOCATE ClientCursor

exit_:
return @r
go
grant exec on RestCalcMassByOrderID to public
go
exec setOV 'RestCalcMassByOrderID', 'P', '20250416', '1'
go

