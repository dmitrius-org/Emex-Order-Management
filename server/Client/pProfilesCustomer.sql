if OBJECT_ID('pProfilesCustomer') is not null
  drop table pProfilesCustomer
/* **********************************************************
pProfilesCustomer - профили управления выгрузкой
********************************************************** */
create table pProfilesCustomer
(
 ID                  numeric(18, 0) identity  -- 
,Spid                int
,ProfilesCustomerID  int    -- 
,ClientID            numeric(18, 0) -- Клиент   
,Brief               varchar(60)    --
,ProfilesDeliveryID  int   

,Margin              money          -- Наценка в процентах (margin, текстовое поле, по умолчанию установить значение "25", 😵
,Reliability         money          -- Вероятность поставки (reliability, текстовое поле, по умолчанию установить значение "70", 😵
,Discount            money          -- Скидка (discount, текстовое поле, по умолчанию установить значение "5", 😵-- Discount -- Скидка поставщика на закупку товара
,Commission          money          -- Комиссия эквайера (commission, текстовое поле, по умолчанию установить значение "3,5", 😵
,ExtraKurs           money

,isMyDelivery        bit            -- Поле для галочки "Считать с учетом доставки"
,isIgnore            bit            -- Поле для галочки "Игнорировать детали без веса"
,UploadFolder        varchar(255)   -- Каталог для сохранения прайс-файлов
,UploadPriceName     varchar(255)   -- 
,UploadFileName      varchar(255)   -- 
,isActive            bit

,ClientPriceLogo     nvarchar(32)   -- Наименование прайса клиента по которым заказываются детали
                                    -- по данному полю вымолняем сопоставление с tOrders.CustomerPriceLogo
,UploadDelimiterID   int            -- разделитель 
)
go
create unique index ao1 on pProfilesCustomer(ID)
go
create unique index ao2 on pProfilesCustomer(Spid, ClientID, Brief)
go
grant all on pProfilesCustomer to public
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pProfilesCustomer', @desc = 'Профили управления выгрузкой прайсов'