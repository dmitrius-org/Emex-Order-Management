if OBJECT_ID('tModelMetod') is null
--drop table tModelMetod
/* **********************************************************
tModelExt - Расширение таблицы tModel
            Методы настроенные на действии
********************************************************** */
begin
	create table tModelMetod
	(
	 ModelMetodID      numeric(18,0)  identity  --  
	,ModelID           numeric(18,0)  not null  --
	,Metod             nvarchar(128)            --
	,MetodRollback     nvarchar(128)            --
	,Comment           nvarchar(512)  null      --
	,Flag              int            default 0 --
	,Type              int            not null  --
	,N                 int            default 0 --
	)

	create unique index ao1 on tModelMetod(ModelMetodID)

	create unique index ao2 on tModelMetod(ModelID, Type, Metod)

	grant all on tModelMetod to public
end
go
exec setOV 'tModelMetod', 'U', '20240101', '1.0.0.0'
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tModelMetod', @desc = 'Расширение таблицы tModel'
