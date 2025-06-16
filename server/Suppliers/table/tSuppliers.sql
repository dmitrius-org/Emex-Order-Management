if OBJECT_ID('tSuppliers') is null
/* **********************************************************
tSuppliers - Поставщики
********************************************************** */
begin
	create table tSuppliers
	(
	 SuppliersID       numeric(18,0)  identity --  
	,Brief             nvarchar(256)  not null --
	,Name	           nvarchar(512)  null  -- 
	,PriceName         nvarchar(32)   null  -- 

    ,ApiAddress        varchar(256 ) -- 
	,EmexUsername      nvarchar(32)   null  --Пользователь для интеграции
	,EmexPassword      nvarchar(32)   null  --Пароль для интеграции

	,Discount          money        -- Скидка (discount, текстовое поле, по умолчанию установить значение "5", -- Discount -- Скидка поставщика на закупку товара
	,Commission        money        --  
	,ExtraKurs         money        -- Комиссия эквайера
    ,GroupName	       varchar(64 ) -- 

	--
	,UserID            numeric(18,0) default dbo.GetUserID()
	,inDatetime        datetime      default GetDate()      --
	,updDatetime       datetime      default GetDate()      --

	)

	create unique index ao1 on tSuppliers(SuppliersID) include (Brief, Name)

	create unique index ao2 on tSuppliers(Brief, PriceName)
end
go
grant all on tSuppliers to public
go
exec setOV 'tSuppliers', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tSuppliers', @desc = 'Таблица Поставщики'

