if OBJECT_ID('PartHistoryInsertByPartID') is not null
  drop proc PartHistoryInsertByPartID
go
if OBJECT_ID('PartHistoryInsert') is not null
  drop proc PartHistoryInsert
go
/* **********************************************************
 PartHistoryInsert  - добавление/обновление данных по прайсам в БД
********************************************************** */
create proc PartHistoryInsert
as
-- удалим если нет изменений
DELETE FROM #PartsUpdate
 WHERE isnull(DetailName  ,'') = isnull(DetailNameOld  ,'')
   AND isnull(WeightKG    ,0)  = isnull(WeightKGOld    ,0)
   AND isnull(VolumeKG    ,0)  = isnull(VolumeKGOld    ,0)
   AND isnull(Restrictions,'') = isnull(RestrictionsOld,'')
   AND isnull(Fragile     ,0)  = isnull(FragileOld     ,0)
   AND isnull(NLA         ,0)  = isnull(NLAOld         ,0)

-- удалим дубли, т.к. в #PartsUpdate могут быть несколько прайсов одним и тем же номером детали
;WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY 
               DetailNum, MakeLogo, Brand, DetailName, WeightKG, VolumeKG, Restrictions, Fragile, NLA,
               /*DetailNumOld, MakeLogoOld, BrandOld,*/ DetailNameOld, WeightKGOld, VolumeKGOld, RestrictionsOld, FragileOld, NLAOld
               ORDER BY (SELECT NULL)) AS rn
    FROM #PartsUpdate
)
DELETE FROM CTE WHERE rn > 1;

if not exists (select 1
                 from #PartsUpdate pu (nolock)
                inner join tParts u (nolock)
                        on u.MakeLogo  = pu.MakeLogo
                       and u.DetailNum = pu.DetailNum
              )
begin
  insert into tParts with (rowlock)
        (MakeLogo 
  	    ,Brand    
        ,DetailNum	  
  	    ,Restrictions
        ,DetailName	
        ,WeightKG	
        ,VolumeKG
        ,Fragile	
        ,NLA
        ,UserID
        ,InDatetime) 
  select distinct
         p.MakeLogo
  	    ,p.Brand    
        ,p.DetailNum	  
  	    ,p.RestrictionsOld
        ,p.DetailNameOld
        ,p.WeightKGOld
        ,p.VolumeKGOld
        ,p.FragileOld	
        ,p.NLAOld
        ,dbo.GetUserID()
        ,p.InDatetime
    from #PartsUpdate p (nolock)

end

update u
   set u.MakeLogo      = pu.MakeLogo
      ,u.Brand         = pu.Brand
      ,u.DetailNum     = pu.DetailNum
      ,u.Restrictions  = pu.Restrictions
      ,u.DetailName    = pu.DetailName
      ,u.WeightKG      = pu.WeightKG
      ,u.VolumeKG      = pu.VolumeKG
      ,u.Fragile       = pu.Fragile
      ,u.NLA           = pu.NLA
      ,u.UserID        = dbo.GetUserID()
      ,u.InDatetime    = pu.updDatetime
  from #PartsUpdate pu (nolock)
 inner join tParts u (updlock)
         on u.MakeLogo  = pu.MakeLogo
        and u.DetailNum = pu.DetailNum
exit_:
go
grant execute on PartHistoryInsert to public
go
exec setOV 'PartHistoryInsert', 'P', '20250227', '1'
