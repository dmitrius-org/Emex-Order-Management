if OBJECT_ID('hMovement') is null
--drop table hMovement
/* **********************************************************
hMovement - 
********************************************************** */
begin
create table hMovement
(
 OrderID                 numeric(18,0)  --
,OrderNumber             numeric(18,0)  --
,Comment                 nvarchar(256)  -- �����������
,OrderDetailSubId        nvarchar(64)   -- ���������� ������������� ������ ������ � ������� EmEx
,DocumentDate            datetime       -- ���� ���������
,PriceOrdered            decimal(18,2)  -- �������� ������� ���� ������ (����� �������)
,PriceSale               decimal(18,2)  -- ���� ������� ������ �� �������
,MakeLogo                nvarchar(32)   -- ���� ������
,DetailNum               nvarchar(32)   -- ����� ������
,Quantity                int            -- ����������
,Condition               nvarchar(32)   -- ��� ������� ������
,Reference               nvarchar(64)   -- ����������, ����������� ������� ���������������� ��������. ����� ���� ���������� ����� ���� ����������� � ���� �����-���� �� ������� �������� 
,DetailNameRus           nvarchar(256)  --
,DetailNameEng           nvarchar(256)  --
,CustomerSubId           nvarchar(32)   -- ������������� �������� �������
,DestinationLogo         nvarchar(32)   -- ��� �������� (EMEW � ����, CNTE � ���������)
,PriceLogo               nvarchar(32)   -- ���� ����������
,ReplacementMakeLogo     nvarchar(128)  -- ����� ������
,ReplacementDetailNumber nvarchar(32)   -- ����� ������
,StatusId                int            --
,StateText               nvarchar(256)  --
,Flag                    int            --
,Tag                     int            --
,hInDatetime             datetime default GetDate()
)
end
go
grant all on hMovement to public
go
-- !! ������ �� ���������� !! 
create index ao1 on hMovement(OrderNumber, DetailNum, CustomerSubId, Reference, OrderDetailSubId)
go
-- �������� �������
exec dbo.sys_setTableDescription @table = 'tMovement', @desc = '�������� �� ������ ������.'