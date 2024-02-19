if OBJECT_ID('tRetCode') is null
--drop table tRetCode
/* **********************************************************
tRetCode - коды ошибок
********************************************************** */
begin
	create table tRetCode
	(
	 RetCode           numeric(18,0)   --  
	,Message           nvarchar(512)       --
	);

	create unique index ao1 on tRetCode(RetCode);

	grant all on tRetCode to public;
end
go
exec setOV 'tRetCode', 'U', '20240101', '1.0.0.0'
go