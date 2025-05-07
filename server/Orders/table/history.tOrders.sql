if OBJECT_ID('History.tOrders') is null
/* **********************************************************
tOrders - Заказы

drop table History.tOrders
********************************************************** */
begin
    create table History.tOrders
    (
     OrderID                         numeric(18,0)  --
    ,ClientID                        numeric(18,0)  not null -- Клиент
    ,SuppliersID                     numeric(18,0)  -- Поставщик tSuppliers.SuppliersID
    ,OrderDate                       datetime       not null -- Дата заказа
    ,OrderNum                        nvarchar(32)   -- Номер заказа
    ,StatusID                        numeric(18,0)  -- Статус
    ,isCancel                        bit            -- Отказ
    ,isCancelToClient                bit            -- Отказ отправлен клиенту
    ,Manufacturer                    nvarchar(64)   -- Производитель
    ,CustomerPriceLogo               nvarchar(10)   -- Наименование прайса клиента по которым заказываются детали
    ,PriceLogoOrg                    nvarchar(32)   -- Лого прайса клиента/правйс при добавлении
    ,PriceLogo                       nvarchar(32)   -- Лого прайса клиента
    ,DetailNumber                    nvarchar(32)   -- Номер детали
    ,DetailName                      nvarchar(512)  -- Название детали
    ,MakeLogo                        nvarchar(32)  
    ,DetailID                        nvarchar(32)   -- ID    
    ,Quantity                        int            -- Количество
    ,QuantityOrg                     int            -- Количество
    ,Price                           money          -- Цена продажи
    ,Amount                          money          -- Сумма продажи
    ,PricePurchase                   money          -- Цена закупки с учетом скидки
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
    ,DeliveryTerm                    int            -- Срок доставки поставщику

    ,DeliveryDaysReserve             int            -- Дней запаса до вылета
    ,DeliveryDaysReserve2            int            -- Дней запаса до вылета, рассчитывается если прошел срок DeliveryNextDate
    ,DeliveryNextDate                datetime       -- Ближайшая дата вылета
    ,DeliveryNextDate2               datetime       -- Ближайшая дата вылета, рассчитывается если прошел срок DeliveryNextDate
    ,DeliveryDateToCustomer          datetime       -- Дата поставки клиенту
    ,DeliveryTermToCustomer          int            -- Срок поставки клиенту
    ,DeliveryRestToCustomer          int            -- Остаток срока до поставки клиенту

    ,DateDeparture                   datetime       -- Добавить дату вылета 
    ,DaysInWork                      int            -- Дней в работе
    ,DateInWork                      datetime       -- Дата перехода в работу

    ,ReplacementMakeLogo             nvarchar(32)   -- Бренд замены
    ,ReplacementDetailNumber         nvarchar(32)   -- Номер замены
    ,ReplacementPrice                money          -- Цена замены

    ,BasketId                        bigint         -- Идентификатор строки корзины
    ,EmexOrderID                     integer        -- Номер заказа
    ,EmexQuantity                    int            -- Количество
    ,CustomerSubId                   nvarchar(32)   -- идентификатор запчасти клиента
    ,Reference                       nvarchar(32)   -- Текстовая информация, позволяющая клиенту идентифицировать запчасть. Часть этой информации может быть распечатана в виде штрих-кода на стикере запчасти
    ,OrderDetailSubId                nvarchar(32)   -- OrderDetailSubId – уникальный идентификатор строки заказа в системе EmEx
    ,Warning                         nvarchar(128)  -- Предупреждение
    ,Comment                         nvarchar(512)  -- Комментарий
    ,Comment2                        varchar(128)   -- Комментарий клиента к позиции
    ,Comment3                        varchar(512)   -- Комментарий клиента к заказу
    ,Invoice                         nvarchar(64)   -- Инвойс, номер отправки
    ,Box                             numeric(18, 0) -- Коробка
    ,OverPricing                     money          -- Превышение Цены

    ,DestinationLogo                 nvarchar(20)   -- Направление отгрузки
    ,DestinationName                 nvarchar(60)   -- Направление отгрузки
    ,PriceID                         numeric(18, 0) -- Ид детали tPrice.PriceID
    --                               
    ,Flag                            int            -- битовые признаки, смотри flags.md
    ,ParentID                        numeric(18,0)  -- Родительский идентификатор заказа. Проставляется при дроблении заказа.
    ,FileDate                        datetime       -- Дата файла заказа
    

    -- блок фин. показателей  
    ,Margin                          money          -- Наценка из прайса
    ,Reliability                     money          -- Вероятность поставки
    ,Discount                        money          -- Скидка поставщика на закупку товара
    ,Commission                      money          -- Комиссия эквайера
    ,ExtraKurs                       money          -- Наценка на курс
    ,Kurs                            money
    ,CommissionAmount                money          -- Комиссия от продажи. Рассчитывается в момент создания заказа и не меняется
    ,Taxes                           money          -- Комиссия и налоги
    ,WeightKGAmount                  money          -- Стоимость кг физического веса tSupplierDeliveryProfiles.WeightKG
    ,VolumeKGAmount                  money          -- Стоимость кг объемного веса   tSupplierDeliveryProfiles.VolumeKG
    ,Fragile                         float          -- Наценка за страховку tSupplierDeliveryProfiles.Fragile
    ,PercentSupped                   int            -- процент поставки 
    ,ItemKey	                     varchar(256)
    ,DeliveryTermFromSupplier        int            -- Срок доставки от поставщик
    ,DeliveryTermFromSupplier2       int            -- Срок доставки от поставщик после изменения
    ,ProfilesCustomerID              numeric(18,0)
    -- дополнительные признаки из заказа клиента
    ,CustomerClientNum               varchar(128)   -- № Клиента
    ,CustomerClientSign              varchar(128)   -- Пометки Клиента
    ,CustomerOrder                   varchar(128)   -- Заказ
    -- апи
    ,ClientOrderNum                  int            -- Номер заказа клиента 

     --   
    ,ID                              numeric(18,0)  -- техническое поле 
    ,UserID                          numeric(18,0) default dbo.GetUserID()
    ,inDatetime                      datetime      default GetDate()--
    ,updDatetime                     datetime      default GetDate()--
    );

    create index ao1 on History.tOrders(OrderID);

    --create index ao2 on History.tOrders(ClientID, OrderNum);

    --create index ao3 on History.tOrders(Invoice);

    --create index ao4 on History.tOrders(Box);
end
go
grant select on History.tOrders to public
go
exec setOV 'tOrders', 'U', '20250506', '1', 'History'
go
