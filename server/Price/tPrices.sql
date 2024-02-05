if OBJECT_ID('tPrices') is null
--drop table tPrices
/* **********************************************************						
tPrices - список прайсов 
********************************************************** */
create table tPrices
(
 Name           nvarchar(30) not null 
,Comment        nvarchar(256) 
,DeliveryTerm	int            -- Срок доставки
,DeliveryType	nvarchar(30)   -- Тип доставки
,InWorkingDays  bit            -- Срок указан в рабочих днях
,Flag           int

)
go
create unique index a1 on tPrices (Name)
go
grant all on tPrices to public
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tPrices', @desc = 'Список прайсов'
-- Описание полей
exec dbo.sys_setTableDescription 'tPrices', 'Name',                'Наименование прайса'
/*
insert tPrices
      (Name, Flag, DeliveryTerm, DeliveryType)
          select '24H',  1|2,  1, 'Days' 
union all select '48H',  1|2,  2, 'Days'
union all select 'FAST', 1|2,  7, 'Days'
union all select 'EMIR', 1|2, 10, 'Days'
union all select 'EMIS', 1|2, 20, 'Days' 
union all select 'EMIN', 1|2, 70, 'Days' 
union all select 'EURU', 1|2, 50, 'Days'
union all select 'EMIZ', 1|2, 70, 'Days'
union all select 'OPTA', 1|2, 15, 'Days'
union all select 'EMIT', 1|2, 2 , 'Days'

--*/

select * 
  from tPrices (Nolock)