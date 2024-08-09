if OBJECT_ID('tProfilesCustomer') is null
/*
  ALTER TABLE tProfilesCustomer SET ( SYSTEM_VERSIONING = OFF )
  drop table tProfilesCustomer
  DROP TABLE History.hProfilesCustomer
*/
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

	,UploadFolder        varchar(255)   -- Каталог для сохранения прайс-файлов
	,UploadPriceName     varchar(255)   -- 
	,UploadFileName      varchar(255)   -- 
	,isActive            bit

	,ClientPriceLogo     nvarchar(32)   -- Наименование прайса клиента по которым заказываются детали
										-- по данному полю вымолняем сопоставление с tOrders.CustomerPriceLogo
	,UploadDelimiterID   int            -- разделитель 
     --
    ,[ValidFrom]         DATETIME2 GENERATED ALWAYS AS ROW START
    ,[ValidTo]           DATETIME2 GENERATED ALWAYS AS ROW END

    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tProfilesCustomer_ProfilesCustomerID PRIMARY KEY CLUSTERED (ProfilesCustomerID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.hProfilesCustomer));

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
