if OBJECT_ID('tApiMethodCalls') is null
/*
  --drop table tApiMethodCalls
*/
/* **********************************************************
tApiMethodCalls - Таблица для подсчета вызовов методов
********************************************************** */
begin
	create table tApiMethodCalls
	(	 
     ApiMethodCallsID     INT IDENTITY,
     ClientID             numeric(18,0) NOT NULL,
     MethodName           VARCHAR(255) NOT NULL,
     CallCount            INT NOT NULL DEFAULT 0,
     InDatetime           datetime2 default SYSDATETIME() --
	);  

	create index ao1 on tApiMethodCalls(ApiMethodCallsID);-- include (Brief, Name);

	grant all on tApiMethodCalls to public;
end
go
exec setOV 'tApiMethodCalls', 'U', '20240101', '0'
go
exec dbo.sys_setTableDescription @table = 'tApiMethodCalls', @desc = 'Таблица для подсчета вызовов методов'
-- Таблица для подсчета вызовов методов
CREATE TABLE MethodCalls (
    id INT PRIMARY KEY IDENTITY,
    method_name VARCHAR(255) NOT NULL,
    call_count INT NOT NULL DEFAULT 0
);