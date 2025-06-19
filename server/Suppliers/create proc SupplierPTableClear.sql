if OBJECT_ID('SupplierPTableClear') is not null
    drop proc SupplierPTableClear
/*
  SupplierPTableClear - 
*/
go
create proc SupplierPTableClear
as
  set nocount on
  declare @r int

  delete pOrderFileFormat from pOrderFileFormat (rowlock) where spid = @@spid

  delete pSupplierPrices from pSupplierPrices (rowlock) where spid = @@spid

exit_:
return @r
go
grant exec on SupplierPTableClear to public
go
exec setOV 'SupplierPTableClear', 'P', '20250618', '0'
go