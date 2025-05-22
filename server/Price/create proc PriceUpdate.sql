if OBJECT_ID('PriceUpdate') is not null
  drop proc PriceUpdate
go
/* **********************************************************
 PriceUpdate  - добавление/обновление данных по прайсам в БД
********************************************************** */
create proc PriceUpdate
as
SET NOCOUNT ON;

declare @PriceLogo         varchar(30)    -- Название прайса 

declare @ID as table (
        ID numeric(18, 0) primary key
       ,Brand     	      varchar(30)
       ,DetailNum	      varchar(40)
       )


select top 1 @PriceLogo = PriceLogo from pPrice with (nolock)

if isnull(@PriceLogo, '') = ''
  goto exit_

update p
   set p.DetailName = pd.Name_RUS -- Русские наименования    
  from tPartDescription  pd  with (nolock index=ao2)     
 Inner join pPrice p with (updlock INDEX=ao2)
         on p.Brand     = pd.Make
        and p.DetailNum = pd.Number

/*
UPDATE t
   SET t.DetailName   = p.DetailName,
       t.WeightKG     = p.WeightKG,
       t.VolumeKG     = case
                          when isnull(p.VolumeKG, 0) = 0 
                            then p.WeightKG
                            else p.VolumeKG
                        end,
       t.NoAir        = case 
                          when p.Restrictions = 'NOAIR' then 1
                          else 0
                        end,
       t.UserID     = dbo.getuserid()
       
--OUTPUT INSERTED.PartID, 
--       INSERTED.Brand, 
--       INSERTED.DetailNum INTO @ID (ID, Brand, DetailNum)
  FROM pPrice p WITH (NOLOCK INDEX=ao2)
 --INNER JOIN tPartDescription  pd  with (nolock index=ao2)     
 --        on p.Brand     = pd.Make
 --       and p.DetailNum = pd.Number
 INNER JOIN tParts t WITH (UPDLOCK INDEX=ao2)
         ON t.Brand     = p.Brand
        AND t.DetailNum = p.DetailNum
       
        AND (t.DetailName<>p.DetailName
          or t.WeightKG  < p.WeightKG 
          or t.VolumeKG  < case
                             when p.VolumeKG = 0 
                               then p.WeightKG
                               else p.VolumeKG
                           end
           or t.NoAir    <>case 
                             when p.Restrictions = 'NOAIR' then 1
                             else 0
                           end   
         )



-- Вставка новых записей, если их нет в tParts
INSERT INTO tParts (
       Brand,
       BrandName,
       DetailNum,
       DetailName,
       WeightKG,
       VolumeKG,
       NoAir,
       UserID)
SELECT p.Brand,
       m.Name,--BrandName
       p.DetailNum,
       p.DetailName,
       p.WeightKG,
       case
         when p.VolumeKG = 0 
           then p.WeightKG
           else p.VolumeKG
       end,
       case 
         when p.Restrictions = 'NOAIR' then 1
         else 0
       end,
       dbo.getuserid()   
  FROM pPrice p  WITH (NOLOCK INDEX=ao2)
 --INNER JOIN tPartDescription  pd  with (nolock index=ao2)     
 --        on p.Brand     = pd.Make
 --       and p.DetailNum = pd.Number
 inner join tMakes m WITH (NOLOCK INDEX=ao2) 
         ON m.Code = p.Brand
  LEFT JOIN tParts t WITH (NOLOCK INDEX=ao2)
         ON t.Brand     = p.Brand
        AND t.DetailNum = p.DetailNum
 WHERE t.PartID IS NULL;  -- Если записи нет в tParts, то t.PartID будет NULL
--*/
/*
-- 2. Временная таблица для новых записей в tParts
IF OBJECT_ID('tempdb..#newParts') IS NOT NULL DROP TABLE #newParts;
SELECT p.Brand, m.Name AS BrandName, p.DetailNum, p.DetailName,
       p.WeightKG,
       CASE WHEN ISNULL(p.VolumeKG, 0) = 0 THEN p.WeightKG ELSE p.VolumeKG END AS VolumeKG,
       CASE WHEN p.Restrictions = 'NOAIR' THEN 1 ELSE 0 END AS NoAir,
       dbo.getuserid() AS UserID
  INTO #newParts
  FROM pPrice p WITH (NOLOCK INDEX=ao2)
 INNER JOIN tMakes m WITH (NOLOCK INDEX=ao2) 
         ON m.Code = p.Brand
  LEFT JOIN tParts t WITH (NOLOCK INDEX=ao2)
         ON t.Brand = p.Brand AND t.DetailNum = p.DetailNum
WHERE t.PartID IS NULL;
print 3
print(convert(varchar, getdate(), 114)) 
-- 3. Вставка новых записей в tParts
INSERT INTO tParts WITH (ROWLOCK)
      (Brand, BrandName, DetailNum, DetailName, WeightKG, VolumeKG, NoAir, UserID)
SELECT Brand, BrandName, DetailNum, DetailName, WeightKG, VolumeKG, NoAir, UserID
  FROM #newParts (nolock)
print 4
print(convert(varchar, getdate(), 114)) 
-- 4. Обновление существующих записей в tParts
UPDATE t
   SET t.DetailName = p.DetailName,
       t.WeightKG   = p.WeightKG,
       t.VolumeKG   = CASE 
                        WHEN p.VolumeKG = 0 
                        THEN p.WeightKG 
                        ELSE p.VolumeKG 
                      END,
       t.NoAir      = CASE 
                        WHEN p.Restrictions = 'NOAIR' 
                        THEN 1
                        ELSE 0 
                      END,
       t.UserID     = dbo.getuserid()
  FROM tParts t WITH (UPDLOCK INDEX=ao2)
 INNER JOIN pPrice p WITH (NOLOCK INDEX=ao2)
         ON t.Brand     = p.Brand 
        AND t.DetailNum = p.DetailNum
 WHERE t.DetailName <> p.DetailName
    OR t.WeightKG < p.WeightKG
    OR t.VolumeKG < CASE WHEN p.VolumeKG = 0 THEN p.WeightKG ELSE p.VolumeKG END
    OR t.NoAir <> CASE WHEN p.Restrictions = 'NOAIR' THEN 1 ELSE 0 END;
--*/

