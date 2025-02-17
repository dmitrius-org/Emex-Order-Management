if OBJECT_ID('pBalanceShipments') is not null
  drop table pBalanceShipments
go
/* **********************************************************
pBalanceShipments -
********************************************************** */
create table pBalanceShipments
(
 ID                  numeric(18, 0) identity  -- 
,Spid                int            -- 
,ClientID            numeric(18, 0) -- Клиент  
,StatusID            int            -- 
,StatusName          varchar(255)   -- 
,OrderType           varchar(255)   -- 
,OrderSum            money          --
,Invoice             varchar(64)
,PayType             varchar(255)   -- 
,PaySum              money          --
,BalanceType         varchar(255)   -- 
,BalanceSum          money          --
,OperDate            datetime       --
,OperDateS           datetime       --

,ReceiptDate         datetime       --
,ReceiptDate2        datetime       --

,IsCalc              bit            --
,Flag                int            -- дополнительные принаки 
)
go
create unique index ao1 on pBalanceShipments(ID)
go
create index ao2 on pBalanceShipments(Spid, ClientID)
go
grant all on pBalanceShipments to public
go
exec setOV 'pBalanceShipments', 'U', '20250217', '1'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pBalanceShipments', @desc = ''