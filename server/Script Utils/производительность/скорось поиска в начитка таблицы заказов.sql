DECLARE @UserID INT = NULL;

WITH cte_begin AS (
    SELECT 
        UserID,
        UserName, 
        LogMsgID,
        EventDate AS BeginTime,
        ROW_NUMBER() OVER (PARTITION BY UserID ORDER BY EventDate DESC) AS rn
    FROM tLogMsg (NOLOCK)
    WHERE Msg = 'TOrdersT.GridOpen Begin'
      AND (@UserID IS NULL OR UserID = @UserID)
),
cte_end AS (
    SELECT 
        UserID,
        UserName,
        LogMsgID,
        EventDate AS EndTime,
        ROW_NUMBER() OVER (PARTITION BY UserID ORDER BY EventDate DESC) AS rn
    FROM tLogMsg (NOLOCK)
    WHERE Msg = 'TOrdersT.GridOpen End'
      AND (@UserID IS NULL OR UserID = @UserID)
)

SELECT 
    b.UserName,
    b.BeginTime,
    e.EndTime,
    DATEDIFF(MILLISECOND, b.BeginTime, e.EndTime) AS DurationMs,
    CONCAT(
        DATEDIFF(SECOND, b.BeginTime, e.EndTime) / 60, 'm ',
        DATEDIFF(SECOND, b.BeginTime, e.EndTime) % 60, 's ',
        RIGHT('000' + CAST(DATEDIFF(MILLISECOND, b.BeginTime, e.EndTime) % 1000 AS VARCHAR), 3), 'ms'
    ) AS FormattedDuration
FROM cte_begin b
JOIN cte_end e 
  ON b.UserID = e.UserID
 AND b.rn = e.rn
WHERE e.EndTime >= b.BeginTime;



--DECLARE @UserID INT = NULL;

WITH cte_begin AS (
    SELECT 
        UserID,
        UserName, 
        LogMsgID,
        EventDate AS BeginTime,
        ROW_NUMBER() OVER (PARTITION BY UserID ORDER BY EventDate DESC) AS rn
    FROM tLogMsg (NOLOCK)
    WHERE Msg = 'TOrdersT.GridBeforeLoad Begin'
      AND (@UserID IS NULL OR UserID = @UserID)
),
cte_end AS (
    SELECT 
        UserID,
        UserName,
        LogMsgID,
        EventDate AS EndTime,
        ROW_NUMBER() OVER (PARTITION BY UserID ORDER BY EventDate DESC) AS rn
    FROM tLogMsg (NOLOCK)
    WHERE Msg = 'TOrdersT.GridAfterLoad Begin'
      AND (@UserID IS NULL OR UserID = @UserID)
)

SELECT 
    b.UserName,
    b.BeginTime,
    e.EndTime,
    DATEDIFF(MILLISECOND, b.BeginTime, e.EndTime) AS DurationMs,
    CONCAT(
        DATEDIFF(SECOND, b.BeginTime, e.EndTime) / 60, 'm ',
        DATEDIFF(SECOND, b.BeginTime, e.EndTime) % 60, 's ',
        RIGHT('000' + CAST(DATEDIFF(MILLISECOND, b.BeginTime, e.EndTime) % 1000 AS VARCHAR), 3), 'ms'
    ) AS FormattedDuration
FROM cte_begin b
JOIN cte_end e 
  ON b.UserID = e.UserID
 AND b.rn = e.rn
WHERE e.EndTime >= b.BeginTime;
