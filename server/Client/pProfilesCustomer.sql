if OBJECT_ID('pProfilesCustomer') is not null
  drop table pProfilesCustomer
go
/* **********************************************************
pProfilesCustomer - профили управления выгрузкой
********************************************************** */
create table pProfilesCustomer
(
 ID                  numeric(18, 0) identity  -- 
,Spid                int
,ProfilesCustomerID  int            -- 
,ClientID            numeric(18, 0) -- Клиент   
,Brief               varchar(60)    --
,Margin              money          -- Наценка в процентах (margin, текстовое поле, по умолчанию установить значение "25" 
,Reliability         money          -- Вероятность поставки (reliability, текстовое поле, по умолчанию установить значение "70" 
,UploadFolder        varchar(255)   -- Каталог для сохранения прайс-файлов
,UploadPriceName     varchar(255)   -- 
,UploadFileName      varchar(255)   -- 
,isActive            bit

,ProfilesDeliveryID  int   

,ClientPriceLogo     nvarchar(32)   -- Наименование прайса клиента по которым заказываются детали
                                    -- по данному полю выполняем сопоставление с tOrders.CustomerPriceLogo
,UploadDelimiterID   int            -- разделитель 
,DeliveryTermCustomer    int            -- Срок поставки клиенту	  
)
go
create unique index ao1 on pProfilesCustomer(ID)
go
create unique index ao2 on pProfilesCustomer(Spid, ClientID, Brief)
go
grant all on pProfilesCustomer to public
go
exec setOV 'pProfilesCustomer', 'U', '20240906', '2'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pProfilesCustomer', @desc = 'Профили управления выгрузкой прайсов'