if OBJECT_ID('tClientReliation') is null
--drop table tClientReliation
/* **********************************************************
tClientReliation - связь с клиентами
********************************************************** */
begin
	create table tClientReliation
	(
	 ClientReliationID    numeric(18,0)  identity --  
	,ClientID             numeric(18,0)  not null --
	,LinkID	              numeric(18,0)  not null -- 
	,LinkType             numeric(18,0)  not null --tObjectType.ObjectTypeID   
	--
	,UserID               numeric(18,0) default dbo.GetUserID()
	,inDatetime           datetime      default GetDate()      --
	,updDatetime          datetime      default GetDate()      --
	)

	create unique index ao1 on tClientReliation(ClientReliationID)

	create unique index ao2 on tClientReliation(LinkType, ClientID, LinkID)

	grant all on tClientReliation to public
end
go
exec setOV 'tClientReliation', 'U', '20240101', '0'
go
exec dbo.sys_setTableDescription @table = 'tClientReliation', @desc = 'Связь с клиентами'
