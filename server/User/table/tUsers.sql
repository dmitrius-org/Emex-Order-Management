if OBJECT_ID('tUser') is null
/* **********************************************************
tUser - пользователи
********************************************************** */
begin
	create table tUser
	(
	 UserID            numeric(18,0)  identity --  
	,Brief             nvarchar(512)  not null --
	,Name              nvarchar(512)  null  -- 
	,isBlock           bit            default 0  --
	,DateBlock         datetime       null
	,Login             nvarchar(512) 
	--
	,inDatetime        datetime default GetDate()      --
	,updDatetime       datetime default GetDate()      --
	);
	
	create unique index ao1 on tUser(UserID) include (Brief, Name);
	
	create unique index ao2 on tUser(Brief);
	
	grant all on tUser to public;
end
go
exec setOV 'tUser', 'U', '20240101', '0';
go
