drop table if exists pFindByNumber
go
/* **********************************************************
pFindByNumber - 
********************************************************** */
create table pFindByNumber
(
 ID                      numeric(18, 0) identity
,Spid                    numeric(18,0)  default @@spid
,ClientID                numeric(18, 0)
,DestinationLogo	     nvarchar(10)
,Available               nvarchar(128)  -- наличие детали на складе
,bitOldNum               bit            -- признак УСТАРЕВШИЙ НОМЕР
,PercentSupped           int            -- процент поставки
,PriceId                 int            -- идентификатор прайслиста
,Region                  nvarchar(256)  -- регион доставки детали
,Delivery                int            -- срок поставки
,Make                    nvarchar(10)   -- лого бренда детали
,DetailNum               nvarchar(64)   -- номер детали
,PriceLogo               nvarchar(64)   -- лого прайслиста
,Price                   money          -- цена детали, показаваемая на сайте
,PriceRub                money          -- цена детали в рублях
,PartNameRus             nvarchar(256)  -- русское название детали
,PartNameEng             nvarchar(256)  -- английское название детали
,WeightGr                money          -- вес детали в граммах
,MakeName                nvarchar(64)   -- название бренда
,Packing                 int            -- количество деталей в упаковке
,bitECO                  bit            
,bitWeightMeasured       bit            
,VolumeAdd               money          -- наценка объем (объемный вес)
,GuaranteedDay           nvarchar(64)   -- гарантированный срок поставки детали

,OurDelivery             int            -- наш срок поставки
,OurDeliverySTR          nvarchar(256)  -- наш срок поставки стройкой, показываем клиенту
,Margin		             money
,Discount	             money          -- Скидка
,Kurs		             money
,ExtraKurs               money
,Commission	             money          -- Комиссия эквайера
,Reliability             money          -- Вероятность поставки
)
go
grant all on pFindByNumber to public
go
create index ao1 on pFindByNumber(Spid, ID)
go
create index ao2 on pFindByNumber(Spid, DestinationLogo)
go
exec setOV 'pFindByNumber', 'U', '20240529', '2'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pFindByNumber', @desc = 'Результат поиска детали'
