drop proc if exists ShipmentsSelect
                     
/*
  ShipmentsSelect - начитка данных для формы отгрузки

*/
go
create proc ShipmentsSelect
              @TransporterNumber nvarchar(64) = null
             ,@Invoice           varchar(64)  = null
             ,@ShipmentsDate     datetime     = null
             ,@BoxNumber         int          = null
             ,@SupplierIdList    varchar(255) = null
             ,@StatusIdList      varchar(255) = null
as
set nocount on;
declare @r  int = 0

declare @Suppliers as ID
declare @Status    as ID

-- Плановые отгрузки
exec ShipmentsPlanned

select @ShipmentsDate     = nullif(@ShipmentsDate, '')
      ,@TransporterNumber = nullif(@TransporterNumber, '')
      ,@Invoice           = nullif(@Invoice, '')
      ,@BoxNumber         = nullif(@BoxNumber , '')
 
if @SupplierIdList <> ''    
  INSERT INTO @Suppliers (ID)
  SELECT CAST(value AS NUMERIC(18, 0))
    FROM STRING_SPLIT(@SupplierIdList, ',');

if @StatusIdList <> ''    
  INSERT INTO @Status (ID)
  SELECT CAST(value AS NUMERIC(18, 0))
    FROM STRING_SPLIT(@StatusIdList, ',');

