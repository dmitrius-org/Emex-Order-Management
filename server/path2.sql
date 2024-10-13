
--alter table tBasket

--add [ValidFrom]  DATETIME2 GENERATED ALWAYS AS ROW START /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidFrom DEFAULT SYSUTCDATETIME() 
--   ,[ValidTo]    DATETIME2 GENERATED ALWAYS AS ROW END   /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999')
   
--    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

--    ,CONSTRAINT PK_tBasket_BasketID PRIMARY KEY CLUSTERED (BasketID)
--go
--ALTER TABLE tBasket
--SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.tBasket));
--go



 update tNodes 
 set flag = Flag|4
 where Type=0
 and nodeid in (
 1	--New	�����
,2	--InChecked	���������
,3	--InBasket	� �������
,4	--InWork	� ������
,5	--Purchased	���������
,6	--ReceivedOnStock	�������� �� ����� � ���
,7	--ReadyToSend	������ � �������� �� ���
,8	--Send	�������� ��� �������� �� ��� � ��
--,9	--NotAvailable	��� � �������
--,10	--LessMinLot	������ ����������� ������
--,11	--PriceChange	��������� ����
--,12	--InCancel	��������
,22	--Preparation	���������������
--,24	--Received	������� � ������ � ��
--,26	--IssuedClient	������ �������
,32	--InShipment	�� ���� � ��
,37	--InShipmentWait	������� �������� �� ��� � ��
,38	--InShipmentBorderPassed	������ ������� ��
,39	--InShipmentDelivered	������ � ��
,36	--OnHold	�������������
)


