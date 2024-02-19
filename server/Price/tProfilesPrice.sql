if OBJECT_ID('tProfilesPrice') is null
--drop table tProfilesPrice
/* **********************************************************
tProfilesPrice - профили управления загрузкой
********************************************************** */
begin
	create table tProfilesPrice
	(
	 ProfilesPriceID      int  identity --  
	,isActive             bit
	,PriceName            varchar(10)
	,UpdateDate           datetime
	);
	create unique index ao1 on tProfilesPrice(ProfilesPriceID);
	
	create unique index ao2 on tProfilesPrice(PriceName);
	
	grant all on tProfilesPrice to public;
end
go
exec setOV 'tProfilesPrice', 'U', '20240101', '1.0.0.0'
go
exec dbo.sys_setTableDescription @table = 'tProfilesPrice', @desc = 'Профили управления загрузкой'