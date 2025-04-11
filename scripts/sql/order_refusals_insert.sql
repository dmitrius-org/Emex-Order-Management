INSERT INTO tOrderRefusals (FileName, Flag, UpdDateTime)
SELECT ?, 4, GETDATE();

DECLARE @FileName VARCHAR(60);
SELECT @FileName = ?;

INSERT INTO tUnloadRefusals (
    OperDate, FileName, OrderNum, MakeLogo, DetailNumber, Reference,
    DetailID, Quantity, PricePurchase, AmountPurchase, ClientID, ClientName
)
SELECT 
    OperDate, FileName, OrderNum, MakeLogo, DetailNumber, Reference,
    DetailID, Quantity, Price, Amount, ClientID, ClientName
FROM #UnloadRefusals (NOLOCK)
WHERE FileName = @FileName;

DELETE pAuditInsert 
FROM pAuditInsert (ROWLOCK) 
WHERE spid = @@SPID;

INSERT INTO pAuditInsert (
    Spid, ObjectID, ObjectTypeID, ActionID, Comment
)
SELECT 
    @@SPID, o.OrderID, 3, 5,
    'Выгрузка отказов: Количество=' + CONVERT(VARCHAR(50), p.Quantity) + ', файл: ' + @FileName
FROM #UnloadRefusals p (NOLOCK)
INNER JOIN tOrders o (NOLOCK)
    ON o.ClientID     = p.ClientID
   AND o.DetailNumber = p.DetailNumber 
   AND o.Reference    = p.Reference
   AND o.DetailID     = p.DetailID
WHERE p.FileName = @FileName;

EXEC MassAuditInsert;
