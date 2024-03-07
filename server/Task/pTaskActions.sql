if OBJECT_ID('pTaskActions') is not null
  drop table pTaskActions
go
/* **********************************************************

********************************************************** */
create table pTaskActions
(
 Spid             numeric(18,0) 
,ID               numeric(18,0)  identity --  
,TaskActionsID    numeric(18,0)   --  
,TaskID           numeric(18,0)   --  
,Number           int      --
,Comment          nvarchar(255)       -- 
,TaskType         int                -- тип задачи
,IsActive         bit
,LinkID           numeric(18,0)
,Field            nvarchar(max)
,Flag             int         
,inDatetime       datetime     --
,updDatetime      datetime     --
);
go
create unique index ao1 on pTaskActions(ID);
go
create index ao2 on pTaskActions(Spid);
go
grant all on pTaskActions to public;
go
exec setOV 'pTaskActions', 'U', '20240307', '1.0.0.1';
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'pTaskActions', @desc = 'Действия для задачи';
go