drop table if exists pClientReliation
go
/* **********************************************************
pClientReliation -  связь с клиентами
********************************************************** */
create table pClientReliation
(
 ID                   numeric(18,0)  identity 
,Spid                 numeric(18,0)  --
,ClientReliationID    numeric(18,0)  --  
,ClientID             numeric(18,0)  --
,LinkID	              numeric(18,0)  -- 
,LinkType             int  not null --tObjectType.ObjectTypeID   
,ObjectType           int 
)
go
create unique index ao1 on pClientReliation(ID)
go
grant all on pClientReliation to public
go
exec setOV 'pClientReliation', 'U', '20241105', '1'
go
exec dbo.sys_setTableDescription @table = 'pClientReliation', @desc =  'Cвязь с клиентами'
go
