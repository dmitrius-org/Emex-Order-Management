if OBJECT_ID('ProfilesCustomerRefresh') is not null
    drop proc ProfilesCustomerRefresh
/*
  ProfilesCustomerRefresh - 

*/
go
create proc ProfilesCustomerRefresh
              @SuppliersID    numeric(18, 0)  
             ,@ClientID       numeric(18, 0)  
as
  set nocount on
  declare @r int

Declare @p as table 
       (
        ProfilesCustomerID  int            -- 
       ,ClientID            numeric(18, 0) -- Клиент   
       ,Brief               varchar(60)    --
       ,Margin              money          -- Наценка в процентах
       ,Reliability         money          -- Вероятность поставки 
       ,UploadFolder        varchar(255)   -- Каталог для сохранения прайс-файлов
       ,UploadPriceName     varchar(255)   -- 
       ,UploadFileName      varchar(255)   -- 
       ,isActive            bit
       ,ProfilesDeliveryID  int   
       ,ClientPriceLogo     nvarchar(32)   -- Наименование прайса клиента по которым заказываются детали
       ,UploadDelimiterID   int            -- разделитель 
       )

insert into @p
      (
       ProfilesCustomerID 
      ,ClientID           
      ,Brief              
      ,Margin             
      ,Reliability        
      ,UploadFolder       
      ,UploadPriceName    
      ,UploadFileName     
      ,isActive           
      ,ProfilesDeliveryID 
      ,ClientPriceLogo                    
      ,UploadDelimiterID  
      )
select pc.ProfilesCustomerID 
      ,pc.ClientID           
      ,pc.Brief              
      ,pc.Margin             
      ,pc.Reliability        
      ,pc.UploadFolder       
      ,pc.UploadPriceName    
      ,pc.UploadFileName     
      ,pc.isActive           
      ,pc.ProfilesDeliveryID 
      ,pc.ClientPriceLogo                    
      ,pc.UploadDelimiterID  
  from tClients c (nolock)
 inner join tProfilesCustomer pc (nolock)
         on pc.ClientID = c.ClientID 
 where c.ClientID = @ClientID

delete pProfilesCustomer from pProfilesCustomer (rowlock) where Spid = @@SPID 

insert pProfilesCustomer
      (Spid 
      ,ClientID          
      ,Brief              
      ,Margin            
      ,Reliability       
      ,UploadFolder      
      ,UploadPriceName   
      ,UploadFileName    
      ,isActive          
      ,ProfilesDeliveryID
      ,ClientPriceLogo   
      ,UploadDelimiterID )
select @@SPID
      ,c.ClientID           
      ,s.ProfileName              
      ,ct.Margin             
      ,ct.Reliability        
      ,p.UploadFolder       
      ,p.UploadPriceName    
      ,p.UploadFileName     
      ,s.SupplierProfileIsActive           
      ,s.ProfilesDeliveryID 
      ,p.ClientPriceLogo                    
      ,p.UploadDelimiterID  
  from tClients c (nolock)

 inner join vSupplierDeliveryParam s (nolock)
         on s.SuppliersID = @SuppliersID

 outer apply (select top 1 *
                from @p p
               where p.ClientID = C.ClientID 
                 and p.Brief = s.ProfileName 
               order by ProfilesCustomerID  desc) as p

 left join tClientType ct (nolock)
        on ct.ClientTypeID = c.ClientTypeID
 where c.ClientID = @ClientID

exit_:
return @r
go
grant exec on ProfilesCustomerRefresh to public
go
exec setOV 'ProfilesCustomerRefresh', 'P', '20250320', '2'
go