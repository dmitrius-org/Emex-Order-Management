if OBJECT_ID('vParts') is not null
    drop view vParts
go
create view vParts
/* **********************************************************						
vParts - 
********************************************************** */
as

Select PartID
      ,Brand
      ,BrandName
      ,DetailNum
      ,DetailName
      ,WeightKG
      ,VolumeKG
      ,DetailNameF
      ,WeightKGF
      ,VolumeKGf
      ,NoAir
      ,NLA
      ,Fragile
      --,UserID
      --,UpDatetime
      --,ValidTo
  from tParts with (nolock)-- index=ao2) 

go
grant select on vParts to public
go
exec setOV 'vParts', 'V', '20250531', '25'
go
-- Описание таблицы
--exec dbo.sys_setTableDescription @table = 'vOrders', @desc = 'Список заказов'

