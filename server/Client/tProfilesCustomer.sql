if OBJECT_ID('tProfilesCustomer') is null
/* **********************************************************
tProfilesCustomer - профили управления выгрузкой
********************************************************** */
begin
	create table tProfilesCustomer
	(
	 ProfilesCustomerID  int  identity  -- 
	,ClientID            numeric(18, 0) -- Клиент   
	,Brief               varchar(60)    --
	,ProfilesDeliveryID  int   

	,Margin              money          -- Наценка в процентах (margin, текстовое поле, по умолчанию установить значение "25"
	,Reliability         money          -- Вероятность поставки (reliability, текстовое поле, по умолчанию установить значение "70"
	,Discount            money          -- Скидка (discount, текстовое поле, по умолчанию установить значение "5", -- Discount -- Скидка поставщика на закупку товара
	,Commission          money          -- Комиссия эквайера (commission, текстовое поле, по умолчанию установить значение "3,5"
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
	);

	create unique index ao1 on tProfilesCustomer(ProfilesCustomerID);
	create unique index ao2 on tProfilesCustomer(ClientID, Brief);
	create index ao3 on tProfilesCustomer(UploadPriceName);	
	create index ao4 on tProfilesCustomer(ClientID);	
	grant all on tProfilesCustomer to public;
end
go
exec setOV 'tProfilesCustomer', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tProfilesCustomer', @desc = 'Профили управления выгрузкой прайсов'
