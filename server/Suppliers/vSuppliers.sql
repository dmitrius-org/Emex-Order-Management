if OBJECT_ID('vSuppliers') is not null
    drop view vSuppliers
go
/* **********************************************************
vSuppliers - 
********************************************************** */
create view vSuppliers
as
SELECT [SuppliersID]
      ,[Brief]
      ,[Name]
      --,[PriceName]
      ,[GroupName]
      ,Discount
      ,Commission
      ,ExtraKurs
      ,EmexUsername 
      ,EmexPassword 
      ,ApiAddress
      ,[UserID]
      ,[inDatetime]
      ,[updDatetime]
  FROM [dbo].[tSuppliers] (nolock)  

go
grant all on vSuppliers to public
go
exec setOV 'vSuppliers', 'V', '20250613', '0'
go
