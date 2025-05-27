-- Объявление переменных для курсора
DECLARE @OperDate datetime;

-- Объявление курсора для перебора уникальных дат из OperDate
DECLARE OperDateCursor CURSOR FOR
SELECT DISTINCT 
       OperDate
 FROM tUnloadRefusals2
order by OperDate 

-- Открытие курсора
OPEN OperDateCursor;

-- Получение первой строки из курсора
FETCH NEXT FROM OperDateCursor INTO @OperDate;

-- Цикл по всем датам из курсора
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Использование MERGE для обновления и вставки данных для текущей даты
    MERGE INTO tUnloadRefusals t
    USING (
      SELECT *
        FROM (
            SELECT *,
                   ROW_NUMBER() OVER (
                       PARTITION BY MakeLogo, DetailNumber, Reference, DetailID
                       ORDER BY InDateTime -- или другой критерий сортировки, если нужно
                   ) AS RowNum
             FROM tUnloadRefusals2
            WHERE OperDate = @OperDate
             --and OrderNum = 'BRA0000000022' 
        ) AS FilteredData
        WHERE RowNum = 1
          
    ) s
    ON (
          t.MakeLogo     = s.MakeLogo
      AND t.DetailNumber = s.DetailNumber
      AND t.Reference    = s.Reference
      AND t.DetailID     = s.DetailID
    )

    -- Обновление существующих записей
    WHEN MATCHED THEN
        UPDATE SET
            t.FileName = s.FileName,
            --t.ClientID = s.ClientID,
            --t.ClientName = s.ClientName,
            --t.OrderNum = s.OrderNum,
            t.Quantity = s.Quantity,
            --t.PricePurchase = s.PricePurchase,
            --t.AmountPurchase = s.AmountPurchase,
            --t.Flag = s.Flag
            t.OperDate = s.OperDate

    -- Вставка новых записей
    WHEN NOT MATCHED BY TARGET THEN
        INSERT (
            OperDate,
            FileName,
            ClientID,
            ClientName,
            OrderNum,
            MakeLogo,
            DetailNumber,
            Reference,
            DetailID,
            Quantity,
            PricePurchase,
            AmountPurchase,
            Flag
        )
        VALUES (
            s.OperDate,
            s.FileName,
            s.ClientID,
            s.ClientName,
            s.OrderNum,
            s.MakeLogo,
            s.DetailNumber,
            s.Reference,
            s.DetailID,
            s.Quantity,
            s.PricePurchase,
            s.AmountPurchase,
            s.Flag
        );

    -- Получение следующей строки из курсора
    FETCH NEXT FROM OperDateCursor INTO @OperDate;
END

-- Закрытие курсора
CLOSE OperDateCursor;

-- Освобождение ресурсов курсора
DEALLOCATE OperDateCursor;