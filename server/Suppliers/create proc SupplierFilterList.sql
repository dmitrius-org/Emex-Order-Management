if OBJECT_ID('SupplierFilterList') is not null
    drop proc SupplierFilterList
/*
  SupplierFilterList -  
*/
go
create proc SupplierFilterList
as
  declare @r int = 0

 select SuppliersID as ID, 
        Brief as Name 
   from tSuppliers (nolock)
  where SuppliersID<>8

exit_:
return @r
go
grant exec on SupplierFilterList to public
go
exec setOV 'SupplierFilterList', 'P', '20250618', '0'
go