select *
  from (
SELECT s.ShipmentsID
      ,s.ShipmentsDate               -- дата отгрузки
      ,s.ReceiptDate                 -- ожидаемая жата поступления (расчетное поле)
      ,s.ReceiptDate2
      ,s.Invoice                     -- номер инвойса
      ,s.DestinationLogo             -- тип отправки
      ,s.DestinationName
      ,s.ShipmentsAmount             -- сумма отгрузки в долларах
      ,s.ShipmentsAmountR            -- сумма отгрузки в рублях
      ,s.DetailCount                 -- количество деталей
      ,s.WeightKG                    -- вес физический (по прайсу)
      ,s.VolumeKG                    -- вес объемный (по прайсу)
      ,s.WeightKGDiff                -- указать разницу сумм вес физический факт минус вес физический из
      ,s.WeightKGF                   -- сумма вес физический факт
      ,s.VolumeKGF                   -- сумма вес объемный факт
      ,s.VolumeKGDiff                -- указать разницу сумм вес объемный факт минус вес объемный из прайса 
      ,s.Amount                      -- Расчетная стоимость доставки по весам из прайса
      ,s.AmountF                     -- Фактическая стоимость доставки (по весам факт)
      ,s.SupplierWeightKG            -- "вес физ инвойса по данным поставщика"
      ,s.SupplierVolumeKG            -- "вес объем инвойса по данным поставщика"
      ,s.SupplierDiffVolumeWeigh     -- разница сумм вес объемный и вес физ факт по данным поставщика
      ,s.SupplierAmount 

      ,s.TransporterWeightKG         -- поле "вес физ по данным перевозчика"
      ,s.TransporterVolumeKG         -- поле "вес объем по данным перевозчика"
      ,s.TransporterDiffVolumeWeigh  -- разница сумм вес объемный и вес физ факт по данным перевозчика
      ,s.TransporterAmount 
      ,s.TransporterNumber

      ,s.WeightKGAmount
      ,s.VolumeKGAmount
      
      ,s.updDatetime
      ,s.SupplierBrief               -- поставщик
      ,s.StatusName
      ,s.DeliverySumF
      ,s.Flag Flag
  FROM vShipments s 
  LEFT JOIN @Suppliers sp
           ON sp.ID = s.SuppliersID
  LEFT JOIN @Status st
           ON st.ID = s.StatusID
 Where 1=1
   AND (NOT EXISTS (SELECT 1 FROM @Suppliers) OR sp.ID IS NOT NULL)
   AND (NOT EXISTS (SELECT 1 FROM @Status)    OR st.ID IS NOT NULL)

   and (@ShipmentsDate is null or cast(s.ShipmentsDate as date) = @ShipmentsDate)

   and (@Invoice is null or s.Invoice like '%' + @Invoice + '%')

   and (@TransporterNumber is null or s.TransporterNumber like '%' + @TransporterNumber + '%')

   and (@BoxNumber is null or s.BoxNumber = @BoxNumber)  

union all
Select s.*
  from (
  Select top 10
         max(s.ShipmentsID) ShipmentsID
        ,s.ShipmentsDate                  -- дата отгрузки
        ,max(s.ReceiptDate) ReceiptDate   -- ожидаемая дата поступления (расчетное поле)
        ,null          ReceiptDate2
        ,'Не присвоен' Invoice            -- номер инвойса
        ,s.DestinationLogo  -- тип отправки
        ,'(' + s.DestinationLogo + ') ' + s.DestinationName      DestinationName
        ,sum(s.ShipmentsAmount)  ShipmentsAmount   -- сумма отгрузки в долларах
        ,sum(s.ShipmentsAmountR) ShipmentsAmountR                                           
        ,sum(s.DetailCount)      DetailCount       -- количество деталей
        ,sum(s.WeightKG)         WeightKG          -- вес физический (по прайсу)
        ,sum(s.VolumeKG)         VolumeKG          -- вес объемный (по прайсу)
        ,sum(s.WeightKGDiff)     WeightKGDiff      -- 
        ,sum(s.WeightKGF)        WeightKGF         -- указать сумму вес физический факт
        ,sum(s.VolumeKGF)        VolumeKGF         -- указать сумму вес объемный факт
        ,sum(s.VolumeKGDiff)     VolumeKGDiff      --
  
        ,null Amount                      -- Расчетная стоимость доставки по весам из прайса
        ,null AmountF                     -- Фактическая стоимость доставки (по весам факт)
        ,null SupplierWeightKG            -- добавить редактируемое поле "вес физ инвойса по данным поставщика"
        ,null SupplierVolumeKG            -- добавить редактируемое поле "вес объем инвойса по данным поставщика"
        ,null SupplierDiffVolumeWeigh     -- указать разницу сумм вес объемный и вес физ факт по данным поставщика
        ,null SupplierAmount   
        -- считать доставку исходя из данных поставщика
        ,null TransporterWeightKG         -- добавить редактируемое поле "вес физ по данным перевозчика"
        ,null TransporterVolumeKG         -- добавить редактируемое поле "вес объем по данным перевозчика"
        ,null TransporterDiffVolumeWeigh  -- указать разницу сумм вес объемный и вес физ факт по данным перевозчика      
        ,null TransporterAmount 
        ,'Не присвоен' TransporterNumber
        ,Max(isnull(s.WeightKGAmount, 0)) WeightKGAmount-- выводить ставки за физ кг и объем кг исходя из типа доставки
        ,max(isnull(s.VolumeKGAmount, 0)) VolumeKGAmount
        
        ,null                     updDatetime
        ,sp.Brief                 SupplierBrief
        ,'Готово к отгрузке'      StatusName
        ,0 DeliverySumF
        ,2 Flag
    from pShipments s (nolock)
   inner join tSuppliers sp (nolock)
           on sp.SuppliersID = s.SuppliersID
    LEFT JOIN @Suppliers spl
             ON spl.ID = s.SuppliersID
   where s.spid = @@spid
     AND (NOT EXISTS (SELECT 1 FROM @Suppliers) OR spl.ID IS NOT NULL)
     and (@ShipmentsDate is null or cast(s.ShipmentsDate as date) = @ShipmentsDate)
   group by s.SuppliersID, 
            sp.Brief,
            s.DestinationLogo,
            s.DestinationName,
            s.ShipmentsDate--, 
            --s.ReceiptDate
   order by ShipmentsDate 
  ) as s

) as p
 order by
          case 
            when p.Flag & 2 >0 then 0
            else 1
          end,
          case 
            when p.Flag & 2 >0 then p.ShipmentsDate
            else null
          end ASC,
          case 
            when p.Flag&2 =0 then p.ShipmentsDate 
            else null
          end desc          
        
 exit_:
 return @r
go
grant exec on ShipmentsSelect to public
go
exec setOV 'ShipmentsSelect', 'P', '20250312', '3'
go

--exec ShipmentsSelect @TransporterNumber= 'QBLS169C', @Invoice = '250219'
 