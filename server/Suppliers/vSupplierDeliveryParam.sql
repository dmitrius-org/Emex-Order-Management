if OBJECT_ID('vSupplierDeliveryParam') is not null
    drop view vSupplierDeliveryParam
go
/* **********************************************************
vSupplierDeliveryParam - 
********************************************************** */
create view vSupplierDeliveryParam
as

select s.SuppliersID
      ,s.Brief               as SuppliersBrief
      ,sd.ProfilesDeliveryID -- ссылка на профиль доставки
      ,sd.Name  ProfileName   -- 
      ,sd.Brief ProfileBrief  --

      ,sd.isActive           as SupplierProfileIsActive-- признак активности профиля на направлении
      ,sd.DestinationLogo
      ,sd.Delivery           as DeliveryTermFromSupplier -- срок доставки по направлению
      ,sd.DenVyleta          -- 
      
      ,sd.WeightKG           -- Стоимость кг 
      ,sd.VolumeKG           -- Стоимость v кг 

      ,sd.VolumeKG_Rate1     -- 1. Коэффициент на детали у которых [VolumeKG] строго меньше 10 кг
      ,sd.VolumeKG_Rate2     -- 2. Коэффициент на детали у которых [VolumeKG] от 10 кг включительно, но строго меньше 20 кг
      ,sd.VolumeKG_Rate3     -- 3. Коэффициент на детали у которых [VolumeKG] от 20 кг включительно, но строго меньше 25 кг
      ,sd.VolumeKG_Rate4     -- 4. Коэффициент на детали у которых [VolumeKG] от 25 кг включительно

      ,sd.Restrictions       -- ограничения
      ,sd.Fragile
      ,sd.Image
      ,sd.ImageHelp
      ,sd.isMyDelivery
      ,sd.isIgnore

  from tSupplierDeliveryProfiles sd with (nolock index=ao1) 
  left join tSuppliers s with (nolock index=ao1)
         on sd.SuppliersID = s.SuppliersID   

go
grant all on vSupplierDeliveryParam to public
go
exec setOV 'vSupplierDeliveryParam', 'V', '20250320', '1'
go
Select * from vSupplierDeliveryParam


select * from tSupplierDeliveryProfiles