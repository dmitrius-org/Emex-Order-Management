if OBJECT_ID('tClients') is null
--drop table tClients
/* **********************************************************
tClients - Клиенты
********************************************************** */
create table tClients
(
 ClientID             numeric(18,0)  identity --  
,Brief                nvarchar(256)  not null --
,Name	              nvarchar(512)  null     -- 
,Email                nvarchar(256)  null     -- 
,Password             nvarchar(256)  null     -- 

,IsActive             bit
,IsConfirmed          bit
,Taxes                money        -- Комиссия и налоги
,ResponseType         int          -- Тип ответа
,NotificationMethod   int          -- Способ оповещения
,NotificationAddress  nvarchar(256)-- Адрес оповещения
,SuppliersID          numeric(18,0)-- Поставщик

,ClientTypeID         int
,Margin               money         -- Наценка в процентах
,Reliability          money         -- Вероятность поставки 
,Discount             money         -- Скидка Discount -- Скидка поставщика на закупку товара
,Commission           money         -- Комиссия эквайера 
--
,UserID               numeric(18,0) default dbo.GetUserID()
,inDatetime           datetime      default GetDate()      --
,updDatetime          datetime      default GetDate()      --
)
go
create unique index ao1 on tClients(ClientID) include (Brief, Name)
go
create unique index ao2 on tClients(Brief)
go
grant all on tClients to public
go
exec dbo.sys_setTableDescription @table = 'tClients', @desc = 'Таблица Клиенты'


