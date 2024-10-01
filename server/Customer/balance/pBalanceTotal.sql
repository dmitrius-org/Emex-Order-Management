if OBJECT_ID('pBalanceTotal') is not null
  drop table pBalanceTotal
go
/* **********************************************************
pBalanceTotal -
********************************************************** */
create table pBalanceTotal
(
 ID                  numeric(18, 0) identity  -- 
,Spid                int            -- 
,ClientID            numeric(18, 0) -- Клиент  
,StatusID            int            -- 
,StatusName          varchar(255)   -- 
,OrderType           varchar(255)   -- 
,OrderSum            money          --
,PayType             varchar(255)   -- 
,PaySum              money          --
,BalanceType         varchar(255)   -- 
,BalanceSum          money          --
,OperDate            datetime       --
,IsCalc              bit            --
)
go
create unique index ao1 on pBalanceTotal(ID)
go
create index ao2 on pBalanceTotal(Spid, ClientID)
go
grant all on pBalanceTotal to public
go
exec setOV 'pBalanceTotal', 'U', '20240906', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pBalanceTotal', @desc = ''