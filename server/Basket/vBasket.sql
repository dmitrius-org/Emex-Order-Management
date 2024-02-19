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
      --,t.PartNameEng      -- 
      ,t.PriceLogo        -- 
      ,t.GuaranteedDay    -- 
      ,t.Quantity         -- 
     -- ,t.Price            -- 
      ,t.PriceRub
      ,t.Amount           -- 
     -- ,t.Reference        -- 
  from tBasket t (nolock)
go
grant all on vBasket to public
go
exec setOV 'vBasket', 'V', '20240101', '1.0.0.0'