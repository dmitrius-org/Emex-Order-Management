if OBJECT_ID('tOrderFileFormat') is null
begin
/* **********************************************************
tOrderFileFormat - Формат файла с заказом
********************************************************** */
  create table tOrderFileFormat
  (
   OrderFileFormatID  numeric(18,0) identity -- 
  ,ClientID           numeric(18,0) not null
  ,Folder             nvarchar(512) -- Папка	
  ,Firstline          int           -- Первая строка	
  ,Manufacturer       int           -- Столбец Производитель	
  ,DetailNumber       int           -- Столбец Номер детали	
  ,Quantity           int           -- Столбец Количество	
  ,DetailID           int           -- Столбец ID	
  ,DetailName         int           -- Столбец Наименование детали	
  ,Price              int           -- Столбец Цена	
  ,Amount             int           -- Столбец Сумма	
  ,OrderNum           nvarchar(32)  -- Ячейка Заказ	
  ,OrderDate          nvarchar(32)  -- Ячейка Дата Заказа	
  ,PriceNum           nvarchar(32)  -- Прайс	
  ,Commission         money         -- Комиссия
  ,IsActive           bit
  ,CustomerSubID      varchar(32)   -- Правило формирование поля CustomerSubID
  ,Reference          varchar(64)   -- Правило формирование поля Reference 
  ,OnlyThisBrand      int           -- Признак ТОЛЬКО ЭТОТ БРЕНД
  --
  ,inDatetime         datetime default GetDate()      --
  ,updDatetime        datetime default GetDate()      --
  
   primary key (OrderFileFormatID)
  );
  
  create index ao1 on tOrderFileFormat(ClientID);
end
go
grant all on tOrderFileFormat to public
go
exec setOV 'tOrderFileFormat', 'U', '20240101', '0'
go
exec dbo.sys_setTableDescription @table = 'tOrderFileFormat', @desc = 'Формат файла с заказом'
go
