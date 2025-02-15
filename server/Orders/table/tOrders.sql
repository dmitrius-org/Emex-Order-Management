if OBJECT_ID('tOrders') is null
/* **********************************************************
tOrders - Заказы
********************************************************** */
begin
    create table tOrders
    (
     OrderID                         numeric(18,0)  identity --
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
    ,Comment2                        varchar(128)   -- Комментарий клиента
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
    ,ClientOrderNum                  int            -- Номер заказа клиента

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
    --   
    ,ID                              numeric(18,0)  -- техническое поле 
    ,UserID                          numeric(18,0) default dbo.GetUserID()
    ,inDatetime                      datetime      default GetDate()--
    ,updDatetime                     datetime      default GetDate()--
    );

    create unique index ao1 on tOrders(OrderID);

    create index ao2 on tOrders(ClientID, OrderNum);

    create index ao3 on tOrders(Invoice);

    create index ao4 on tOrders(Box);
end
go
grant select on tOrders to public
go
exec setOV 'tOrders', 'U', '20240101', '0'
go

-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tOrders', @desc = 'Таблица Заказы'

-- Описание полей
exec dbo.sys_setTableDescription 'tOrders', 'OrderID'                           ,'Уникальный идентификатор '
exec dbo.sys_setTableDescription 'tOrders', 'ClientID'                          ,'Идентификатор клиента tClients.ClientID'
exec dbo.sys_setTableDescription 'tOrders', 'OrderDate'                         ,'Дата заказа'

exec dbo.sys_setTableDescription 'tOrders', 'PriceLogo'                         ,'Лого прайса клиента'
exec dbo.sys_setTableDescription 'tOrders', 'CustomerPriceLogo'                 ,'Наименование прайса клиента по которым заказываются детали'
exec dbo.sys_setTableDescription 'tOrders', 'OrderNum'                          ,'Номер заказа'
exec dbo.sys_setTableDescription 'tOrders', 'StatusID'                          ,'Статус tStatus.StatusID'
exec dbo.sys_setTableDescription 'tOrders', 'isCancel'                          ,'Отказ'
exec dbo.sys_setTableDescription 'tOrders', 'isCancelToClient'                  ,'Отказ отправлен клиенту'
exec dbo.sys_setTableDescription 'tOrders', 'Manufacturer'                      ,'Производитель'
exec dbo.sys_setTableDescription 'tOrders', 'DetailNumber'                      ,'Номер детали'
exec dbo.sys_setTableDescription 'tOrders', 'DetailName'                        ,'Название детали'
exec dbo.sys_setTableDescription 'tOrders', 'DetailID'                          ,'ID'
exec dbo.sys_setTableDescription 'tOrders', 'Quantity'                          ,'Количество'
exec dbo.sys_setTableDescription 'tOrders', 'Price'                             ,'Цена продажи'
exec dbo.sys_setTableDescription 'tOrders', 'Amount'                            ,'Сумма продажи'
exec dbo.sys_setTableDescription 'tOrders', 'PricePurchase'                     ,'Цена закупки с учетом скидки'
exec dbo.sys_setTableDescription 'tOrders', 'PricePurchaseOrg'                  ,'Исходная цена закупки без учета скидки'
exec dbo.sys_setTableDescription 'tOrders', 'AmountPurchase'                    ,'Сумма закупки'
exec dbo.sys_setTableDescription 'tOrders', 'Discount'                          ,'Скидка поставщика на закупку товара'
exec dbo.sys_setTableDescription 'tOrders', 'PricePurchaseF'                    ,'Цена закупки факт'
exec dbo.sys_setTableDescription 'tOrders', 'AmountPurchaseF'                   ,'Сумма закупки факт'
exec dbo.sys_setTableDescription 'tOrders', 'WeightKG'                          ,'Вес Физический из прайса'
exec dbo.sys_setTableDescription 'tOrders', 'VolumeKG'                          ,'Вес Объемный из прайса'
exec dbo.sys_setTableDescription 'tOrders', 'Margin'                            ,'Наценка из прайса'
exec dbo.sys_setTableDescription 'tOrders', 'MarginF'                           ,'Наценка факт'
exec dbo.sys_setTableDescription 'tOrders', 'Profit'                            ,'Рентабельность'
exec dbo.sys_setTableDescription 'tOrders', 'Income'                            ,'Доход'

exec dbo.sys_setTableDescription 'tOrders', 'DeliveryPlanDateSupplier'          ,'Плановая дата поступления поставщику'
exec dbo.sys_setTableDescription 'tOrders', 'DeliveryRestTermSupplier'          ,'Остаток срока до поступления поставщику'
exec dbo.sys_setTableDescription 'tOrders', 'DeliveredDateToSupplier'           ,'Доставлена поставщику'
exec dbo.sys_setTableDescription 'tOrders', 'DeliveryTerm'                      ,'Срок доставки поставщику'

