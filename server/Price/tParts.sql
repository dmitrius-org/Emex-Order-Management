if OBJECT_ID('History.tPartsHistory') is not null
  drop table History.tPartsHistory
go
if OBJECT_ID('tParts') is null
/*
  ALTER TABLE tParts SET ( SYSTEM_VERSIONING = OFF )
  drop table tParts
  DROP TABLE History.tParts
--*/
/* ********************************************************** 						
History.tPartsHistory - таблица цен
********************************************************** */
begin
	create table tParts
	( 
	 DetailNum	       varchar(40)    -- Номер детали 
    ,MakeLogo          varchar(30)    -- Зашифрованное название бренда
	,Brand             varchar(60)    -- Бренд
	,DetailName        varchar(256)   -- Наименование детали 
	,WeightKG          float          -- Вес физический кг 
	,VolumeKG          float          -- Вес объемный кг  
	,Restrictions      varchar(30)    -- Ограничения
    ,Fragile	       bit
    ,NLA               bit            -- No longer available или Более недоступно
	--
    ,InDatetime	       datetime
    ,UserID            numeric(18, 0)   
    ,ValidFrom         DATETIME2 GENERATED ALWAYS AS ROW START
    ,ValidTo           DATETIME2 GENERATED ALWAYS AS ROW END
    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tParts_ID PRIMARY KEY CLUSTERED (MakeLogo, DetailNum)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tParts));

	grant select on History.tParts to public;
end
go
exec setOV 'tParts', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tParts', @desc = 'Таблицы деталей (измененных)'