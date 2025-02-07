-- Создание процедуры вставки данных в tEmployeeParameters
IF OBJECT_ID('EmployeeParametersInsert') IS NOT NULL
    DROP PROCEDURE EmployeeParametersInsert;
GO

CREATE PROCEDURE EmployeeParametersInsert
    @EmployeeID      NUMERIC(18,0),  
    @ProcessedVal    DECIMAL(10,2),  
    @IncorrectVal    DECIMAL(10,2),  
    @ConfirmedVal    DECIMAL(10,2)
AS
BEGIN
    DECLARE @r INT = 0;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Проверяем, существует ли запись
        IF EXISTS (SELECT 1 FROM tEmployeeParameters (NOLOCK) WHERE EmployeeID = @EmployeeID)
        BEGIN
            SET @r = 453-- Параметры существуют!
            ROLLBACK TRANSACTION;
            RETURN @r;
        END

        -- Вставка новой записи
        INSERT INTO tEmployeeParameters with (rowlock) 
               (EmployeeID, ProcessedVal, IncorrectVal, ConfirmedVal, UserID, InDateTime)
        VALUES (@EmployeeID, @ProcessedVal, @IncorrectVal, @ConfirmedVal, dbo.GetUserID(), Getdate());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Логирование ошибки
        SET @r = ERROR_NUMBER();
        INSERT INTO tRetMessage (RetCode, Message) VALUES (@r, ERROR_MESSAGE());

        RETURN @r;
    END CATCH;
END
GO

-- Разрешаем выполнение процедуры
GRANT EXEC ON EmployeeParametersInsert TO PUBLIC;
GO

-- Регистрация процедуры в системе
EXEC setOV 'EmployeeParametersInsert', 'P', '20250207', '0';
GO