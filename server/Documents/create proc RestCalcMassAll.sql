if OBJECT_ID('RestCalcMassAll') is not null
    drop proc RestCalcMassAll
/*
  RestCalcMassAll - расчет баланса для клиента
*/
go
create proc RestCalcMassAll
              @ID    ID readonly
as
  set nocount on
  declare @r        int = 0
         ,@ClientID numeric(18, 0)

    -- Определение курсора для выборки всех идентификаторов клиентов из таблицы tClients
    DECLARE ClientCursor CURSOR FOR
    SELECT ClientID
    FROM tClients

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
grant exec on RestCalcMassAll to public
go
exec setOV 'RestCalcMassAll', 'P', '20250416', '1'
go

