IF OBJECT_ID('EmployeeParametersUpdate') IS NOT NULL
    DROP PROCEDURE EmployeeParametersUpdate;
GO

CREATE PROCEDURE EmployeeParametersUpdate
                   @EmployeeID     NUMERIC(18,0),  
                   @ProcessedVal   DECIMAL(10,2),  
                   @IncorrectVal   DECIMAL(10,2),  
                   @ConfirmedVal   DECIMAL(10,2) 
AS
BEGIN
    DECLARE @r INT = 0;

    -- Проверка существования сотрудника в таблице
    IF NOT EXISTS (SELECT 1 FROM tEmployeeParameters WHERE EmployeeID = @EmployeeID)
    BEGIN
      EXEC EmployeeParametersInsert
            @EmployeeID      =@EmployeeID,  
            @ProcessedVal    =@ProcessedVal ,  
            @IncorrectVal    =@IncorrectVal,  
            @ConfirmedVal    =@ConfirmedVal 
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Обновление данных сотрудника
        UPDATE tEmployeeParameters
           SET ProcessedVal  = @ProcessedVal,
               IncorrectVal  = @IncorrectVal,
               ConfirmedVal  = @ConfirmedVal,
               UserID        = dbo.GetUserID()
         WHERE EmployeeID  = @EmployeeID;

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
GRANT EXEC ON EmployeeParametersUpdate TO PUBLIC;
GO

-- Регистрация процедуры в системе
EXEC setOV 'EmployeeParametersUpdate', 'P', '20250207', '0';
GO
