
--alter table tBasket

--add [ValidFrom]  DATETIME2 GENERATED ALWAYS AS ROW START /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidFrom DEFAULT SYSUTCDATETIME() 
--   ,[ValidTo]    DATETIME2 GENERATED ALWAYS AS ROW END   /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999')
   
--    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

--    ,CONSTRAINT PK_tBasket_BasketID PRIMARY KEY CLUSTERED (BasketID)
--go
--ALTER TABLE tBasket
--SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.tBasket));
--go

alter table tAudit alter column Comment           varchar(1024)
alter table tAudit alter  column HostInfoID        varchar(256) null



go
ALTER TABLE tAudit DROP CONSTRAINT DF__tAudit__InDateTi__5EDF0F2E;

ALTER TABLE tAudit 
ALTER COLUMN InDateTime DateTime2;

ALTER TABLE tAudit 
ADD CONSTRAINT DF_tAudit_InDateTime DEFAULT SYSDATETIME() FOR InDateTime;
