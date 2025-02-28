if OBJECT_ID('PriceUpdate') is not null
  drop proc PriceUpdate
go
/* **********************************************************
 PriceUpdate  - добавление/обновление данных по прайсам в БД
********************************************************** */
create proc PriceUpdate
as
declare @PriceLogo         varchar(30)    -- Название прайса 

declare @ID as table (
        ID numeric(18, 0) primary key
       ,MakeLogo	 varchar(30)
       ,DetailNum	 varchar(40)
       )

select top 1
       @PriceLogo = PriceLogo
  from #Price with (nolock index=ao3)

if isnull(@PriceLogo, '') = ''
  goto exit_

update p
   set p.DetailName = pd.Name_RUS -- Русские наименования    
  from tPartDescription  pd  with (nolock index=ao2)     
 Inner join #Price p with (updlock) -- unique index ao3 on  [#Price] (PriceLogo, DetailNum, MakeLogo);
         on p.DetailNum = pd.Number
        and p.MakeLogo  = pd.Make

update t
   set t.DetailPrice  = p.DetailPrice
	  ,t.DetailName   = p.DetailName  
	  ,t.PriceLogo    = rtrim(p.PriceLogo)
	  ,t.Quantity     = iif(p.Quantity = 0, 999, p.Quantity)  
	  ,t.PackQuantity = p.PackQuantity
	  ,t.Reliability  = p.Reliability -- Вероятность поставки 
	  ,t.WeightKG     = p.WeightKG
  	  ,t.VolumeKG	  = case
                          when p.VolumeKG = 0 
                            then p.WeightKG
                            else p.VolumeKG
                        end
	  ,t.MOSA         = p.MOSA
	  ,t.Restrictions = isnull(t.Restrictions, nullif(p.Restrictions, ''))
      ,t.updDatetime  = GetDate()
OUTPUT INSERTED.PriceID, INSERTED.MakeLogo, INSERTED.DetailNum INTO @ID(ID, MakeLogo, DetailNum)      
  from #Price p with (nolock index=ao3)       
 inner join tPrice t with (updlock index=ao3) 
         on t.PriceLogo = @PriceLogo
	    and t.DetailNum = p.DetailNum
	    and t.MakeLogo  = p.MakeLogo

insert into tPrice with (rowlock)
      (     
       MakeLogo 
	  ,Brand    
      ,DetailNum	  
      ,DetailPrice  
      ,DetailName	  
      ,PriceLogo    
      ,Quantity     
      ,PackQuantity 
      ,Reliability  -- Вероятность поставки
      ,WeightKG     
      ,VolumeKG 
	  ,MOSA  
	  ,Restrictions
       ) 
OUTPUT INSERTED.PriceID, INSERTED.MakeLogo, INSERTED.DetailNum INTO @ID(ID, MakeLogo, DetailNum)    
select p.MakeLogo 
	  ,m.Name      -- наименование бренда     
	  ,p.DetailNum	  
	  ,p.DetailPrice  
	  ,p.DetailName	  
	  ,rtrim(p.PriceLogo)
	  ,iif(p.Quantity = 0, 999, p.Quantity)    -- если количество равно 0, то ставим 999
	  ,p.PackQuantity 
	  ,p.Reliability  -- Вероятность поставки
	  ,p.WeightKG     
  	  ,case
         when p.VolumeKG = 0 
           then p.WeightKG
           else p.VolumeKG
       end
	  ,p.MOSA  
	  ,nullif(p.Restrictions, '')
  from tMakes m with (nolock index=ao2)  
 inner join #Price p with (nolock index=ao2) 
         on p.MakeLogo = m.Code  
 where not exists (select 1
                     from tPrice t with (nolock index=ao3)
                    where t.PriceLogo = @PriceLogo
					  and t.DetailNum = p.DetailNum
					  and t.MakeLogo  = p.MakeLogo
				   )

delete p
  from tPrice p with (rowlock index=ao3)
 where p.PriceLogo = @PriceLogo    
   and isnull(p.WeightKGF  , '') = ''
   and isnull(p.VolumeKGf  , '') = ''
   and isnull(p.DetailNameF, '') = ''
   and isnull(p.Restrictions, '') = ''
  -- and isnull(p.Fragile, 0) = 0
   and isnull(p.NLA, 0) = 0
   and not exists (select 1
                     from @ID t
					where t.ID = p.PriceID)	
   and not exists (select 1
                     from tOrders o (nolock)
                    where o.PriceID = p.PriceID)

declare @P as table (
        PriceID      numeric(18, 0) primary key
       ,WeightKGF    float
       ,VolumeKGf    float   
       ,DetailNameF	 nvarchar(1024)
       ,Fragile   	 bit 
       ,NLA       	 bit 
       )

insert @P 
      (PriceID, WeightKGF, VolumeKGf, DetailNameF, Fragile, NLA)  
select t.ID
      ,pp.WeightKGF
	  ,pp.VolumeKGf
      ,pp.DetailNameF
      ,pp.Fragile
      ,pp.NLA
  from @ID as t
 cross apply (select top 1
                     pr.WeightKGF, 
                     pr.VolumeKGf,
                     pr.PriceID,
                     pr.DetailNameF,
                     pr.Fragile,
                     pr.NLA
                from tPrice pr with (nolock index=ao2) 
               where pr.DetailNum = t.DetailNum
	             and pr.MakeLogo  = t.MakeLogo
                 and ( isnull(pr.WeightKGF, 0) > 0
                    or isnull(pr.VolumeKGf, 0) > 0 
                    or isnull(pr.NLA, 0)       > 0)
               order by isnull(pr.WeightKGF, 0) desc , isnull(pr.Fragile, 0), isnull(pr.NLA, 0) desc
             ) as pp


---
update t
   set t.WeightKGF   = p.WeightKGF
	  ,t.VolumeKGf   = p.VolumeKGf    
      ,t.DetailNameF = p.DetailNameF
      ,t.Fragile     = p.Fragile
      ,t.NLA         = p.NLA
  from @P as p
 inner join tPrice t with (updlock index=ao1) 
         on t.PriceID = p.PriceID

Update p
   set p.Reliability  = 0 
  from tPrice p with (updlock index=ao3)
 where p.PriceLogo = @PriceLogo    
   and (isnull(p.WeightKGF  , '') <> ''
     or isnull(p.VolumeKGf  , '') <> ''
     or isnull(p.DetailNameF, '') <> ''
	 or exists (select 1
                  from tOrders o (nolock)
                 where o.PriceID = p.PriceID)
	 )
   and not exists (select 1
                     from @ID t
					where t.ID = p.PriceID)	
			
-- сохранение сведений об обновлении прайса
if not exists (select 1
                 from tProfilesPrice (nolock)
                where PriceName = @PriceLogo)
begin
  insert tProfilesPrice with (rowlock)
        (isActive, PriceName, UpdateDate)
  select 1, @PriceLogo, GetDate()
end
begin
  update tProfilesPrice
     set UpdateDate=GetDate()
   where PriceName=@PriceLogo
     --and isActive = 1
end


exit_:
go
grant execute on PriceUpdate to public
go
exec setOV 'PriceUpdate', 'P', '20250228', '4'
