insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1041, 1041, 'Api',  'TClientsT.actApi', 40, 1


alter table tClients add NotificationScript   varchar(256) -- ������ ����������


alter table tOrders add
     CustomerClientNum               varchar(128)   -- � �������
    ,CustomerClientSign              varchar(128)   -- ������� �������
    ,CustomerOrder                   varchar(128)   -- �����


alter table tOrderFileFormat add
   CustomerClientNum  int  -- � �������
  ,CustomerClientSign int  -- ������� �������
  ,CustomerOrder      int  -- �����