if OBJECT_ID('PartHistoryInsertByPartID') is not null
  drop proc PartHistoryInsertByPartID
go
/* **********************************************************
 PartHistoryInsertByPartID  - добавление/обновление данных по прайсам в БД
********************************************************** */
create proc PartHistoryInsertByPartID
	           @Prices ID readonly
as

insert into History.tPartsHistory with (rowlock)
      (     
       MakeLogo 
	  ,Brand    
      ,DetailNum	  
	  ,Restrictions
      ,DetailName	
      ,WeightKG	
      ,VolumeKG
      ,Fragile	
      ,UserID
      ,updDatetime
       ) 
--OUTPUT INSERTED.PriceID, INSERTED.MakeLogo, INSERTED.DetailNum INTO @ID(ID, MakeLogo, DetailNum)    
select distinct
       t.MakeLogo 
	  ,t.Brand    
      ,t.DetailNum	  
	  ,t.Restrictions
      ,isnull(t.DetailNameF	, t.DetailName)
      ,isnull(t.WeightKGF	, t.WeightKG)
      ,isnull(t.VolumeKGf	, t.VolumeKG)
      ,t.Fragile	
      ,dbo.GetUserID()
      ,t.updDatetime
  from @Prices p
 inner join tPrice t with (nolock index=ao1) 
         on p.ID = t.PriceID 
 outer apply (        
               select top 1 *
                 from History.tPartsHistory ph with (nolock index=ao1)
                where ph.DetailNum = t.DetailNum
				  and ph.MakeLogo  = t.MakeLogo
                order by t.updDatetime desc
		      ) ph
 where 1=1
   and not (
            coalesce(t.DetailNameF, t.DetailName, '') = isnull(ph.DetailName, '')
        and coalesce(t.WeightKGF	,t.WeightKG, 0)   = isnull(ph.WeightKG, 0)
        and coalesce(t.VolumeKGf	,t.VolumeKG, 0)   = isnull(ph.VolumeKG, 0)
        and coalesce(t.Restrictions, 0)               = isnull(ph.Restrictions, 0)
        and coalesce(t.Fragile, 0)                    = isnull(ph.Fragile, 0)

       )
exit_:
go
grant execute on PartHistoryInsertByPartID to public
go
exec setOV 'PartHistoryInsertByPartID', 'P', '20250220', '0'
