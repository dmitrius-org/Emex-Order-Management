if OBJECT_ID('hOrders') is null
--  drop table hOrders
/* **********************************************************
hOrders - Заказы
********************************************************** */
create table hOrders
(
 OrderID                         numeric(18,0)  not null--
,ClientID                        numeric(18,0)  not null-- Клиент	
,OrderDate                       datetime       not null-- Дата заказа	
,OrderNum                        nvarchar(64)   -- Номер заказа	
,StatusID                        numeric(18,0)  -- Статус	
,isCancel                        bit            -- Отказ	
,isCancelToClient                bit            -- Отказ отправлен клиенту
,Manufacturer                    nvarchar(128)  -- Производитель	
,CustomerPriceLogo               nvarchar(32)   -- Наименование прайса клиента по которым заказываются детали	
,PriceLogo                       nvarchar(32)   -- Лого прайса клиента	
,DetailNumber                    nvarchar(32)   -- Номер детали	
,DetailName	                     nvarchar(512)  -- Название детали
,MakeLogo                        nvarchar(30)  
,DetailID                        nvarchar(32)   -- ID	
,Quantity                        int            -- Количество	
,Price                           money          -- Цена продажи	
,Amount                          money          -- Сумма продажи
,PricePurchase                   money          -- Цена закупки	с учетом скидки
,PricePurchaseOrg                money          -- Исходня цена закупки	
,AmountPurchase                  money          -- Сумма закупки
,PricePurchaseF                  money          -- Цена закупки факт	
,AmountPurchaseF                 money          -- Сумма закупки факт	
,WeightKG                        money          -- Вес Физический из прайса	
,VolumeKG                        money          -- Вес Объемный из прайса	
,MarginF                         money          -- Наценка факт	
,Profit                          money          -- Рентабельность	
,Income                          money          -- Доход	
,IncomePRC                       money          -- Доход %	
,ProfilesDeliveryID              int            -- tSupplierDeliveryProfiles.ProfilesDeliveryID - ИД профиля управления выгрузкой 

-- блок сроков доставки
,DeliveryPlanDateSupplier        datetime       -- Плановая дата поступления поставщику	
,DeliveryRestTermSupplier        int            -- Остаток срока до поступления поставщику	
,DeliveredDateToSupplier         datetime       -- Доставлена поставщику
,DeliveryDaysReserve             int            -- Дней запаса до вылета	
,DeliveryNextDate                datetime       -- Ближайшая дата вылета	
,DeliveryDateToCustomer          datetime       -- Дата поставки клиенту	
,DeliveryTermToCustomer          int            -- Срок поставки клиенту	
,DeliveryRestToCustomer          int            -- Остаток срока до поставки клиенту

,ReplacementMakeLogo             nvarchar(32)   -- Бренд замены
,ReplacementDetailNumber         nvarchar(32)   -- Номер замены
,ReplacementPrice                money          -- Цена замены	

,BasketId                        bigint         -- Идентификатор строки корзины
,EmexOrderID                     integer        -- Номер заказа	
,EmexQuantity                    int            -- Количество	
,CustomerSubId                   nvarchar(32)   -- идентификатор запчасти клиента
,Reference                       nvarchar(32)   -- Текстовая информация, позволяющая клиенту идентифицировать запчасть. Часть этой информации может быть распечатана в виде штрих-кода на стикере запчасти
,OrderDetailSubId                nvarchar(128)  -- OrderDetailSubId – уникальный идентификатор строки заказа в системе EmEx
,Warning                         nvarchar(128)  -- Предупреждение
,Comment                         nvarchar(512)  -- Комментарий
,Invoice                         nvarchar(64)   -- Инвойс, номер отправки
,OverPricing                     money          -- Превышение Цены

,DestinationLogo                 nvarchar(20)   -- Направление отгрузки
,PriceID	                     numeric(18, 0) -- Ид детали tPrice.PriceID

--                               
,Flag                            int            -- битовые признаки, смотри flags.md     
,ParentID                        numeric(18,0)  -- Родительский идентификатор заказа. Проставляется при дроблении заказа.
,FileDate                        datetime       -- Дата файла заказа
,ClientOrderNum                  int            -- Номер заказа	клиента
  
-- блок фин. показателей  
,Margin                          money          -- Наценка из прайса	
,Reliability	                 money          -- Вероятность поставки
,Discount                        money          -- Скидка поставщика на закупку товара
,Commission	                     money          -- Комиссия эквайера
,ExtraKurs	                     money          -- Наценка на курс
,CommissionAmount                money          -- Комиссия от продажи. Рассчитывается в момент создания заказа и не меняется
,Taxes                           money          -- Комиссия и налоги
,WeightKGAmount                  money          -- Стоимость кг физического веса
,VolumeKGAmount                  money          -- Стоимость кг объемного веса
--   
,UserID                          numeric(18,0) 
,inDatetime                      datetime      
,updDatetime                     datetime
,hInDatetime                     datetime
);
--go
--create unique index ao1 on hOrders([Version])
go
create index ao1 on hOrders(ParentID)
go
grant select on hOrders to public
go