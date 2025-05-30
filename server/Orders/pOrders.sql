drop table if exists pOrders
/*
pOrders - временная таблица для загрузки заказов
*/
go
create table pOrders
(
  Spid                  numeric(18,0)  default @@spid--  
 ,ClientID              numeric(18,0)  -- 
 ,Manufacturer          nvarchar(64)   --  2 Производитель	
 ,DetailNumber          nvarchar(32)   --  4 Номер детали
 ,Quantity              float          --  8 Количество
 ,DetailID              nvarchar(32)   --  5 ID
 ,DetailName	        nvarchar(512)  --  6 Название
 ,Price                 money          -- 12 Цена продажи	
 ,Amount                money          -- 13 Сумма продажи
 ,OrderNum              nvarchar(64)   -- Номер заказа	
 ,OrderDate             nvarchar(32)   -- Дата заказа	
 ,PriceNum              nvarchar(64)   -- Лого прайса клиента	
 ,FileDate              datetime       --
 ,OnlyThisBrand         nvarchar(30)   -- признак ТОЛЬКО ЭТОТ БРЕНД
 ,CustomerClientNum     varchar(128)   -- № Клиента
 ,CustomerClientSign    varchar(128)   -- Пометки Клиента
 ,CustomerOrder         varchar(128)   -- Заказ
)
go
create index ao1 on pOrders(Spid, ClientID)
go
grant all on pOrders to public
go
exec setOV 'pOrders', 'U', '20250408', '2'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pOrders', @desc = 'Временная таблица заказов. Используется для импорта заказов в базу данных'
