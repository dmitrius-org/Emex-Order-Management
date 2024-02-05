if OBJECT_ID('tProfilesCustomer') is null
--drop table tProfilesCustomer
/* **********************************************************
tProfilesCustomer - профили управления выгрузкой
********************************************************** */
create table tProfilesCustomer
(
 ProfilesCustomerID  int  identity  -- 
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
create unique index ao1 on tProfilesCustomer(ProfilesCustomerID)
go
create unique index ao2 on tProfilesCustomer(ClientID, Brief)
go
create index ao3 on tProfilesCustomer(UploadPriceName)
go
create index ao4 on tProfilesCustomer(ClientID)
go
grant all on tProfilesCustomer to public
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tProfilesCustomer', @desc = 'Профили управления выгрузкой прайсов'

--Alter Table tProfilesCustomer add  ClientID            numeric(18, 0)

--drop index ao2 on tProfilesCustomer
--create unique index ao2 on tProfilesCustomer(ClientID, Brief)

Select distinct s.CustomerPriceLogo ,t.ClientPriceLogo, s.ClientID
from tProfilesCustomer t
inner join tOrders s 
        on s.CustomerPriceLogo = t.ClientPriceLogo



Update t
   set  t.ClientID           = s.ClientID
       ,t.ProfilesDeliveryID = s.ProfilesDeliveryID
from tProfilesCustomer t
cross apply (select distinct  s.ClientID , s.CustomerPriceLogo,  p.ProfilesDeliveryID
                from tOrders s 
             inner join tClients c 
                      on c.ClientID = s.ClientID
             inner join tSupplierDeliveryProfiles p 
                     on p.SuppliersID = c.SuppliersID
               where s.CustomerPriceLogo = t.ClientPriceLogo) s



select * from tSupplierDeliveryProfiles




