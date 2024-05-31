if OBJECT_ID('tArticles') is null
/* **********************************************************
tArticles - Статьи

drop table tArticles
********************************************************** */
begin
	create table tArticles
	(
	 ArticleID         numeric(18,0)  identity --  
	,ParentID          numeric(18,0)
	,Name	           nvarchar(256)           -- Название
	,Comment           nvarchar(512)           -- Описание 
	,Type              int
   -- ,              int
	
 	,UserID            numeric(18,0) default dbo.GetUserID()
	,inDatetime        datetime      default GetDate()      --
	,updDatetime       datetime      default GetDate()      --
	);

	create unique index ao1 on tArticles(ArticleID);

	create index ao2 on tArticles(Name);

	grant all on tArticles to public;
end
go
exec setOV 'tArticles', 'U', '20240325', '0';
go
exec dbo.sys_setTableDescription @table = 'tArticles', @desc = 'Статьи'
go
