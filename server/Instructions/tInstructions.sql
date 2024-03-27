if OBJECT_ID('tInstructions') is null
/* **********************************************************
tInstructions - Инструкции

drop table tInstructions
********************************************************** */
begin
	create table tInstructions
	(
	 InstructionID     numeric(18,0)  identity --  
	,ParentID          numeric(18,0)
	,Name	           nvarchar(256)           -- Название
	,Comment           nvarchar(512)           -- Описание 
	,Type              int

	,UserID            numeric(18,0) default dbo.GetUserID()
	,inDatetime        datetime      default GetDate()      --
	,updDatetime       datetime      default GetDate()      --
	);

	create unique index ao1 on tInstructions(InstructionID);

	create index ao2 on tInstructions(Name);

	grant all on tInstructions to public;
end
go
exec setOV 'tInstructions', 'U', '20240325', '0';
go
exec dbo.sys_setTableDescription @table = 'tInstructions', @desc = 'Инструкции'
go
