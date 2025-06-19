select * from tAudit where Comment like '%Сумма руб%'



UPDATE tAudit
SET Comment = 
    CASE 
        WHEN CHARINDEX('Сумма руб.', Comment) > 0 
        THEN LEFT(Comment, CHARINDEX('Сумма руб.', Comment) - 1)
        ELSE Comment
    END
WHERE CHARINDEX('Сумма руб.', Comment) > 0