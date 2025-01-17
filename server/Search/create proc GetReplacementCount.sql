if OBJECT_ID('GetReplacementCount') is not null
    drop FUNCTION GetReplacementCount	 
go
/* --------------------------------------------------------
  GetReplacementCount - количество замен
-------------------------------------------------------- */
CREATE FUNCTION GetReplacementCount()
RETURNS INT
AS
BEGIN
  DECLARE @ReplacementCount INT;
  DECLARE @RetVal INT;

  SELECT @ReplacementCount = 0;

  SELECT @ReplacementCount = COUNT(DISTINCT Make)
    FROM pFindByNumber WITH (NOLOCK INDEX=ao1)
   WHERE Spid = @@SPID;

  RETURN @ReplacementCount;
END; 
go
grant EXECUTE on GetReplacementCount to public
go
exec setOV 'GetReplacementCount', 'FN', '20241212', '1'
go
