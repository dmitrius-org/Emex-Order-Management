if OBJECT_ID('History.tPartsHistory') is null
  --drop table History.tPartsHistory
/* ********************************************************** 						
History.tPartsHistory - таблица цен
********************************************************** */
begin
	create table History.tPartsHistory
	( 
	 DetailNum	       varchar(40)    -- Номер детали 
    ,MakeLogo          varchar(30)    -- Зашифрованное название бренда
	,Brand             varchar(60)    -- Бренд
	,DetailName        varchar(256)   -- Наименование детали 
	,WeightKG          float          -- Вес физический кг 
	,VolumeKG          float          -- Вес объемный кг  
	,Restrictions      varchar(30)    -- Ограничения
    ,Fragile	       bit
	--
    ,UserID            numeric(18, 0)
	,updDateTime       datetime
	);

	create index ao1 on History.tPartsHistory(DetailNum, MakeLogo);

	grant all on History.tPartsHistory to public;
end
go
exec setOV 'History.tPartsHistory', 'U', '20240101', '0'
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'History.tPrice', @desc = 'таблица цен/прайсов'
