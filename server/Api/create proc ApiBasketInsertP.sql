if OBJECT_ID('ApiBasketInsertP', 'P') is not null
    drop proc ApiBasketInsertP	 
go
/* --------------------------------------------------------
  ApiBasketInsertP - 
-------------------------------------------------------- */
create proc ApiBasketInsertP
               @ClientID     numeric(18, 0)
              ,@Brand        nvarchar(10)  
              ,@Number       nvarchar(64)  
              ,@SupplierCode nvarchar(120)     
              ,@ItemKey      nvarchar(256) 
              ,@Quantity     int           
              ,@Comment      varchar(256)  
    
as
set nocount on;

declare @RetVal       int  = 0

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
select  @@Spid
       ,@ClientID 
       ,@Number
       ,@Brand
       ,@Quantity       
       ,@ItemKey        
       ,@Comment
       ,SUBSTRING(@SupplierCode, 0, CHARINDEX('-', @SupplierCode)) 
       ,SUBSTRING(@SupplierCode, CHARINDEX('-', @SupplierCode) +  1, len(@SupplierCode)) 
       ,0
       
exit_:
return @RetVal    
go
grant exec on ApiBasketInsertP to public
go
exec setOV 'ApiBasketInsertP', 'P', '20240605', '0'
go
 