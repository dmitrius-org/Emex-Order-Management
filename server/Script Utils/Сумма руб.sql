select * from tAudit where Comment like '%����� ���%'



UPDATE tAudit
SET Comment = 
    CASE 
        WHEN CHARINDEX('����� ���.', Comment) > 0 
        THEN LEFT(Comment, CHARINDEX('����� ���.', Comment) - 1)
        ELSE Comment
    END
WHERE CHARINDEX('����� ���.', Comment) > 0