if OBJECT_ID('tArticleDetail') is null
/* **********************************************************
tArticleDetail - Статьи
drop table tArticleDetail
********************************************************** */
begin
	create table tArticleDetail
	(
	 ArticleDetailID numeric(18,0)  identity --  
	,ArticleID       numeric(18,0)
	,[Text]          nvarchar(max)           -- Название
	);
	
	create unique index ao1 on tArticleDetail(ArticleDetailID);

	create index ao2 on tArticleDetail(ArticleID);

	grant all on tArticleDetail to public;
end
go
exec setOV 'tArticleDetail', 'U', '20240325', '0';
go
exec dbo.sys_setTableDescription @table = 'tArticleDetail', @desc = 'Статьи'
go
