if OBJECT_ID('ApiBasketDelete', 'P') is not null
    drop proc ApiBasketDelete	 
go
/* --------------------------------------------------------
  ApiBasketDelete - 
-------------------------------------------------------- */
create proc ApiBasketDelete
               @ClientID     numeric(18, 0)
              ,@Brand        nvarchar(10)  
              ,@Number       nvarchar(64)  
              ,@SupplierCode nvarchar(120)     
              ,@ItemKey      nvarchar(256) 
              ,@Quantity     int           
              ,@Comment      varchar(256)  
              ,@BasketID     numeric(18, 0) out
              ,@MSG          varchar(256) out
    
as
set nocount on;

declare @RetVal   int  = 0
       ,@tID      ID 
       ,@ID       numeric(18, 0) 


DELETE tBasket 
OUTPUT deleted.BasketID into @tID
  FROM tBasket (rowlock) 
 WHERE ClientID = @ClientID 
   AND DetailNum = @Number 
   and MakeName  = @Brand    
   AND PriceLogo          = SUBSTRING(@SupplierCode, 0, CHARINDEX('-', @SupplierCode)) 
   and ProfilesCustomerID = SUBSTRING(@SupplierCode, CHARINDEX('-', @SupplierCode) +  1, len(@SupplierCode)) 
   and ItemKey = @ItemKey

   and @Quantity = 0

select @BasketID= ID 
  from @tID 
     
if isnull(@BasketID, 0) >0
begin
  select @RetVal = 0
end
else
begin
  select @RetVal = 705 
        ,@MSG = 'Деталь не найдена в корзине!'
end

exit_:
return @RetVal    
go
grant exec on ApiBasketDelete to public
go
exec setOV 'ApiBasketDelete', 'P', '20240605', '0'
go
 