MERGE tParts AS target
USING (
    SELECT 
           p.Brand,
           m.Name AS BrandName,
           p.DetailNum,
           p.DetailName,--isnull(pd.Name_RUS, p.DetailName) as DetailName,
           p.WeightKG,
           CASE WHEN ISNULL(p.VolumeKG, 0) = 0 THEN p.WeightKG ELSE p.VolumeKG END AS VolumeKG,
           CASE WHEN p.Restrictions = 'NOAIR' THEN 1 ELSE 0 END AS NoAir,
           dbo.getuserid() AS UserID
      FROM pPrice p WITH (NOLOCK INDEX=ao2)
     INNER JOIN tMakes m WITH (NOLOCK INDEX=ao2) 
             ON m.Code = p.Brand
      --left JOIN tPartDescription  pd  with (nolock index=ao2)     
      --       on p.Brand     = pd.Make
      --      and p.DetailNum = pd.Number
) AS source
 ON target.Brand     = source.Brand 
AND target.DetailNum = source.DetailNum

WHEN MATCHED AND (
                   target.DetailName <> source.DetailName
                OR target.WeightKG < source.WeightKG
                OR target.VolumeKG < source.VolumeKG
                OR target.NoAir <> source.NoAir
                ) THEN
    UPDATE 
       SET DetailName = source.DetailName,
           WeightKG   = source.WeightKG,
           VolumeKG   = source.VolumeKG,
           NoAir      = source.NoAir,
           UserID     = source.UserID

WHEN NOT MATCHED THEN
    INSERT (Brand, BrandName, DetailNum, DetailName, WeightKG, VolumeKG, NoAir, UserID)
    VALUES (source.Brand, 
            source.BrandName, 
            source.DetailNum, 
            source.DetailName, 
            source.WeightKG, 
            source.VolumeKG, 
            source.NoAir, 
            source.UserID);

