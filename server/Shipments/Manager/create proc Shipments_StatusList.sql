drop proc if exists Shipments_StatusList
go
create proc Shipments_StatusList
      
/*
  Shipments_StatusList - Список статусов отгрузок
*/           
as
  declare @r int = 0

  select NodeID as ID
        ,SName  as Name
    from tNodes (nolock)
   where SID is not null
   order by SID

  exit_:
  return @r

go
grant exec on Shipments_StatusList to public
go
exec setOV 'Shipments_StatusList', 'P', '20250312', '0'
go
 
exec Shipments_StatusList