if OBJECT_ID('tAction') is null
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
end
go
grant all on tAction to public
go
exec setOV 'tAction', 'U', '20240101', '0'
go