if OBJECT_ID('tUsersAuthorization') is null
--drop table tUsersAuthorization
/* **********************************************************
tUsersAuthorization - 
********************************************************** */
begin
	create table tUsersAuthorization
	(
	 UserName          nvarchar(512)  not null --
	,CNT               nvarchar(512)  null  -- 
	,inDatetime        datetime 
	)
	
	create unique index ao1 on tUsersAuthorization(UserName);
	
	grant all on tUsersAuthorization to public;
end
go
exec setOV 'tUsersAuthorization', 'U', '20240327', '1';
go
