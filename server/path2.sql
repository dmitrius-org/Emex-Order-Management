/*
if OBJECT_ID('tRestrictions') is not null
  drop table tRestrictions
--*/


INSERT INTO tParts with (tablock)
      (Brand, BrandName, DetailNum, DetailName, WeightKG, VolumeKG, DetailNameF, WeightKGF, VolumeKGf, NoAir, NLA, Fragile, UserID) 
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
 FROM tPrice2 (nolock)
group by MakeLogo, DetailNum


SET IDENTITY_INSERT tPrice ON;
INSERT INTO tPrice with (tablock)
      (PriceID, PartID, PriceLogo, Quantity, PackQuantity, Reliability, DetailPrice, MOSA, isDelete)
SELECT t.PriceID, p.PartID, t.PriceLogo, t.Quantity, t.PackQuantity, t.Reliability, t.DetailPrice, t.MOSA, 0 
  FROM tParts p (nolock)
  JOIN tPrice2  t  (nolock)
    ON t.MakeLogo = p.Brand 
   AND t.DetailNum = p.DetailNum;

SET IDENTITY_INSERT tPrice OFF;


select Count(*) from tParts (nolock);
select Count(*) from tPrice (nolock);
