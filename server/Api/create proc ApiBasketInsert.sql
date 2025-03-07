if OBJECT_ID('ApiBasketInsert', 'P') is not null
    drop proc ApiBasketInsert	 
go
/* --------------------------------------------------------
  ApiBasketInsert - 
-------------------------------------------------------- */
create proc ApiBasketInsert
               @ClientID     numeric(18, 0)
              ,@Brand        nvarchar(10)  
              ,@Number       nvarchar(64)  
              ,@SupplierCode nvarchar(120)     
              ,@ItemKey      nvarchar(256) 
              ,@Quantity     int           
              ,@Comment      varchar(256)  
              ,@BasketID     numeric(18, 0) out    
as
set nocount on;

declare @RetVal   int  = 0
       ,@tID      ID 
       ,@ID       numeric(18, 0) 

insert into pBasket with (rowlock)
       (Spid, 
        ClientID, 
        DetailNum, 
        MakeName, 
        Quantity, 
        ItemKey,
        Comment2,
        PriceLogo,
        ProfilesCustomerID,
        flag
        )      
 OUTPUT INSERTED.ID into @tID
 select @@Spid
       ,@ClientID 
       ,@Number
       ,@Brand
       ,@Quantity       
       ,@ItemKey        
       ,@Comment
       ,SUBSTRING(@SupplierCode, 0, CHARINDEX('-', @SupplierCode)) 
       ,SUBSTRING(@SupplierCode, CHARINDEX('-', @SupplierCode) +  1, len(@SupplierCode)) 
       ,0

select @ID= ID 
  from @tID

delete
  from @tID

insert tBasket with (rowlock) 
      (ClientID
      ,Make
      ,MakeName
      ,DetailNum
      ,PartNameRus
      --,PartNameEng
      ,PriceLogo
	  ,OurDelivery   -- срок поставки клиенту
      ,GuaranteedDay
      ,Quantity
      ,Price
      ,PriceRub
      ,Amount
   --  ,Reference
      ,WeightKG
      ,VolumeKG
      ,DestinationLogo
      ,ProfilesCustomerID
      ,PercentSupped
      
      ,Margin
      ,Discount
      ,Kurs
      ,ExtraKurs
      ,Commission
      ,Reliability
      ,Fragile            
      ,Flag   
      ,Packing
      ,Comment2
      ,ItemKey
      )
 OUTPUT INSERTED.BasketID into @tID
select @ClientID
      ,p.Make
	  ,p.MakeName
	  ,p.DetailNum
	  ,p.PartNameRus
	  ,p.PriceLogo
	  ,p.OurDelivery
	  ,p.GuaranteedDay
      ,b.Quantity  --((1 + p.Packing - 1) / p.Packing) * p.Packing -- Quantity
	  ,p.Price
	  ,p.PriceRub
	  ,b.Quantity  * p.PriceRub--((1 + p.Packing - 1) / p.Packing) * p.Packing  * p.PriceRub -- Amount
      ,p.WeightGr
      ,p.VolumeAdd
      ,p.DestinationLogo
      ,p.ProfilesCustomerID
      ,p.PercentSupped

      ,p.Margin
      ,p.Discount
      ,p.Kurs
      ,p.ExtraKurs
      ,p.Commission
      ,p.Reliability
      ,p.Fragile

      ,p.Flag

      ,p.Packing -- количество деталей в упаковке
      ,b.Comment2
      ,b.ItemKey
  from pBasket b (nolock)
 inner join pFindByNumber p with (nolock index=ao1)
         on p.Spid = @@Spid
        and p.ClientID           = b.ClientID
        and p.DetailNum          = b.DetailNum          
        and p.MakeName           = b.MakeName          
       -- and p.Quantity           = b.Quantity          
       -- and p.ItemKey            = b.ItemKey           
      --  and p.Comment2           = b.Comment2          
        and p.PriceLogo          = b.PriceLogo         
        and p.ProfilesCustomerID = b.ProfilesCustomerID
 where b.id = @ID

select @BasketID= ID 
  from @tID 
     
if isnull(@BasketID, 0) >0
begin
  Update b
     set b.BasketID = @BasketID
    from pBasket b (nolock)
   where b.id = @ID
end
--else
--begin
--end
	 -- not exists (select 1
	 --                  from tBasket t with (nolock index=PK_tBasket_BasketID)
		--			  where t.ClientID           = @ClientID
  --                      and t.Make               = p.Make
		--			    and t.DetailNum          = p.DetailNum
		--				and t.PriceLogo          = p.PriceLogo
  --                      and t.ProfilesCustomerID = p.ProfilesCustomerID -- способов доставки с одним номером может быть несколько, поэтому провер€ем по »ƒ
  --                   )
       
exit_:
return @RetVal    
go
grant exec on ApiBasketInsert to public
go
exec setOV 'ApiBasketInsert', 'P', '20240605', '0'
go
 