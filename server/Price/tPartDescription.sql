if OBJECT_ID('tPartDescription') is null
/* 
  tPartDescription - Русские наименования
*/
begin
	create table tPartDescription
	(
	 PartDescriptionID numeric(18,0)  identity --  
	,Make              nvarchar(10)   --
	,Number	           nvarchar(60)   -- 
	,Name_RUS	       nvarchar(256)  --
    ,Name_ENG          nvarchar(256)   --
	,inDatetime        datetime default GetDate()      --
	,updDatetime       datetime default GetDate()      --
	);

	create unique index ao1 on tPartDescription(PartDescriptionID);

	create index ao2 on tPartDescription(Make, Number) INCLUDE (Name_RUS);

	grant all on tPartDescription to public;
end
go
exec setOV 'tPartDescription', 'U', '20240619', '1'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tPartDescription', @desc = 'Русские наименования'
go
