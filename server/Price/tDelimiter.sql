if OBJECT_ID('tDelimiter') is null
--drop table tDelimiter
/* **********************************************************
tDelimiter - 
********************************************************** */
begin
	create table tDelimiter
	(
	 DelimiterID  int  identity --
	,Brief        varchar(10)  
	,Name         varchar(60)   --
	);

	create unique index ao1 on tDelimiter(DelimiterID);

	grant all on tDelimiter to public;

	insert tDelimiter (Brief, Name) select ';', 'Разделитель точка запятая'; 
	insert tDelimiter (Brief, Name) select char(9), 'Разделитель табуляция'; 
end
go
exec setOV 'tDelimiter', 'U', '20240101', '1.0.0.0'
go


