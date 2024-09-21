
--alter table tBasket

--add [ValidFrom]  DATETIME2 GENERATED ALWAYS AS ROW START /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidFrom DEFAULT SYSUTCDATETIME() 
--   ,[ValidTo]    DATETIME2 GENERATED ALWAYS AS ROW END   /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999')
   
--    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

--    ,CONSTRAINT PK_tBasket_BasketID PRIMARY KEY CLUSTERED (BasketID)
--go
--ALTER TABLE tBasket
--SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.tBasket));
--go


--alter table tPartsStatistics add WorkOrderCount           int            -- ������� ��������
--go


--alter table tPartsStatistics add WorkOrderUniqueCount           int            -- ������� ��������


--    ,WorkOrderCount        int        -- ���������� ���������� �������, ������ � ������ 
--    ,WorkOrderUniqueCount  int        -- ���������� ���������� �������, ������ � ������

--alter table torders  add DeliveryDaysReserve2            int            -- ���� ������ �� ������, �������������� ���� ������ ���� DeliveryNextDate		
--go  


--alter table tProfilesCustomer    add DeliveryTermCustomer            int            -- ���� ������ �� ������, �������������� ���� ������ ���� DeliveryNextDate
--go  


--alter table    tShipments add TransporterNumber nvarchar(64)
--go  
--alter table    tShipments add     StatusID                        int
--go
--alter table    tShipments add  ReceiptDate2                    datetime 
--go
--drop index ao1 on tNodes
--go
--alter table tNodes alter column brief nvarchar(32)
--go
--alter table tNodes alter column name nvarchar(64)
--go
--create index ao1 on tNodes(NodeID, Type) INCLUDE (Brief, Name);
--go
--alter table tNodes alter column EName nvarchar(64)
--go


--alter table    tSupplierDeliveryProfiles add Brief nvarchar(10)
--go
--exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'Brief'                 ,'�������� �����������' 
--go
--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1014, 1014, '������� ����� �����',  'TShipmentsT.actSetTransporterNumber', 63, 1
--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1015, 1015, '�������� ���� ��������',  'TShipmentsT.actSetReceiptDate', 63, 1
--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1016, 1016, '�������',  'TShipmentsT.actSetReceivedStatus', 63, 1
--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1017, 1017, '������� ��� �� ������ �����������',  'TShipmentsT.actSetTransporterData', 63, 1

--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1018, 1018, '��������',  'TShipmentsT.actProtocol', 63, 1



--alter table tNodes add N int

alter table tNodes add SearchID               int

alter table tNodes add SearchBrief            nvarchar(32)

alter table tNodes add SearchName             nvarchar(64)

select * from tNodes

alter table tClients add StatusRequiringPayment varchar(256)


