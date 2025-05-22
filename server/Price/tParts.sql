if OBJECT_ID('tParts') is null
/*
  ALTER TABLE tParts SET ( SYSTEM_VERSIONING = OFF )
  drop table tParts
  DROP TABLE History.tParts
--*/
/* ********************************************************** 						
History.tParts - таблица деталей
********************************************************** */
begin
	create table tParts
	(
     PartID            numeric(18,0)  identity --  
    ,Brand             varchar(10)    -- Зашифрованное название бренда MakeLogo
    ,BrandName         varchar(60)    -- Бренд
    ,DetailNum	       varchar(40)    -- Номер детали 

	,DetailName        varchar(256)   -- Наименование детали
    ,WeightKG          float          -- Вес физический кг 
	,VolumeKG          float          -- Вес объемный кг  
	
	,DetailNameF       varchar(256)   -- Наименование детали 
	,WeightKGF         float          -- Вес физический кг 
	,VolumeKGF         float          -- Вес объемный кг  

     -- Ограничения
	,NoAir             bit   
    ,NLA               bit            -- No longer available или Более недоступно
    ,Fragile	       bit

    --,InUserID          numeric(18, 0)   
    ,UserID          numeric(18, 0)  
	--,InDateTime        datetime       default GetDate()
    ,UpDatetime        DATETIME2 GENERATED ALWAYS AS ROW START
    ,ValidTo           DATETIME2 GENERATED ALWAYS AS ROW END
    ,PERIOD FOR SYSTEM_TIME (UpDatetime, ValidTo)

    ,CONSTRAINT PK_tParts_ID PRIMARY KEY CLUSTERED (PartID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tParts));

	create index ao2 on tParts(Brand, DetailNum);

 	grant select on History.tParts to public;
end
go
exec setOV 'tParts', 'U', '20250520', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tParts', @desc = 'Таблицы деталей'