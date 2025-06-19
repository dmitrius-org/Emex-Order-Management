if OBJECT_ID('SupplierPricesDelete') is not null
    drop proc SupplierPricesDelete
/*
  SupplierPricesDelete - 
*/
go
create proc SupplierPricesDelete
              @SupplierPricesID  numeric(18, 0)  
as
  set nocount on
  declare @r int

  select @R         = 0

  
  DELETE tSupplierPrices
    FROM tSupplierPrices with (rowlock)
   WHERE SupplierPricesID = @SupplierPricesID


exit_:
return @r
go
grant exec on SupplierPricesDelete to public
go
exec setOV 'SupplierPricesDelete', 'P', '20250618', '0'
go