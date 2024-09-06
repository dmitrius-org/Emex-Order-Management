

--alter table tClientType

--add [ValidFrom]  DATETIME2 GENERATED ALWAYS AS ROW START /*HIDDEN*/ CONSTRAINT DF_tClientType_ValidFrom DEFAULT SYSUTCDATETIME() 
--   ,[ValidTo]    DATETIME2 GENERATED ALWAYS AS ROW END   /*HIDDEN*/ CONSTRAINT DF_tClientType_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999')
   
--    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

--    ,CONSTRAINT PK_tClientType_ClientTypeID PRIMARY KEY CLUSTERED (ClientTypeID)
--go
--ALTER TABLE tClientType
--SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.tClientType));
--go




--alter table tBasket

--add [ValidFrom]  DATETIME2 GENERATED ALWAYS AS ROW START /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidFrom DEFAULT SYSUTCDATETIME() 
--   ,[ValidTo]    DATETIME2 GENERATED ALWAYS AS ROW END   /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999')
   
--    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

--    ,CONSTRAINT PK_tBasket_BasketID PRIMARY KEY CLUSTERED (BasketID)
--go
--ALTER TABLE tBasket
--SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.tBasket));
--go


--alter table tPartsStatistics add WorkOrderCount           int            -- процент поставки
--go


--alter table tPartsStatistics add WorkOrderUniqueCount           int            -- процент поставки


--    ,WorkOrderCount        int        --  оличество заказанных позиций, только в работе 
--    ,WorkOrderUniqueCount  int        --  оличество уникальных заказов, только в работе

alter table torders
    add DeliveryDaysReserve2            int            -- ƒней запаса до вылета, рассчитываетс€ если прошол срок DeliveryNextDate		

alter table tProfilesCustomer
    add DeliveryTermCustomer            int            -- ƒней запаса до вылета, рассчитываетс€ если прошол срок DeliveryNextDate
    
