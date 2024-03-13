if OBJECT_ID('tCurrencyRate') is null
/* 
tCurrencyRate - курсы
*/
begin
	create table tCurrencyRate
	(
	 NumCode           nvarchar(3)    --
	,CharCode	       nvarchar(3)  
	,Nominal	       float
	,Name	           nvarchar(255) 
	,Value	           float
	,OnDate            date --default getdate()
	);

	create unique index ao1 on tCurrencyRate(NumCode, OnDate);

	create unique index ao2 on tCurrencyRate(CharCode, OnDate);
end
grant all on tCurrencyRate to public;
go
exec setOV 'tCurrencyRate', 'U', '20240101', '0';
go
exec dbo.sys_setTableDescription @table = 'tCurrencyRate', @desc = 'Таблица курсов';
