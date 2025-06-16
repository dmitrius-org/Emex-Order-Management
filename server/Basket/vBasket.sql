drop view if exists vBasket
go
/* **********************************************************						
vBasket - 
********************************************************** */
create view vBasket
as
select 
       t.BasketID         -- 
      ,t.ClientID         --
      ,p.SuppliersID
      ,t.Make             -- 
      ,t.MakeName         -- 
      ,t.DetailNum        -- 
      ,t.PartNameRus      -- 
      ,t.PriceLogo        -- 
      ,t.OurDelivery      -- наш срок поставки, показываем клиенту/срок поствки клиент
	  ,t.Quantity         -- 
      ,t.PriceRub         --
      ,t.Amount           -- 
      ,t.Packing          -- количество деталей в упаковке
      ,t.Comment2         -- комментарий
      ,(case 
              when datediff(hh, t.InDateTime, getdate()) >= 24 then 1
              else 0
            end ) IsUpdating -- прошло 24 часа, необходимо обновить цену

  from tBasket t (nolock)
  left join vClientProfilesParam p 
         on p.ProfilesCustomerID = t.ProfilesCustomerID
go
grant all on vBasket to public
go
exec setOV 'vBasket', 'V', '20250613', '11'
