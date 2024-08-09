if OBJECT_ID('tPartsStatistics') is null
--drop table tPartsStatistics
/* ********************************************************** 						
tPartsStatistics - Статистика по детали
********************************************************** */
begin
	create table tPartsStatistics
	(
	 PartsStatisticID  numeric(18,0)  identity --  
	,Make              nvarchar(30)    -- Зашифрованное название бренда
	,DetailNum	       nvarchar(40)    -- Номер детали 

    ,OrderCount        int            -- Количество заказанных позиций 
    ,OrderUniqueCount  int            -- Количество уникальных заказов

	);

	create unique CLUSTERED  index ao1 on tPartsStatistics(Make, DetailNum);

	grant all on tPrice to public;
end
go
exec setOV 'tPartsStatistics', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tPartsStatistics', @desc = 'Статистика по детали'
-- Описание полей
exec dbo.sys_setTableDescription 'tPartsStatistics', 'PartsStatisticID'        ,'Уникальный идентификатор'
exec dbo.sys_setTableDescription 'tPartsStatistics', 'Make'                    ,'Зашифрованное название бренда'
--exec dbo.sys_setTableDescription 'tPartsStatistics', 'Brand'                   ,'Бренд'
exec dbo.sys_setTableDescription 'tPartsStatistics', 'DetailNum'               ,'Номер детали '
exec dbo.sys_setTableDescription 'tPartsStatistics', 'OrderCount'              ,'Количество заказанных позиций '
exec dbo.sys_setTableDescription 'tPartsStatistics', 'OrderUniqueCount'         ,'Количество уникальных заказов'