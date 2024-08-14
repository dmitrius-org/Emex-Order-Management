if OBJECT_ID('pPartsStatistics') is not null
drop table pPartsStatistics
/* ********************************************************** 						
pPartsStatistics - Статистика по детали
********************************************************** */
begin
	create table pPartsStatistics
	(Spid              numeric(18, 2)     
	,ID                numeric(18,0)  identity --  
	,Make              nvarchar(30)    -- Зашифрованное название бренда
	,DetailNum	       nvarchar(40)    -- Номер детали 

    ,OrderCount        int            -- Количество заказанных позиций 
   

	);

	create unique index ao1 on pPartsStatistics(Spid, Make, DetailNum);

	grant all on pPartsStatistics to public;
end
go
exec setOV 'pPartsStatistics', 'U', '20240101', '0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pPartsStatistics', @desc = 'Статистика по детали'
-- Описание полей
exec dbo.sys_setTableDescription 'pPartsStatistics', 'ID'                      ,'Уникальный идентификатор'
exec dbo.sys_setTableDescription 'pPartsStatistics', 'Make'                    ,'Зашифрованное название бренда'
--exec dbo.sys_setTableDescription 'pPartsStatistics', 'Brand'                   ,'Бренд'
exec dbo.sys_setTableDescription 'pPartsStatistics', 'DetailNum'               ,'Номер детали '
exec dbo.sys_setTableDescription 'pPartsStatistics', 'OrderCount'              ,'Количество заказанных позиций '

