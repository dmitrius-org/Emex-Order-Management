if OBJECT_ID('DetailPriceCalc', 'P') is not null
    drop proc DetailPriceCalc	 
go
/* --------------------------------------------------------
  DetailPriceCalc - расчет цены


01.05.2023
  добавлено:
     Хочу чтобы дописали коэффициенты на объемный вес.
     Их нужно добавить в таблицу [dbo].[tSupplierDeliveryProfiles]
     Будут работать как мультиплаер установленной в графу [VolumeKG] цифры, но при этом этот коэффициент может быть дробным, типа '1.6':
     1. Коэффициент на детали у которых [VolumeKG] строго меньше 10 кг
     2. Коэффициент на детали у которых [VolumeKG] от 10 кг включительно, но строго меньше 20 кг
     3. Коэффициент на детали у которых [VolumeKG] от 20 кг включительно, но строго меньше 25 кг
     4. Коэффициент на детали у которых [VolumeKG] от 25 кг включительно

01.05.2023
  добавлен контроль ограничения NOAIR
01.07.2024
  + Fragile 

-------------------------------------------------------- */
create proc DetailPriceCalc
              @ProfileName  varchar(30),
			  @ErrMessage   varchar(255) = null out
as
set nocount on

declare @IsDelivery   bit    -- Считать с учетом доставки
	   ,@IsMyDelivery bit    -- Поле для галочки "Игнорировать детали без веса"
       ,@Margin		  float
       ,@Kurs		  float
       ,@Commission	  float  -- Комиссия эквайера
       ,@Discount	  float  -- Скидка
	   ,@Reliability  float  -- Вероятность поставки
	   ,@RetVal       int
	   ,@WeightKG	  float
	   ,@VolumeKG     float
	   ,@isIgnore     bit
	   ,@ExtraKurs    float
       ,@Fragile      float

Select @Margin      = cp.Margin     
	  ,@Reliability = cp.Reliability 
	  ,@Discount    = s.Discount   
	  ,@Commission  = s.Commission 
	  ,@IsMyDelivery= isnull(cp.isMyDelivery , 0)
      ,@isIgnore    = isnull(cp.isIgnore, 0)
	  ,@WeightKG	= cp.WeightKG
	  ,@VolumeKG    = cp.VolumeKG                     
	  ,@ExtraKurs   = s.ExtraKurs
      ,@Fragile     = isnull(cp.Fragile, 0)
  from vClientProfilesParam cp
  inner join tSuppliers s (nolock)
          on s.SuppliersID = cp.SuppliersID
 where cp.ClientProfileName = @ProfileName

if @@ROWCOUNT = 0
begin
  select @ErrMessage='Не найден профиль [' + @ProfileName + '] для выгрузки прайса'
        ,@RetVal    = 1
  goto exit_
end

-- курс доллара
select @Kurs = dbo.GetCurrencyRate('840', null)

if OBJECT_ID('tempdb..#Price') is not null
    drop table #Price

create table #Price 
(
 PriceID           numeric(18,0)   --  
,Brand             varchar(60)    --
,DetailNum	       varchar(30)    -- Номер детали 
,DetailPrice       float          -- Цена
,FinalPrice        float          -- Цена
,DetailName	       varchar(255)   -- Название
,PriceLogo         varchar(30)    -- Название прайса 
,Quantity          int            -- Количество
,PackQuantity      int            -- Количество в упаковке
--,Reliability       float          -- Вероятность поставки
--,isDelivery        bit            -- с учетом доставки
,WeightKG          float          -- Вес физический кг 
,VolumeKG          float          -- Вес объемный кг  
,TPrice            float          -- тип цены, например: MOSA, MOSC, KIRG
,TDel              float          -- номинал стоимости за доставку
,TDetPrice         float          -- номинал цены детали со скидкой
,TCom              float          -- номинал комиссии 
,TMarg             float          -- номинал наценки на товар
,TFinPrice         float
,Term              int            -- срок доставки
,TFinPriceKurs     money
,Fragile           bit
)

insert #Price
	  (
	   PriceID        
      ,Brand        
      ,DetailNum	  
      ,DetailPrice  
      ,DetailName	  
      ,PriceLogo    
      ,Quantity     
      ,PackQuantity 
	  ,Term
	  ,WeightKG 
	  ,VolumeKG 
      ,TPrice
      ,Fragile -- признак хрупкости
	  )
select-- top 200000 
       t.PriceID,
       t.BrandName, 
       t.DetailNum, 
	   t.DetailPrice,
	   t.DetailName, 
	   t.PriceLogo,
	   isnull(t.Quantity, 9999), 
	   t.PackQuantity, 
	   0,--pt.Term,
	   isnull(t.WeightKGF, t.WeightKG),--
	   isnull(t.VolumeKGf, t.VolumeKG)
                    * case --коэффициенты [VolumeKG]
                        when isnull(t.VolumeKGf, t.VolumeKG) < 10                 then isnull(pc.VolumeKG_Rate1, 1) -- 1. Коэффициент на детали у которых [VolumeKG] строго меньше 10 кг
                        when isnull(t.VolumeKGf, t.VolumeKG) between 10 and 19.99 then isnull(pc.VolumeKG_Rate2, 1) -- 2. Коэффициент на детали у которых [VolumeKG] от 10 кг включительно, но строго меньше 20 кг
                        when isnull(t.VolumeKGf, t.VolumeKG) between 20 and 24.99 then isnull(pc.VolumeKG_Rate3, 1) -- 3. Коэффициент на детали у которых [VolumeKG] от 20 кг включительно, но строго меньше 25 кг
                        when isnull(t.VolumeKGf, t.VolumeKG) >= 25                then isnull(pc.VolumeKG_Rate4, 1) -- 4. Коэффициент на детали у которых [VolumeKG] от 25 кг включительно
                        else 1
                      end,
	   t.MOSA,
       t.Fragile
  from vClientProfilesParam pc
 inner join vPrice t
         on t.PriceLogo = pc.UploadPriceName
        and t.isDelete  = 0
		 --and 1=1
             /*Если в форме была установлена галочка "Игнорировать детали без веса", то убираем все строки,
               у которых сразу в двух ячейках WeightKG и VolumeKG значение 0.*/
         and (@isIgnore = 0
          or (@isIgnore = 1 and not (isnull(t.WeightKGF, t.WeightKG) = 0 and isnull(t.VolumeKGf, t.VolumeKG) = 0)))
             --Убираем все строки, у которых значения в столбце Reliability строго меньше, чем reliability из формы
         and t.Reliability >= @Reliability
		 --and t.Quantity > 0
		 and isnull(t.NoAir, 0) = case --если проставлен признак не выгружать с ограничениями
		                            when isnull(pc.Restrictions, 0) = 1 and isnull(t.NoAir, '') = 1 then 1 
			                        else isnull(t.NoAir, 0)
                                  end
         and isnull(t.NLA, 0) = 0

 where pc.ClientProfileName =  @ProfileName

 -- and t.DetailNum = '849753JA1A' --46676

