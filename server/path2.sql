insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1041, 1041, 'Api',  'TClientsT.actApi', 40, 1


alter table tClients add NotificationScript   varchar(256) -- Скрипт оповещения


alter table tOrders add
     CustomerClientNum               varchar(128)   -- № Клиента
    ,CustomerClientSign              varchar(128)   -- Пометки Клиента
    ,CustomerOrder                   varchar(128)   -- Заказ


alter table tOrderFileFormat add
   CustomerClientNum  int  -- № Клиента
  ,CustomerClientSign int  -- Пометки Клиента
  ,CustomerOrder      int  -- Заказ