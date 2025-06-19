if OBJECT_ID('vSupplierPrices') is not null
    drop view vSupplierPrices
go
/* **********************************************************
vSupplierPrices - 
********************************************************** */
create view vSupplierPrices
as
SELECT ID
      ,SupplierPricesID  
      ,SuppliersID	   
      ,Name              
      ,Comment           
      ,DeliveryTerm	   
      ,DeliveryType	   
      ,InWorkingDays     
      ,ShowInSearch      
      ,Flag              
  FROM [dbo].pSupplierPrices (nolock)  
 where spid = @@spid

go
grant all on vSupplierPrices to public
go
exec setOV 'vSupplierPrices', 'V', '20250618', '0'
go
--select * from vSupplierPrices