if OBJECT_ID('pPrice') is not null
  drop table pPrice
go
/* ********************************************************** 						
pPrice - таблица цен
********************************************************** */

create table pPrice
(
    Brand             varchar(10),   -- Зашифрованное название бренда MakeLogo
    DetailNum         varchar(40),
    DetailPrice       float,
    DetailName        varchar(128),
    PriceLogo         varchar(10),
    Quantity          float,
    PackQuantity      float,
    Reliability       float,
    WeightKG          float,
    VolumeKG          float,
    MOSA              float,
    Restrictions      varchar(10),   -- ограничения
    PartID            numeric(18,0)
);
CREATE INDEX ao1 ON pPrice (PriceLogo, PartID);
CREATE INDEX ao2 ON pPrice (Brand, DetailNum);

grant all on pPrice to public;

GRANT ALTER, INSERT, DELETE, UPDATE, SELECT, REFERENCES ON dbo.pPrice TO autotask;

-- Глобальное разрешение
--GRANT ADMINISTER BULK OPERATIONS TO autotask;

go
exec setOV 'pPrice', 'U', '20250521', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pPrice', @desc = 'Таблица для загрузки прайсов поставщиков'
-- Описание полей
exec dbo.sys_setTableDescription 'pPrice', 'PartID'                 ,'Уникальный идентификатор '
