if OBJECT_ID('tShipmentsStatus') is null
  --drop table tShipmentsStatus
/* **********************************************************
tShipmentsStatus - 

25.07.2024 21:51:39;QAKV108C;Прошел границу РФ;3
********************************************************** */
begin
	create table tShipmentsStatus
	(
	 ShipmentStatusID        numeric(18,0)  identity --
	,Date                    datetime        
	,Number                  nvarchar(64)   -- Номер груза
	,Name                    nvarchar(128)  -- Наименование статуса
	,ID                      int   -- уникальный код статуса
	,inDatetime              datetime2  default SYSDATETIME()     --
	)

	create unique index ao1 on tShipmentsStatus(ShipmentStatusID) 

	create index ao2 on tShipmentsStatus(Number, ID)

	grant select on tShipmentsStatus to public
end
go
exec setOV 'tShipmentsStatus', 'U', '20240914', '0'
go


