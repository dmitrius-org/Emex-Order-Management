if OBJECT_ID('tBasket') is null
/*
  ALTER TABLE tBasket SET ( SYSTEM_VERSIONING = OFF )
  --drop table tBasket
  DROP TABLE History.tBasket
*/
begin
/* **********************************************************
tBasket - корзина деталей
********************************************************** */
  create table tBasket
  (
   BasketID                numeric(18, 0) identity
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
  ,ProfilesCustomerID	   numeric(18, 0)
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
  
  ,InDateTime              datetime default getdate()      -- Дата добавления детали в корзину
  ,Flag                    int
  ,Packing                 int            -- количество деталей в упаковке
  ,ItemKey	               varchar(256)
     --
  ,[ValidFrom]          DATETIME2 GENERATED ALWAYS AS ROW START
  ,[ValidTo]            DATETIME2 GENERATED ALWAYS AS ROW END

  ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

  ,CONSTRAINT PK_tBasket_BasketID PRIMARY KEY CLUSTERED (BasketID)
)
  WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tBasket));

  grant all on tBasket to public;
  --
  create unique index ao1 on tBasket(BasketID);
  --
  create index ao2 on tBasket(ClientID);
end
go
exec setOV 'tBasket', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tBasket', @desc = 'Корзина'

select * from tBasket