if OBJECT_ID('vPartsUpdate') is not null
    drop view vPartsUpdate
go
create view vPartsUpdate
/* **********************************************************						
vPartsUpdate - 
********************************************************** */
as

Select *
  from tParts ps with (updlock) -- перед тем как указать индкс проверить использование 

go

GRANT UPDATE, SELECT ON dbo.vPartsUpdate TO public;
go
exec setOV 'vPartsUpdate', 'V', '20250531', '25'
go


