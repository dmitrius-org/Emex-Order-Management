if OBJECT_ID('pBasket') is not null
  drop table pBasket
go
/* **********************************************************
tBasket - корзина деталей
********************************************************** */
  create table pBasket
  (
   ID                      numeric(18, 0) identity  
  ,Spid                    numeric(18, 0) 
  ,BasketID                numeric(18, 0) 
  ,ClientID                numeric(18, 0)
  ,Make                    nvarchar(10)   -- лого бренда детали
  ,MakeName                nvarchar(64)   -- название бренда
  ,DetailNum               nvarchar(64)   -- номер детали
  ,PartNameRus             nvarchar(256)  -- русское название детали
  ,PartNameEng             nvarchar(256)  -- английское название детали
  ,PriceLogo               nvarchar(64)   -- лого прайслиста
  ,GuaranteedDay           nvarchar(64)   -- гарантированный срок поставки детали
  ,OurDelivery             int            -- наш срок поставки, показываем клиенту
  ,Quantity                int            -- Количество
  ,Price                   money          -- цена детали в $ от emex
  ,PriceRub                money          -- цена детали в рублях
  ,Amount                  money          -- сумма 
  ,Reference               nvarchar(32)   -- reference
  ,WeightKG                money          -- вес детали в граммах
  ,VolumeKG                money          -- объемный вес
  ,DestinationLogo         nvarchar(10)   -- направление доставки
  ,PercentSupped           int            -- процент поставки

  ,Margin                  money          -- наценка
  ,Discount                money          -- Скидка
  ,Kurs                    money          -- курс
  ,ExtraKurs               money          -- 
  ,Commission              money          -- Комиссия эквайера
  ,Reliability             money          -- Вероятность поставки
  ,Fragile                 money 
  ,DeliveryTermToCustomer  int            -- Срок поставки клиенту
  ,Comment2                varchar(128)   -- Комментарий клиента
  ,ItemKey                 varchar(256) 
  ,ProfilesCustomerID      numeric(18, 0) 

  ,InDateTime              datetime default getdate()      -- Дата добавления детали в корзину
  ,Flag                    int
  ,Packing                 int            -- количество деталей в упаковке
     --
)

  grant all on pBasket to public;
  --
  create unique index ao1 on pBasket(ID);
  --
  create index ao2 on pBasket(ClientID);

go
exec setOV 'pBasket', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pBasket', @desc = 'Корзина'

select * from pBasket