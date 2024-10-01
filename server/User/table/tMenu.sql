if OBJECT_ID('tMenu') is null
--drop table tMenu
/* **********************************************************
tMenu - структура меню
********************************************************** */
begin
	create table tMenu
	(
	 MenuID            numeric(18, 0)  --  
	,N                 int
	,Caption           nvarchar(512)   -- 
	,Name	           nvarchar(512)   --
	,ParentID          numeric(18, 0)
	,Icon	           nvarchar(512)   --
	,Type              int
	,inDatetime        datetime default GetDate()      --
	)
	
	create unique index ao1 on tMenu(MenuID)
	
	create index ao2 on tMenu(Name)
	
	grant all on tMenu to public
end
go
exec setOV 'tMenu', 'U', '20240101', '0'
go

