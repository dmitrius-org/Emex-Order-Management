/*
if OBJECT_ID('tRestrictions') is not null
  drop table tRestrictions
--*/


INSERT INTO tParts (Brand, BrandName, DetailNum, DetailName, WeightKG, VolumeKG, DetailNameF, WeightKGF, VolumeKGf, NoAir, NLA, Fragile, UserID)
SELECT
       MakeLogo, 
       max(Brand), 
       DetailNum, 
       max(DetailName), 
       max(WeightKG), 
       max(VolumeKG), 
       max(DetailNameF), 
       max(WeightKGF), 
       max(VolumeKGf),
      CASE WHEN max(Restrictions) = 'NOAIR' THEN 1 ELSE 0 END,
      max(cast(NLA as int)), 
      max(cast(Fragile as int)), 
      1
 FROM testdb.dbo.tPrice (nolock)
where Restrictions='NOAIR'
group by MakeLogo, DetailNum



INSERT INTO tPrice 
      (PartID, PriceLogo, Quantity, PackQuantity, Reliability, DetailPrice, MOSA, isDelete)
SELECT p.PartID, t.PriceLogo, t.Quantity, t.PackQuantity, t.Reliability, t.DetailPrice, t.MOSA, 0 
  FROM tParts p (nolock)
  JOIN testdb.dbo.tPrice  t  (nolock)
    ON t.MakeLogo = p.Brand 
   AND t.DetailNum = p.DetailNum;




select * from tParts
select * from tPrice
