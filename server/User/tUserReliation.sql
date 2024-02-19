if OBJECT_ID('tUserReliation') is null
--drop table tUserReliation
/* **********************************************************
tUserReliation - Связь с пользователями
********************************************************** */
begin
	create table tUserReliation
	(
	 UserID            numeric(18,0)   --  
	,GroupID           numeric(18,0)   --  
	,LinkType          int -- 
	)

	create unique index ao1 on tUserReliation(LinkType, UserID, GroupID)

	grant all on tUserReliation to public
end
go
exec setOV 'tUserReliation', 'U', '20240101', '1.0.0.0'
go

