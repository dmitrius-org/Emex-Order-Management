if OBJECT_ID('tPrice') is null
--drop table tPrice
/* ********************************************************** 						
tPrice - таблица цен
********************************************************** */
begin
	create table tPrice
	(
	 PriceID           numeric(18,0)  identity --  
	,MakeLogo          varchar(30)    -- Зашифрованное название бренда
	,Brand             varchar(60)    -- Бренд
	,DetailNum	       varchar(40)    -- Номер детали 
	,DetailPrice       float          -- Цена
	,DetailName	       varchar(128)   -- Название было 255
	,PriceLogo         varchar(30)    -- Название прайса 
	,Quantity          float          -- Количество
	,PackQuantity      float          -- Количество в упаковке
	,Reliability       float          -- Вероятность поставки
	,WeightKG          float          -- Вес физический кг 
	,VolumeKG          float          -- Вес объемный кг  
	,MOSA              float          -- Цена MOSA
	,DetailNameF       varchar(512)   -- Наименование детали 
	,WeightKGF         float          -- Вес физический кг 
	,VolumeKGf         float          -- Вес объемный кг  
	,Restrictions      nvarchar(30)   -- Ограничения
	--
	,inDatetime        datetime default GetDate()      --
	,updDatetime       datetime default GetDate()      --
	);

	create unique index ao1 on tPrice(PriceID) include (DetailNameF, WeightKGF, VolumeKGf, Restrictions);

	create index ao2 on tPrice(DetailNum);

	create unique CLUSTERED  index ao3 on tPrice(PriceLogo, DetailNum, MakeLogo);

	grant all on tPrice to public;
end
go
exec setOV 'tPrice', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tPrice', @desc = 'таблица цен/прайсов'
-- Описание полей
exec dbo.sys_setTableDescription 'tPrice', 'PriceID'                 ,'Уникальный идентификатор '
