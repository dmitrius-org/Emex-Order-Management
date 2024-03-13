if OBJECT_ID('tSearchPrice') is null
--drop table tSearchPrice
/* **********************************************************						
tSearchPrice - список прайсов для поисковой выдчи клиентам
********************************************************** */
begin
	create table tSearchPrice
	(
	 PriceID           numeric(18,0)  identity --  
	,MakeLogo          varchar(30)    -- наименоване прайса
	,Synthetic         bit            -- тип: синтетический прайс

	);

	create unique index a1 on tSearchPrice(PriceID);

	create unique index ao2 on tSearchPrice(MakeLogo);

	grant all on tSearchPrice to public
end
go
exec setOV 'tSearchPrice', 'U', '20240101', '0'
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tSearchPrice', @desc = 'Список прайсов для поисковой выдчи клиентам'
-- Описание полей
exec dbo.sys_setTableDescription 'tSearchPrice', 'PriceID'                 ,'Уникальный идентификатор '
/*
insert tSearchPrice
      (MakeLogo, Synthetic)
          select '24H',  0
union all select '48H',  0
union all select 'FAST', 0
union all select 'EMIR', 0
union all select 'EMIS', 0
union all select 'EMIN', 0
union all select 'EMIL', 0
union all select 'EMIZ', 0
union all select 'OPTA', 0
union all select 'MOTO', 0
--*/