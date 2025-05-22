if OBJECT_ID('vPrice') is not null
    drop view vPrice
go
/* **********************************************************						
vPrice - получение списка заказов
********************************************************** */

create view vPrice

as

Select p.PriceID	
      ,p.PartID	
      ,p.PriceLogo	
      ,p.Quantity	
      ,p.PackQuantity	
      ,p.Reliability
      ,p.DetailPrice
      ,p.MOSA
      ,p.isDelete
      
      ,ps.Brand
      ,ps.BrandName
      ,ps.DetailNum
      ,ps.DetailName
      ,ps.WeightKG
      ,ps.VolumeKG
      ,ps.DetailNameF
      ,ps.WeightKGF
      ,ps.VolumeKGf
      ,ps.NoAir
      ,ps.NLA
      ,ps.Fragile
      --,ps.UserID
      --,ps.UpDatetime
      --,ps.ValidTo

  from tPrice p with (nolock)
 inner join vParts ps 
         on ps.PartID=p.PartID


go
grant select on vPrice to public
go
exec setOV 'vPrice', 'V', '20250531', '25'
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vOrders', @desc = 'Список заказов'

