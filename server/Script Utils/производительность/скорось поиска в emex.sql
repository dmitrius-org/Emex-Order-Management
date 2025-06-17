declare @UserID int = null

;WITH cte_begin AS (
    SELECT UserID,
           UserName, 
           LogMsgID,
           EventDate AS BeginTime,
           ROW_NUMBER() OVER (ORDER BY EventDate DESC) AS rn
      FROM tLogMsg (NOLOCK)
     WHERE 1=1--UserID = isnull(@UserID , UserID)
       AND Msg = 'TEmex.FillFindByNumber Begin'
),
cte_end AS (
    SELECT UserID,
           UserName,
           LogMsgID,
           EventDate AS EndTime,
           ROW_NUMBER() OVER (ORDER BY EventDate DESC) AS rn
      FROM tLogMsg (NOLOCK)
     WHERE 1=1--UserID = isnull(@UserID , UserID) 
       AND Msg = 'TEmex.FillFindByNumber End'
)

SELECT b.UserName,
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
   and b.rn = e.rn
 ORDER BY b.UserName, b.BeginTime DESC
