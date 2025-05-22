if OBJECT_ID('PriceInsert') is not null
  drop proc  PriceInsert
go
/* **********************************************************
  PriceInsert  - Добавление прайса или детали при его отсутсвии
********************************************************** */
create proc PriceInsert
as
  -- если детали нет в нашей системе, то добавим его
  declare @Parts table -- тут детали 
         (PartID    numeric(18, 0)
         ,Brand     varchar(30)
         ,DetailNum varchar(128)
         );

  declare @Prices table -- тутпрайсы
         (PartID    numeric(18, 0)
         ,PriceID   numeric(18, 0)
         ,PriceLogo varchar(30)
         );

  insert into tParts with (rowlock) 
        (Brand 
        ,BrandName    
        ,DetailNum      
        ,DetailName       
        ,WeightKG     
        ,VolumeKG
        ,UserID) 
  OUTPUT INSERTED.PartID, INSERTED.Brand, INSERTED.DetailNum INTO @Parts(PartID, Brand, DetailNum)
  select distinct 
         p.Brand 
        ,m.Name
        ,p.DetailNum     
        ,p.PartNameRus --DetailName
        ,p.WeightKG
        ,case
           when p.VolumeKG = 0 then p.WeightKG
           else p.VolumeKG
         end 
        ,dbo.GetUserID()
    from #Price p (nolock)
    left join tParts pp with (nolock index=ao2) 
           on pp.Brand     = p.Brand
          and pp.DetailNum = p.DetailNum
    left join tMakes m with (nolock index=ao2) 
           on m.Code = p.Brand
   where pp.PartID is null


  Update p
     set p.PartID  = rp.PartID
    from #Price p
   inner join @Parts rp 
           on rp.Brand     = p.Brand
          and rp.DetailNum = p.DetailNum
   where p.PartID is null



  insert into tPrice with (rowlock) 
        (PartID
        ,PriceLogo
        ,isDelete) 
  OUTPUT INSERTED.PriceID, INSERTED.PartID, INSERTED.PriceLogo  INTO @Prices(PriceID, PartID, PriceLogo)
  select distinct 
         p.PartID
        ,p.PriceLogo  
        ,0
    from #Price p (nolock)
   where p.PriceID is null

  Update p
     set p.PriceID = rp.PriceID
    from #Price p
   inner join @Prices rp 
           on rp.PartID    = p.PartID 
          and rp.PriceLogo = p.PriceLogo
   where p.PriceID is null

exit_:
go
grant execute on PriceInsert to public
go
exec setOV 'PriceInsert', 'P', '20250531', '2'

