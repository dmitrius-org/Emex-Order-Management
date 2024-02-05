if OBJECT_ID('MovementArchive') is not null
    drop proc MovementArchive
/*
  MovementArchive - Архив синхронизационных данных по заказу.
                    Сведения о заказе полученные от emex
*/
go

Create proc MovementArchive
as
 set nocount on; 
 declare @r int = 0

 insert hMovement
      (
       OrderID                
      ,OrderNumber            
      ,Comment                
      ,OrderDetailSubId       
      ,DocumentDate           
      ,PriceOrdered           
      ,PriceSale              
      ,MakeLogo               
      ,DetailNum              
      ,Quantity               
      ,Condition              
      ,Reference              
      ,DetailNameRus          
      ,DetailNameEng          
      ,CustomerSubId          
      ,DestinationLogo        
      ,PriceLogo              
      ,ReplacementMakeLogo    
      ,ReplacementDetailNumber
      ,StatusId               
      ,StateText              
      ,Flag                   
      ,Tag                    
      )
select
       t.OrderID                
      ,t.OrderNumber            
      ,t.Comment                
      ,t.OrderDetailSubId       
      ,t.DocumentDate           
      ,t.PriceOrdered           
      ,t.PriceSale              
      ,t.MakeLogo               
      ,t.DetailNum              
      ,t.Quantity               
      ,t.Condition              
      ,t.Reference              
      ,t.DetailNameRus          
      ,t.DetailNameEng          
      ,t.CustomerSubId          
      ,t.DestinationLogo        
      ,t.PriceLogo              
      ,t.ReplacementMakeLogo    
      ,t.ReplacementDetailNumber
      ,t.StatusId               
      ,t.StateText              
      ,t.Flag                   
      ,t.Tag 
  from pMovement p (nolock)
 inner join tMovement t (nolock)
         on p.OrderNumber      = t.OrderNumber
        and p.DetailNum        = t.DetailNum
        and p.CustomerSubId    = t.CustomerSubId
        and p.Reference        = t.Reference 
 where p.spid = @@spid


delete t
  from pMovement p (nolock)
 inner join tMovement t (rowlock)
         on p.OrderNumber      = t.OrderNumber
        and p.DetailNum        = t.DetailNum
        and p.CustomerSubId    = t.CustomerSubId
        and p.Reference        = t.Reference 
 where p.spid = @@spid


 insert tMovement
      (
       OrderID                
      ,OrderNumber            
      ,Comment                
      ,OrderDetailSubId       
      ,DocumentDate           
      ,PriceOrdered           
      ,PriceSale              
      ,MakeLogo               
      ,DetailNum              
      ,Quantity               
      ,Condition              
      ,Reference              
      ,DetailNameRus          
      ,DetailNameEng          
      ,CustomerSubId          
      ,DestinationLogo        
      ,PriceLogo              
      ,ReplacementMakeLogo    
      ,ReplacementDetailNumber
      ,StatusId               
      ,StateText              
      ,Flag                   
      ,Tag                    
      )
select
       p.OrderID                
      ,p.OrderNumber            
      ,p.Comment                
      ,p.OrderDetailSubId       
      ,p.DocumentDate           
      ,p.PriceOrdered           
      ,p.PriceSale              
      ,p.MakeLogo               
      ,p.DetailNum              
      ,p.Quantity               
      ,p.Condition              
      ,p.Reference              
      ,p.DetailNameRus          
      ,p.DetailNameEng          
      ,p.CustomerSubId          
      ,p.DestinationLogo        
      ,p.PriceLogo              
      ,p.ReplacementMakeLogo    
      ,p.ReplacementDetailNumber
      ,p.StatusId               
      ,p.StateText              
      ,0                   
      ,p.Tag 
  from pMovement p (nolock)
 where spid = @@spid
 
  exit_:

  return @r
GO
grant exec on MovementArchive to public
go