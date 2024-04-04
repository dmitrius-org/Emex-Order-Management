if OBJECT_ID('tBasket') is null
--drop table tBasket
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
  ,Price                   money          -- цена детали
  ,PriceRub                money          -- цена детали в рублях
  ,Amount                  money          -- сумма 
  ,Reference               nvarchar(32)   -- reference
  ,WeightKG                money          -- вес детали в граммах
  ,VolumeKG                money          -- объемный вес
  ,DestinationLogo         nvarchar(10)   -- направление доставки
  ,Margin                  money          -- наценка
  ,Discount                money          -- Скидка
  ,Kurs                    money          -- курс
  ,ExtraKurs               money          -- 
  ,Commission              money          -- Комиссия эквайера
  ,Reliability             money          -- Вероятность поставки
  );

  grant all on tBasket to public;
  --
  create unique index ao1 on tBasket(BasketID);
  --
  create unique index ao2 on tBasket(ClientID);
end
go
exec setOV 'tBasket', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tBasket', @desc = 'Корзина'