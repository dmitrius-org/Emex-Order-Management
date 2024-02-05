if OBJECT_ID('tDocuments') is null
  --drop table tDocuments
/* **********************************************************
tDocuments - 
********************************************************** */
create table tDocuments
(
 DocumentID          numeric(18,0)  identity -- 
,ClientID            numeric(18,0)  
,Number              nvarchar(255)  null  --
,Date                datetime
,Amount              money
,Comment	         nvarchar(512)  null  -- 
,Type         int            --     1 - дебит
                             --    -1 - кредит   
--
,Flag                int
,UserID              numeric(18,0) default dbo.GetUserID()
,inDatetime          datetime      default GetDate()
,updDatetime         datetime      default GetDate()
)
go
create unique index ao1 on tDocuments(DocumentID)
go
create index ao2 on tDocuments(ClientID)
go
grant all on tDocuments to public
go
-- Описание таблицы
exec dbo.sys_setTableDescription @table = 'tDocuments', @desc = 'Таблица '