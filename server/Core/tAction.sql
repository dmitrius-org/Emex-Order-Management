if OBJECT_ID('tAction') is null
--drop table tAction
/* **********************************************************
tAction - типы действие TFormAction
********************************************************** */
begin
	create table tAction
	(
	 ActionID     numeric(18, 0) --
	,Brief        nvarchar(32)   -- 
	,Name         nvarchar(512)
	 PRIMARY KEY (ActionID)
	);

	create unique index ao2 on tAction(Brief);

	grant all on tAction to public;
end
go
exec setOV 'tAction', 'U', '20240101', '1.0.0.0'
go