if OBJECT_ID('RestCalcMassByClientID') is not null
    drop proc RestCalcMassByClientID
/*
  RestCalcMassByClientID - расчет баланса для клиента
*/
go
create proc RestCalcMassByClientID
              @ID    ID readonly
as
  set nocount on
  declare @r        int = 0
         ,@ClientID numeric(18, 0)

-- Определение курсора для выборки всех идентификаторов клиентов из таблицы tClients
DECLARE ClientCursor CURSOR FOR
SELECT ID
  FROM @ID

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
grant exec on RestCalcMassByClientID to public
go
exec setOV 'RestCalcMassByClientID', 'P', '20250416', '1'
go

