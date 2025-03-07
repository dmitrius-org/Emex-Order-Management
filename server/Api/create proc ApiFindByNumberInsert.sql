if OBJECT_ID('ApiFindByNumberInsert', 'P') is not null
    drop proc ApiFindByNumberInsert	 
go
/* --------------------------------------------------------
  ApiFindByNumberInsert - добавление результата поиска в БД

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
create proc ApiFindByNumberInsert
               @ClientID                numeric(18, 0)
              ,@Available               nvarchar(128) = null
              ,@bitOldNum               bit           = null
              ,@PercentSupped           int           = null
              ,@PriceId                 int           = null
              ,@Region                  nvarchar(256) = null
              ,@Delivery                int           = null
              ,@Make                    nvarchar(10)  = null
              ,@DetailNum               nvarchar(64)  = null
              ,@PriceLogo               nvarchar(64)  = null
              ,@Price                   money         = null      
              ,@PartNameRus             nvarchar(256) = null
              ,@PartNameEng             nvarchar(256) = null
              ,@WeightGr                money         = null
              ,@MakeName                nvarchar(64)  = null
              ,@Packing                 int           = null
              ,@bitECO                  bit           = null
              ,@bitWeightMeasured       bit           = null
              ,@VolumeAdd               money         = null
              ,@GuaranteedDay           nvarchar(64)  = null      
as
set nocount on;

declare @RetVal       int  = 0

insert into pFindByNumber with (rowlock)
       (Spid, 
        ClientID, 
        DestinationLogo, 
        ProfilesCustomerID,
        Available, 
        bitOldNum, 
        PercentSupped, 
        PriceId, 
        Region, 
        Delivery, 
        Make,
        DetailNum, 
        PriceLogo, 
        Price, 
        PartNameRus, 
        PartNameEng, 
        WeightGr, 
        MakeName, 
        Packing, 
        VolumeAdd, 
        GuaranteedDay, 
        bitECO, 
        bitWeightMeasured,
        flag
        )               
select  @@Spid
       ,@ClientID 
       ,sd.DestinationLogo 
       ,pc.ProfilesCustomerID
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
       ,isnull(@WeightGr, 0) / 1000         
       ,@MakeName         
       ,@Packing   
       ,@VolumeAdd        
       ,@GuaranteedDay   
       ,@bitECO           
       ,@bitWeightMeasured
       ,0
   from tProfilesCustomer pc (nolock)
  inner join tSupplierDeliveryProfiles sd (nolock) 
          on sd.ProfilesDeliveryID = pc.ProfilesDeliveryID
  where pc.ClientID = @ClientID
    and pc.isActive = 1


--exec SearchPriceCalc
--       @ProfilesCustomerID=:ProfilesCustomerID,
--       @DetailNum         =:DetailNum
       
exit_:
return @RetVal    
go
grant exec on ApiFindByNumberInsert to public
go
exec setOV 'ApiFindByNumberInsert', 'P', '20240605', '0'
go
 