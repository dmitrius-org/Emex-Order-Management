if OBJECT_ID('vOrderFileFormat') is not null
    drop view vOrderFileFormat
go
/* **********************************************************						
vOrderFileFormat - 
********************************************************** */

create view vOrderFileFormat

as

--SET DATEFIRST 1;

select o.ID
      ,o.OrderFileFormatID
      ,o.ClientID
      ,o.Folder      
      ,o.Firstline   
      ,o.Manufacturer
      ,o.DetailNumber  
      ,o.Quantity    
      ,o.DetailID          
      ,o.DetailName  
      ,o.Price       
      ,o.Amount      
      ,o.OrderNum    
      ,o.OrderDate   
      ,o.PriceNum    
      ,o.Commission
	  ,o.IsActive 
	  ,o.CustomerSubID
	  ,o.Reference
  from pOrderFileFormat o (nolock)
 where o.spid=@@spid

go
grant all on vOrderFileFormat to public



select * from vOrderFileFormat
