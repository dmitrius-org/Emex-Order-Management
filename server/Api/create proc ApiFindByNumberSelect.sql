if OBJECT_ID('ApiFindByNumberSelect', 'P') is not null
    drop proc ApiFindByNumberSelect	 
go
/* --------------------------------------------------------
  ApiFindByNumberSelect - 

-------------------------------------------------------- */
create proc ApiFindByNumberSelect   
as
set nocount on;

declare @RetVal int  = 0

SELECT 
    MakeName,                      -- ��� �������������
    DetailNum,                     -- ��� ������
    PartNameRus,                   -- �������� ������
    CASE 
        WHEN Available=-1 THEN -10 --��� �����
        WHEN Available IS NULL THEN ''
        ELSE CAST(Available as VARCHAR)
    END AS Available,              -- ������� �� ������
    Packing,                        -- ����������� ������ ��� ������ (�������������)
    OurDelivery,                    -- ���� ��������
    PriceRub,                       -- ����
    CAST(0 AS BIT) as ReturnSign,   -- ������� �������� (�������������)    
    PriceLogo + '-' + cast(ProfilesCustomerID as varchar) as SupplierID       -- ������������� ���������� (ID ������)
    
FROM vFindByNumber

exit_:
return @RetVal    
go
grant exec on ApiFindByNumberSelect to public
go
exec setOV 'ApiFindByNumberSelect', 'P', '20250303', '0'
go
 