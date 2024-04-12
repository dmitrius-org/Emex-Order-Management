if OBJECT_ID('tInstructionsDetail') is null
/* **********************************************************
tInstructionsDetail - Инструкции
drop table tInstructionsDetail
********************************************************** */
begin
	create table tInstructionsDetail
	(
	 InstructionsDetailID numeric(18,0)  identity --  
	,InstructionID        numeric(18,0)
	,[Text]               nvarchar(max)              -- Название
	);
	
	create unique index ao1 on tInstructionsDetail(InstructionsDetailID);

	create index ao2 on tInstructionsDetail(InstructionID);

	grant all on tInstructionsDetail to public;
end
go
exec setOV 'tInstructionsDetail', 'U', '20240325', '0';
go
exec dbo.sys_setTableDescription @table = 'tInstructionsDetail', @desc = 'Инструкции'
go
