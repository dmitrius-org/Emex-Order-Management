if OBJECT_ID('tClientType') is null
/* **********************************************************
tClientType - Типы клиентов
********************************************************** */
begin
	create table tClientType
	(
	 ClientTypeID      numeric(18,0)  identity --  
	,Name	           nvarchar(256)           -- Название
	,Comment           nvarchar(512)           -- Описание 
	,Prepayment        bit                     -- Предоплата 
	,PrepaymentAmount  money                   -- Предоплата 
	,Margin            money                   -- Наценка
	,OrderNumMask      nvarchar(10)            -- Mаска для формирования номера заказа
	,IsActive          bit                     -- Активен
	--
	,Reliability         money                 -- Вероятность поставки (reliability, текстовое поле, по умолчанию установить значение "70"
	,Discount            money                 -- Скидка (discount, текстовое поле, по умолчанию установить значение "5"
											   -- Discount -- Скидка поставщика на закупку товара
	,Commission          money                 -- Комиссия эквайера (commission, текстовое поле, по умолчанию установить значение "3,5"
	--
	,UserID            numeric(18,0) default dbo.GetUserID()
	,inDatetime        datetime      default GetDate()      --
	,updDatetime       datetime      default GetDate()      --
	);

	create unique index ao1 on tClientType(ClientTypeID);

	create unique index ao2 on tClientType(Name);

	grant all on tClientType to public;
end
go
exec setOV 'tClientType', 'U', '20240101', '0';
go
exec dbo.sys_setTableDescription @table = 'tClientType', @desc = 'Типы клиентов'
go
/* 	75,00	9,00	2,00
insert tClientType (Name, Comment, Prepayment, PrepaymentAmount, Margin, IsActive, OrderNumMask, Reliability, Discount, Commission) select 'Физическое лицо', 'Периодические частные заказы', 1, 100, 50, 1, 'FL'       , 75.00, 9.00, 2.00
insert tClientType (Name, Comment, Prepayment, PrepaymentAmount, Margin, IsActive, OrderNumMask, Reliability, Discount, Commission) select 'Мелкий опт', 'Постоянные заказы до 1 млн. руб в месяц', 1, 50, 40, 1, 'WS'  , 75.00, 9.00, 2.00
insert tClientType (Name, Comment, Prepayment, PrepaymentAmount, Margin, IsActive, OrderNumMask, Reliability, Discount, Commission) select 'Крупный опт', 'Постоянные заказы от 1 млн. руб в месяц', 1, 50, 30, 1, 'WX' , 75.00, 9.00, 2.00
--*/
--select * from tClientType
