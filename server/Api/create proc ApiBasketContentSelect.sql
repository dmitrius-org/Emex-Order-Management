if OBJECT_ID('ApiBasketContentSelect', 'P') is not null
    drop proc ApiBasketContentSelect	 
go
/* --------------------------------------------------------
  ApiBasketContentSelect - Получать список товаров в корзине
-------------------------------------------------------- */
create proc ApiBasketContentSelect
               @ClientID     numeric(18, 0)
as
set nocount on;

declare @RetVal int  = 0

select
       t.BasketID         -- 
      ,t.ClientID         -- 
      ,t.Make             -- 
      ,t.MakeName         Brand-- 
      ,t.DetailNum        DetailNumber-- 
      ,t.PriceLogo + '-' + cast(t.ProfilesCustomerID as varchar) as SupplierCode
      ,t.ItemKey
      ,t.PartNameRus      DetailName-- 
      ,t.PriceRub         -- 
      ,t.OurDelivery      Delivery -- наш срок поставки, показываем клиенту/срок поствки клиент
	  ,t.Quantity         -- 
      ,t.Amount           -- 
      ,t.Packing          Packing-- количество деталей в упаковке
      ,t.Comment2         Comment-- комментарий     
      ,(case 
              when datediff(hh, t.InDateTime, getdate()) >= 24 then 0
              else 1
            end ) Status -- прошло 24 часа, необходимо обновить цену
      ,(case 
              when datediff(hh, t.InDateTime, getdate()) >= 24 then 'Прошло 24 часа, необходимо обновить цену'
              else ''
            end ) ErrorMessage -- прошло 24 часа, необходимо обновить цену
      

  from tBasket t with (nolock index=ao2)
 Where t.ClientID = @ClientID
       
exit_:
return @RetVal    
go
grant exec on ApiBasketContentSelect to public
go
exec setOV 'ApiBasketContentSelect', 'P', '20250321', '0'
go
