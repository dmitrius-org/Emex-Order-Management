if OBJECT_ID('FindByNumberInsert', 'P') is not null
    drop proc FindByNumberInsert	 
go
/* --------------------------------------------------------
  FindByNumberInsert - добавление результата поиска в БД

Available     – наличие детали на складе
bitOldNum     – признак УСТАРЕВШИЙ НОМЕР
PercentSupped – процент поставки
PriceId       – идентификатор прайслиста
Region        – регион доставки детали
Delivery      – срок поставки
Make          – лого бренда детали
DetailNum     – номер детали
PriceLogo     – лого прайслиста
Price         – цена детали, показаваемая на сайте
PartNameRus   – русское название детали
PartNameEng   – английское название детали
WeightGr      – вес детали в граммах
MakeName      – название бренда
Packing       – количество деталей в упаковке
VolumeAdd     – наценка объем (объемный вес)
GuaranteedDay – гарантированный срок поставки детали
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
       ,@WeightGr / 1000         
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
go
exec setOV 'FindByNumberInsert', 'P', '20240101', '0'
go
 