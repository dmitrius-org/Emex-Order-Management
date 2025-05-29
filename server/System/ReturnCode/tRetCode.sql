if OBJECT_ID('tRetCode') is null
--drop table tRetCode
/* **********************************************************
tRetCode - коды ошибок
********************************************************** */
begin
	create table tRetCode
	(
	 RetCode           numeric(18,0)   --  
	,Message           varchar(512)       --
    ,MessageEn         varchar(512)       --
	);

	create unique index ao1 on tRetCode(RetCode);

	grant all on tRetCode to public;
end
go
exec setOV 'tRetCode', 'U', '20240101', '0'
go
