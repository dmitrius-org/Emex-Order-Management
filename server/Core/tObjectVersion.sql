if OBJECT_ID('tObjectVersion') is null
--  drop table tObjectVersion
/* **********************************************************
tObjectVersion - Версии объектов системы
********************************************************** */
begin
	create table tObjectVersion
	(
	 ObjectVersionID                 numeric(18,0)  identity--
	,ObjectName                      nvarchar(255)  not null-- 
	,ObjectDate                      datetime     
	,ObjectTypeID                    numeric(18,0)
	,[Version]                       nvarchar(255)
	,[Type]                          nvarchar(2)
	,InDatetime                      datetime    
	,UpdDatetime                     datetime    
	);

	create index ao1 on tObjectVersion(ObjectVersionID);

	grant select on tObjectVersion to public;
end