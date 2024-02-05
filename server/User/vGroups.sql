if OBJECT_ID('vGroups') is not null
    drop view vGroups
go
/* **********************************************************						
vGroups - получение списка групп/ролей
********************************************************** */

create view vGroups

as

--SET DATEFIRST 1;

SELECT [GroupID]
      ,[Brief]
      ,[Name]
      ,[inDatetime]
      ,[updDatetime]
  FROM [tGroups] (nolock)

go
grant all on vGroups to public



--select * from vUsers
