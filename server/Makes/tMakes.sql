if OBJECT_ID('tMakes') is null
--drop table tMakes
/* 

*/
begin
	create table tMakes
	(
	 MakesID           numeric(18,0)  identity --  
	,Code              varchar(10)       --
	,Name	           varchar(60) null  -- 
	,Country	       varchar(60) null  --
	,inDatetime        datetime default GetDate()      --
	,updDatetime       datetime default GetDate()      --
	);

	create unique index ao1 on tMakes(MakesID);

	create index ao2 on tMakes(Code) INCLUDE (Name);

	grant all on tMakes to public;
end
go
exec setOV 'tMakes', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tMakes', @desc = 'Список марок автозапчастей'