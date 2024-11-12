if OBJECT_ID('tClients') is null
/*
  ALTER TABLE tClients SET ( SYSTEM_VERSIONING = OFF )
  --drop table tClients
  DROP TABLE History.tClients
*/
/* **********************************************************
tClients - Клиенты
********************************************************** */
begin
	create table tClients
	(
	 ClientID             numeric(18,0)  identity --  
	,Brief                nvarchar(256)  not null --
	,Name	              nvarchar(512)  null     -- 
	,Email                nvarchar(256)  null     -- 
	,Password             nvarchar(256)  null     -- 

	,IsActive             bit
	,IsConfirmed          bit          -- Признак что регистрация подтверждена
	,IsConfirmedDate      datetime	   -- Дата подтверждения регистрации
	,Taxes                money        -- Комиссия и налоги
	,ResponseType         int          -- Тип ответа
	,NotificationMethod   int          -- Способ оповещения
	,NotificationAddress  nvarchar(256)-- Адрес оповещения
	,SuppliersID          numeric(18,0)-- Поставщик
    --
	,ClientTypeID         int          -- Тип клиента
    ,StatusRequiringPayment varchar(256)-- Статусы требующие предоплаты


	--
	,UserID               numeric(18,0) default dbo.GetUserID()
	,inDatetime           datetime      default GetDate()      --
	,updDatetime          datetime      default GetDate()      --
     --
    ,[ValidFrom]          DATETIME2 GENERATED ALWAYS AS ROW START
    ,[ValidTo]            DATETIME2 GENERATED ALWAYS AS ROW END

    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tClients_ClientID PRIMARY KEY CLUSTERED (ClientID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tClients));

	create unique index ao1 on tClients(ClientID) include (Brief, Name);
	
	create unique index ao2 on tClients(Brief);

	grant all on tClients to public;
end
go
exec setOV 'tClients', 'U', '20240101', '0'
go
exec dbo.sys_setTableDescription @table = 'tClients', @desc = 'Таблица Клиенты'
