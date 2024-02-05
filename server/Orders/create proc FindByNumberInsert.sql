if OBJECT_ID('FindByNumberInsert', 'P') is not null
    drop proc FindByNumberInsert
	 
go

/* --------------------------------------------------------
  FindByNumberInsert - добавление результата поиска в БД

-------------------------------------------------------- */
create proc FindByNumberInsert
               @ClientID                numeric(18, 0)
              ,@Available               nvarchar(128) 
              ,@bitOldNum               bit           
              ,@PercentSupped           int           
              ,@PriceId                 int           
              ,@Region                  nvarchar(256) 
              ,@Delivery                int           
              ,@Make                    nvarchar(10)  
              ,@DetailNum               nvarchar(64)  
              ,@PriceLogo               nvarchar(64)  
              ,@Price                   money               
              ,@PartNameRus             nvarchar(256) 
              ,@PartNameEng             nvarchar(256) 
              ,@WeightGr                money         
              ,@MakeName                nvarchar(64)  
              ,@Packing                 int           
              ,@bitECO                  bit           
              ,@bitWeightMeasured       bit           
              ,@VolumeAdd               money         
              ,@GuaranteedDay           nvarchar(64)        
as
set nocount on;

declare @RetVal       int

insert into pFindByNumber
       (Spid, ClientID, DestinationLogo, Available, bitOldNum, PercentSupped, PriceId, Region, Delivery, Make, DetailNum, PriceLogo, Price, PartNameRus, PartNameEng, WeightGr, MakeName, Packing, VolumeAdd, GuaranteedDay, bitECO, bitWeightMeasured)               
select  @@Spid
       ,@ClientID 
       ,null 
       ,@Available        
       ,@bitOldNum        
       ,@PercentSupped    
       ,@PriceId          
       ,@Region           
       ,@Delivery         
       ,@Make             
       ,@DetailNum        
       ,@PriceLogo        
       ,@Price                   
       ,@PartNameRus      
       ,@PartNameEng      
       ,@WeightGr         
       ,@MakeName         
       ,@Packing   
       ,@VolumeAdd        
       ,@GuaranteedDay   
       ,@bitECO           
       ,@bitWeightMeasured
       
exit_:
return @RetVal    
go
grant all on FindByNumberInsert to public
