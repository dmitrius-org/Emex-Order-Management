if OBJECT_ID('vPartHistory') is not null
    drop view vPartHistory
go
create view vPartHistory
/* **********************************************************						
vPartHistory - 
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
      ,UserID
      ,dateadd(hh, 3, UpDatetime) UpDatetime
      --,ValidTo
  from tParts for system_time all t with (nolock index=ao2) 

go
grant select on vPartHistory to public
go
exec setOV 'vPartHistory', 'V', '20250531', '25'
go
select * from vPartHistory