UPDATE p
   SET p.PartID = t.PartID      
  FROM pPrice p WITH (UPDLOCK INDEX=ao2)
 INNER JOIN tParts t WITH (NOLOCK INDEX=ao2)
         ON t.Brand     = p.Brand
        AND t.DetailNum = p.DetailNum

delete from @ID
-- Использование MERGE с подзапросом в секции USING

MERGE INTO tPrice t
USING (
        SELECT
               PartID,
               PriceLogo,
               IIF(Quantity = 0, 999, Quantity) AS Quantity,
               PackQuantity,
               Reliability,
               DetailPrice,
               MOSA
          FROM pPrice WITH (NOLOCK INDEX=ao1)
       ) source
     ON t.PriceLogo = source.PriceLogo 
    AND t.PartID    = source.PartID

-- Обновление существующих записей
WHEN MATCHED THEN
    UPDATE SET
        t.Quantity     = source.Quantity,
        t.PackQuantity = source.PackQuantity,
        t.Reliability  = source.Reliability,
        t.DetailPrice  = source.DetailPrice,
        t.MOSA         = source.MOSA,
        t.UpDateTime   = GETDATE(),
        t.IsDelete     = 0

-- Вставка новых записей
WHEN NOT MATCHED BY TARGET THEN
    INSERT (PartID, PriceLogo, Quantity, PackQuantity, Reliability, DetailPrice, MOSA, IsDelete)
    VALUES (
            source.PartID,
            source.PriceLogo,
            source.Quantity,
            source.PackQuantity,
            source.Reliability,
            source.DetailPrice,
            source.MOSA,
            0
        );


--update t
--   set t.Quantity     = iif(p.Quantity = 0, 999, p.Quantity)  
--	  ,t.PackQuantity = p.PackQuantity
--	  ,t.Reliability  = p.Reliability -- Вероятность поставки 
--	  ,t.MOSA         = p.MOSA
--      ,t.UpDateTime   = GetDate()
--      ,t.IsDelete     = 0
--OUTPUT INSERTED.PartID INTO @ID(ID)      
--  from pPrice p with (nolock index=ao1)       
-- inner join tPrice t with (updlock index=ao2) 
--         on t.PriceLogo  = p.PriceLogo
--        and t.PartID     = p.PartID	 
--print 7
--print(convert(varchar, getdate(), 114)) 
--insert into tPrice with (rowlock)
--      (PartID 
--	  ,PriceLogo    
--      ,Quantity     
--      ,PackQuantity 
--      ,Reliability  -- Вероятность поставки
--	  ,MOSA
--      ,isDelete) 
--OUTPUT INSERTED.PartID INTO @ID(ID)    
--select p.PartID 
--	  ,p.PriceLogo   
--	  ,iif(p.Quantity = 0, 999, p.Quantity)    -- если количество равно 0, то ставим 999
--	  ,p.PackQuantity 
--	  ,p.Reliability  -- Вероятность поставки
--	  ,p.MOSA 
--      ,0
--  from pPrice p with (nolock index=ao1)      
-- where not exists (select 1
--                     from tPrice t with (nolock index=ao2)
--                    where t.PriceLogo = p.PriceLogo
--                      and t.PartID    = p.PartID)


--*/
Update t
   set t.isDelete = 1
  from tPrice t with (updlock index=ao2)
 where t.PriceLogo = @PriceLogo    
   and not exists (select 1
                     from pPrice p (nolock)
					where p.PartID = t.PartID)	

-- сохранение сведений об обновлении прайса
if not exists (select 1
                 from tProfilesPrice with (nolock index=ao2)
                where PriceName = @PriceLogo)
begin
  insert tProfilesPrice with (rowlock)
        (isActive, PriceName, UpdateDate)
  select 1, @PriceLogo, GetDate()
end
begin
  update tProfilesPrice
     set UpdateDate = GetDate()
   where PriceName = @PriceLogo
end

--*/

exit_:
go
grant execute on PriceUpdate to public
go
exec setOV 'PriceUpdate', 'P', '20250531', '5'
