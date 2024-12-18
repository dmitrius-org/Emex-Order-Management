if OBJECT_ID('system.tCustomerTokens') is null
--  drop table system.tCustomerTokens
--go
/* **********************************************************
tCustomerTokens - Таблица протокола
********************************************************** */
begin
	create table system.tCustomerTokens
	(
    ID             INT IDENTITY    PRIMARY KEY, -- Уникальный идентификатор записи
    ClientID       numeric(18, 0)  NOT NULL,  -- ID пользователя
    Token          NVARCHAR(512 )  NOT NULL,  -- Сам токен
    Expiration     DATETIME2       NOT NULL,  -- Срок действия токена
    Status         bit             DEFAULT 0, -- Статус токена (1 - Active/ 0 - Revoked)
    InDateTime     DATETIME2       DEFAULT SYSDATETIME() -- Время создания записи
    );
   
	create index ao1 on system.tCustomerTokens([Token]);

	create index ao2 on system.tCustomerTokens(ClientID);

	grant select on system.tCustomerTokens to public;

    grant all on system.tCustomerTokens to ServiceUser;
end
go
exec setOV 'tCustomerTokens', 'U', '20240101', '0', 'System'
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'system.tCustomerTokens', @desc = 'Tokens'

