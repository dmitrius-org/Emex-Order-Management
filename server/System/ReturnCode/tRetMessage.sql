if OBJECT_ID('tRetMessage') is null
--drop table tRetMessage
/* **********************************************************
tRetMessage - коды ошибок
********************************************************** */
begin
	create table tRetMessage
	(
	 Spid              numeric(18, 0) default @@Spid
	,RetCode           numeric(18, 0)   --  
	,Message           nvarchar(1024)       --
	);

	create index ao1 on tRetMessage(Spid, RetCode);

	grant all on tRetMessage to public;
end
go
exec setOV 'tRetMessage', 'U', '20240101', '0'
go