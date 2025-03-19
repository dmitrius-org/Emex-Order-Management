if OBJECT_ID('ApiFindByNumberSelect', 'P') is not null
    drop proc ApiFindByNumberSelect	 
go
/* --------------------------------------------------------
  ApiFindByNumberSelect - 

-------------------------------------------------------- */
create proc ApiFindByNumberSelect   
as
set nocount on;

declare @RetVal int  = 0

SELECT 
    MakeName,                      -- Имя производителя
    DetailNum,                     -- Код детали
    PartNameRus,                   -- Описание детали
    CASE 
        WHEN Available=-1 THEN -10 --Под заказ
        WHEN Available IS NULL THEN ''
        ELSE CAST(Available as VARCHAR)
    END AS Available,              -- Наличие на складе
    Packing,                        -- Минимальная партия для заказа (необязательно)
    OurDelivery,                    -- Срок поставки
    PriceRub,                       -- Цена
    CAST(0 AS BIT) as ReturnSign,   -- Признак возврата (необязательно)    
    PriceLogo + '-' + cast(ProfilesCustomerID as varchar) as SupplierID       -- Идентификатор поставщика (ID склада)
    
FROM vFindByNumber

exit_:
return @RetVal    
go
grant exec on ApiFindByNumberSelect to public
go
exec setOV 'ApiFindByNumberSelect', 'P', '20250303', '0'
go
 