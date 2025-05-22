declare @UserID int = null

;WITH cte_begin AS (
    SELECT UserID,
           UserName, 
           LogMsgID,
           EventDate AS BeginTime,
           ROW_NUMBER() OVER (ORDER BY EventDate DESC) AS rn
      FROM tLogMsg (NOLOCK)
     WHERE 1=1--UserID = isnull(@UserID , UserID)
       AND Msg = 'Emex.SearchPart Begin'
),
cte_end AS (
    SELECT UserID,
           UserName,
           LogMsgID,
           EventDate AS EndTime,
           ROW_NUMBER() OVER (ORDER BY EventDate DESC) AS rn
      FROM tLogMsg (NOLOCK)
     WHERE 1=1--UserID = isnull(@UserID , UserID) 
       AND Msg = 'Emex.SearchPart End'
)

SELECT b.UserName,
       b.BeginTime,
       e.EndTime,
       DATEDIFF(MILLISECOND, b.BeginTime, e.EndTime) AS DurationMs,
       CONCAT(
            DATEDIFF(MINUTE, b.BeginTime, e.EndTime), 'm ',
            DATEPART(SECOND, DATEADD(MILLISECOND, DATEDIFF(MILLISECOND, b.BeginTime, e.EndTime), 0)), 's ',
            RIGHT('000' + CAST(DATEDIFF(MILLISECOND, b.BeginTime, e.EndTime) % 1000 AS VARCHAR), 3), 'ms'
        ) AS FormattedDuration
  FROM cte_begin b
  JOIN cte_end e 
    ON b.UserID = e.UserID
   and b.rn = e.rn
 ORDER BY b.UserName, b.BeginTime DESC
