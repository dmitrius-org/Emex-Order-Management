

if OBJECT_ID('tEmployeeParameters') is null
/*
  ALTER TABLE tEmployeeParameters SET ( SYSTEM_VERSIONING = OFF )
  drop table tEmployeeParameters
  DROP TABLE History.tEmployeeParameters
--*/
/* **********************************************************
tEmployeeParameters - 
********************************************************** */
begin
    create table tEmployeeParameters
    (
     EmployeeID    numeric(18,0) 
    ,ProcessedVal  decimal(10,2)  -- Награда за обработанную деталь
    ,IncorrectVal  decimal(10,2)  -- Штраф за неправильно обработанную деталь
    ,ConfirmedVal  decimal(10,2)  -- Награда за подтвержденную деталь
    ,Flag          int
    ,UserID        numeric(18,0) 
    ,InDateTime    datetime      
    ,ValidFrom     DATETIME2 GENERATED ALWAYS AS ROW START
    ,ValidTo       DATETIME2 GENERATED ALWAYS AS ROW END
    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

    ,CONSTRAINT PK_tEmployeeParameters_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID)
	)
    WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = history.tEmployeeParameters));

    --CONSTRAINT FK_Employee FOREIGN KEY (UserID) REFERENCES tUser(UserID) ON DELETE CASCADE
end
go
grant select on tEmployeeParameters to public
go
exec setOV 'tEmployeeParameters', 'U', '20250207', '0'
go