if @IsMyDelivery = 0 /*сторонняя доставка*/
begin
  /*
  Если установлена галочка "Считать с учетом доставки":
   - Вычисляем номинал стоимости за доставку: TDel = "MOSA" (или любой другой столбец, выбранный в начале) - Detail Price
   - Вычисляем номинал цены детали со скидкой: TDetPrice = DetailPrice - DetailPrice*Discount
   - Вычисляем номинал комиссии: TCom = (TDetPrice+(MOSA-DetailPrice))*Commission
   - Вычисляем номинал наценки на товар: TMarg = TDetPrice*Margin
   - Вычисляем конечную цену: TFinPrice = (TDetPrice + TDel + TMarg + TCom) * Kurs
   - Округляем конечную цену вверх до целых
   - В столбец "FinalPrice" пишем TFinPrice
  */
  Update #Price 
     set TDel      = TPrice - DetailPrice
        ,TDetPrice = DetailPrice - DetailPrice * (@Discount/100)

  Update #Price 
     set TCom      = (TDetPrice+(TPrice-DetailPrice))*@Commission/100
        ,TMarg     = TDetPrice*@Margin/100

  Update #Price 
     set TFinPrice = (TDetPrice + TDel + TMarg + TCom)
end
else /* 1 - своя доставка*/
begin
   Update #Price  
      set TDel = case
	               -- If "Физический вес из прайса" >= "Объемный вес из прайса", то:
                   -- Конечный вес = "Физический вес из прайса" * "Цена за физ кг"
	               when WeightKG >= VolumeKG 
				     then WeightKG * (@WeightKG)
					 -- Else "Физический вес из прайса" < "Объемный вес из прайса", то:
                     -- Конечный вес = "Физический вес из прайса" * "Цена за физ кг" + ("Объемный вес из прайса" - "Физический вес из прайса") * "Цена за объем кг"   
	                 else WeightKG * (@WeightKG) + (VolumeKG-WeightKG) * (@VolumeKG)
				 end
      
   --Вычисляем номинал цены детали со скидкой: TDetPrice = DetailPrice - DetailPrice*Discount
   Update #Price set TDetPrice = DetailPrice- DetailPrice * (@Discount/100)
   
   Update #Price set TCom = TDetPrice * (@Commission/100)
      
   -- Вычисляем номинал наценки на товар: TMarg = TDetPrice*Margin
   Update #Price set TMarg = TDetPrice* (@Margin/100)

   Update #Price 
      set TFinPrice = (TDetPrice + TDel + TMarg + TCom)

   /* без доставки
   - Вычисляем номинал цены детали со скидкой: TDetPrice = DetailPrice - DetailPrice*Discount
   - Вычисляем номинал комиссии: TCom = TDetPrice*Commission
   - Вычисляем номинал наценки на товар: TMarg = TDetPrice*Margin
   - Вычисляем конечную цену: TFinPrice = (TDetPrice + TMarg + TCom) * Kurs
   - Округляем конечную цену вверх до целых
   - В столбец "FinalPrice" пишем TFinPrice
  Update #Price 
     set TDetPrice = DetailPrice - DetailPrice * (@Discount/100)

  Update #Price 
     set TCom      = TDetPrice*@Commission
        ,TMarg     = TDetPrice*@Margin

  Update #Price 
     set TFinPrice = ((TDetPrice + TMarg + TCom) * @Kurs)
   */

end

Update #Price 
   set TFinPriceKurs  = TFinPrice * (@Kurs + (@Kurs * (isnull(@ExtraKurs, 0)/100)))

--Если у детали установлен пункт Fragile, считать ее сразу с этой наценкой
--Например, если мы ставим галочку во Fragile, то к себестоимости детали добавляется 3%
Update #Price 
   set TFinPriceKurs  =  TFinPriceKurs  + (TFinPriceKurs * (@Fragile/100))
 where Fragile > 0

Update #Price 
   set FinalPrice = CEILING(TFinPriceKurs)

	  --MakeLogo, DetailNum, DetailName, Quantity, PackQuantity, FinalPrice
	  
select Brand, 
       DetailNum, 
	   DetailName, 
	   Quantity, 
	   PackQuantity, 
	   cast(FinalPrice as int) as FinalPrice
  from #Price (nolock)
 order by Brand, DetailNum
 --*/


exit_:
return @RetVal
go
grant exec on DetailPriceCalc to public
go
exec setOV 'DetailPriceCalc', 'P', '20250531', '6'