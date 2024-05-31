drop view if exists vDBUpdateDate
go
/* **********************************************************						
vDBUpdateDate - 
********************************************************** */
create view vDBUpdateDate
as
select *
      ,datediff(dd, UpdateDate, Getdate()) UpdateDays
  from tProfilesPrice

go
grant all on vDBUpdateDate to public
go
exec setOV 'vDBUpdateDate', 'V', '20240530', '1'
go
 
