if OBJECT_ID('tUserReliation') is null
--drop table tUserReliation
/* **********************************************************
tUserReliation - Связь с пользователями
********************************************************** */
create table tUserReliation
(
 UserID            numeric(18,0)   --  
,GroupID           numeric(18,0)   --  
,LinkType          int -- 
)
go
create unique index ao1 on tUserReliation(LinkType, UserID, GroupID)
go
--create unique index ao2 on tUserReliation()
go
grant all on tUserReliation to public
go