exec dbo.sys_setTableDescription 'tOrders', 'DeliveryDaysReserve'               ,'Дней запаса до вылета'
exec dbo.sys_setTableDescription 'tOrders', 'DeliveryNextDate'                  ,'Ближайшая дата вылета'
exec dbo.sys_setTableDescription 'tOrders', 'DeliveryNextDate2'                 ,'Ближайшая дата вылета, рассчитывается если прошол срок DeliveryNextDate'    
exec dbo.sys_setTableDescription 'tOrders', 'DeliveryDateToCustomer'            ,'Дата поставки клиенту'
exec dbo.sys_setTableDescription 'tOrders', 'DeliveryTermToCustomer'            ,'Срок поставки клиенту'
exec dbo.sys_setTableDescription 'tOrders', 'DeliveryRestToCustomer'            ,'Остаток срока до поставки клиенту'

exec dbo.sys_setTableDescription 'tOrders', 'ProfilesDeliveryID'                ,'tSupplierDeliveryProfiles.ProfilesDeliveryID - ИД профиля управления выгрузкой'
exec dbo.sys_setTableDescription 'tOrders', 'ReplacementMakeLogo'               ,'Бренд замены'
exec dbo.sys_setTableDescription 'tOrders', 'ReplacementDetailNumber'           ,'Номер замены'
exec dbo.sys_setTableDescription 'tOrders', 'ReplacementPrice'                  ,'Цена замены'
exec dbo.sys_setTableDescription 'tOrders', 'PriceID'                           ,'Ид детали tPrice.PriceID'
exec dbo.sys_setTableDescription 'tOrders', 'MakeLogo'                          ,'Лого бренда'
exec dbo.sys_setTableDescription 'tOrders', 'BasketId'                          ,'Идентификатор строки корзины в emexdwc.ae'
exec dbo.sys_setTableDescription 'tOrders', 'EmexOrderID'                       ,'Номер заказ в emexdwc.ae'
exec dbo.sys_setTableDescription 'tOrders', 'EmexQuantity'                      ,'Количество в emexdwc.ae'
exec dbo.sys_setTableDescription 'tOrders', 'OrderDetailSubId'                  ,'OrderDetailSubId – уникальный идентификатор строки заказа в системе EmEx'
exec dbo.sys_setTableDescription 'tOrders', 'OverPricing'                       ,'Превышение Цены'
exec dbo.sys_setTableDescription 'tOrders', 'Warning'                           ,'Предупреждение'
exec dbo.sys_setTableDescription 'tOrders', 'CustomerSubId'                     ,'Идентификатор запчасти клиента'
exec dbo.sys_setTableDescription 'tOrders', 'Reference'                         ,'Текстовая информация, позволяющая клиенту идентифицировать запчасть. Часть этой информации может быть распечатана в виде штрих-кода на стикере запчасти'
exec dbo.sys_setTableDescription 'tOrders', 'ParentID'                          ,'Родительский идентификатор заказа. Проставляется при дроблении заказа.'
exec dbo.sys_setTableDescription 'tOrders', 'Invoice'                           ,'Инвойс, номер отправки'
exec dbo.sys_setTableDescription 'tOrders', 'Box'                               ,'Коробка'
exec dbo.sys_setTableDescription 'tOrders', 'FileDate'                          ,'Дата файла'
exec dbo.sys_setTableDescription 'tOrders', 'DestinationLogo'                   ,'Направление отгрузки'
exec dbo.sys_setTableDescription 'tOrders', 'CommissionAmount'                  ,'Комиссия от продажи. Рассчитывается в момент создания заказа и не меняется'
exec dbo.sys_setTableDescription 'tOrders', 'ClientOrderNum'                    ,'Номер заказа клиента'
exec dbo.sys_setTableDescription 'tOrders', 'Comment'                           ,'Комментарий'
exec dbo.sys_setTableDescription 'tOrders', 'Reliability'                       ,'Вероятность поставки'
exec dbo.sys_setTableDescription 'tOrders', 'Commission'                        ,'Комиссия эквайера'
exec dbo.sys_setTableDescription 'tOrders', 'ExtraKurs'                         ,'Наценка на курс'
exec dbo.sys_setTableDescription 'tOrders', 'Taxes'                             ,'Комиссия и налоги'
exec dbo.sys_setTableDescription 'tOrders', 'WeightKGAmount'                    ,'Стоимость кг физического веса'
exec dbo.sys_setTableDescription 'tOrders', 'VolumeKGAmount'                    ,'Стоимость кг объемного веса'
exec dbo.sys_setTableDescription 'tOrders', 'PercentSupped'                     ,'Процент поставки'
