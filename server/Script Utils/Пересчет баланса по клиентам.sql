DECLARE @ClientID numeric(18, 0)

-- ����������� ������� ��� ������� ���� ��������������� �������� �� ������� tClients
DECLARE ClientCursor CURSOR FOR
SELECT ClientID
FROM tClients

-- ��������� ������ � �������� ��������� ������ ������
OPEN ClientCursor

FETCH NEXT FROM ClientCursor INTO @ClientID

WHILE @@FETCH_STATUS = 0
BEGIN
    -- ����� ��������� RestCalc ��� �������� ClientID
    EXEC RestCalc @ClientID = @ClientID

    -- ������� � ��������� ������ � �������
    FETCH NEXT FROM ClientCursor INTO @ClientID
END

-- ��������� � ����������� ������ ����� ���������� ���������
CLOSE ClientCursor
DEALLOCATE ClientCursor
