if OBJECT_ID('vSuppliersPrices') is not null
    drop view vSuppliersPrices
go
/* **********************************************************
vSuppliersPrices - 
********************************************************** */
create view vSuppliersPrices
as
SELECT 
       sp.SupplierPricesID  
      ,sp.SuppliersID	
      ,cast(s.Brief as varchar)  SupplierBrief
      ,sp.Name              
      ,sp.Comment           
      ,sp.DeliveryTerm	   
      ,sp.DeliveryType	   
      ,sp.InWorkingDays     
      ,sp.ShowInSearch      
      ,sp.Flag              
  FROM [dbo].tSupplierPrices sp with (nolock)
 inner join tSuppliers s with (nolock)
         on s.SuppliersID=sp.SuppliersID

go
grant all on vSuppliersPrices to public
go
exec setOV 'vSuppliersPrices', 'V', '20250618', '0'
go
--select * from vSupplierPrices