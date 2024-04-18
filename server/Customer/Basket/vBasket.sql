if OBJECT_ID('vBasket') is not null
    drop view vBasket
go
/* **********************************************************						
vBasket - 
********************************************************** */
create view vBasket
as
select 
       t.BasketID         -- 
      ,t.ClientID         -- 
      ,t.Make             -- 
      ,t.MakeName         -- 
      ,t.DetailNum        -- 
      ,t.PartNameRus      -- 
      ,t.PriceLogo        -- 
      ,t.OurDelivery      -- наш срок поставки, показываем клиенту
	  ,t.Quantity         -- 
      ,t.PriceRub
      ,t.Amount           -- 
  from tBasket t (nolock)
go
grant all on vBasket to public
go
exec setOV 'vBasket', 'V', '20240403', '1'