if OBJECT_ID('vOrderFileFormat') is not null
    drop view vOrderFileFormat
go
/* **********************************************************						
vOrderFileFormat - 
********************************************************** */

create view vOrderFileFormat
as

select p.ID
      ,p.OrderFileFormatID
      ,p.ClientID
      ,p.Folder      
      ,p.Firstline   
      ,p.Manufacturer
      ,p.DetailNumber  
      ,p.Quantity    
      ,p.DetailID          
      ,p.DetailName  
      ,p.Price       
      ,p.Amount      
      ,p.OrderNum    
      ,p.OrderDate   
      ,p.PriceNum    
      ,p.Commission
      ,p.IsActive 
      ,p.CustomerSubID
      ,p.Reference
      ,p.OnlyThisBrand -- признак ТОЛЬКО ЭТОТ БРЕНД
  from pOrderFileFormat p (nolock)
 where p.spid=@@spid

go
grant all on vOrderFileFormat to public
go
exec setOV 'vOrderFileFormat', 'V', '20250402', '1'
go

