if OBJECT_ID('tPrice') is null
--drop table tPrice
/* ********************************************************** 						
tPrice - таблица цен
********************************************************** */
begin
	create table tPrice
	(
	 PriceID           numeric(18,0)  identity -- 
    ,PartID            numeric(18,0)  not null
	,PriceLogo         varchar(30)    not null -- Название прайса 
	,Quantity          int            -- Количество
	,PackQuantity      int            -- Количество в упаковке
	,Reliability       float          -- Вероятность поставки
    ,DetailPrice       float
	,MOSA              float          -- Цена MOSA
    ,isDelete          bit
	--
	,InDateTime        datetime default GetDate()      --
	,UpDateTime        datetime default GetDate()      --

    ,CONSTRAINT PK_tPrice_ID PRIMARY KEY CLUSTERED (PriceID)
	);

    create index ao1 on tPrice(PartID, PriceLogo);

	create index ao2 on tPrice(PriceLogo);

--	create unique CLUSTERED  index ao3 on tPrice(PriceLogo, DetailNum, MakeLogo);

	grant all on tPrice to public;
end
go
exec setOV 'tPrice', 'U', '20250531', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tPrice', @desc = 'таблица цен/прайсов'
-- Описание полей
exec dbo.sys_setTableDescription 'tPrice', 'PriceID'                 ,'Уникальный идентификатор '
