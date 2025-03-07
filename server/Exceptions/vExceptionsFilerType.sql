drop view if exists vExceptionsFilerType
go
/* **********************************************************						
vExceptionsFilerType - 
********************************************************** */
create view vExceptionsFilerType
as

      Select 1 as ID, 'Детали у которых изменен вес, либо объем' as Name
union select 2, 'Детали у которых изменено наименование'
union select 3, 'Детали с пометкой NoAir'  
union select 4, 'Детали с пометкой Fragile'
union select 5, 'Детали с пометкой NLA'

go
grant all on vExceptionsFilerType to public
go
exec setOV 'vExceptionsFilerType', 'V', '20250307', '0'
go
 

 select* from vExceptionsFilerType
