declare
              @ProfileName  varchar(30)='EEZap (BEED-48H)',
			  @DetailNum    varchar(30)= 'HYB168NA',
			  @ErrMessage   varchar(255) = null 

--EmEx (MZYN-EMIN)

--select * 
--  from tProfilesCustomer pc (nolock)


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

Select @Margin      = pc.Margin     
	  ,@Reliability = pc.Reliability 
	  ,@Discount    = s.Discount   
	  ,@Commission  = s.Commission 
	  ,@IsMyDelivery= isnull(pd.isMyDelivery , 0)
      ,@isIgnore    = isnull(pd.isIgnore, 0)
	  ,@WeightKG	= pd.WeightKG
	  ,@VolumeKG    = pd.VolumeKG                     
	  ,@ExtraKurs   = s.ExtraKurs
      ,@Fragile     = isnull(pd.Fragile, 0)
  from tProfilesCustomer pc (nolock)
  inner join tSupplierDeliveryProfiles pd (nolock)
          on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
  inner join tSuppliers s (nolock)
          on s.SuppliersID = pd.SuppliersID
 where pc.Brief =  @ProfileName


Select Margin      = pc.Margin     
	  ,Reliability = pc.Reliability 
	  ,Discount    = s.Discount   
	  ,Commission  = s.Commission 
	  ,IsMyDelivery= isnull(pd.isMyDelivery , 0)
      ,isIgnore    = isnull(pd.isIgnore, 0)
	  ,WeightKG	= pd.WeightKG
	  ,VolumeKG    = pd.VolumeKG                     
	  ,ExtraKurs   = s.ExtraKurs
      ,Fragile     = pd.Fragile
  from tProfilesCustomer pc (nolock)
  inner join tSupplierDeliveryProfiles pd (nolock)
          on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
  inner join tSuppliers s (nolock)
          on s.SuppliersID = pd.SuppliersID
 where pc.Brief =  @ProfileName

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
       t.Brand, 
       t.DetailNum, 
	   t.DetailPrice,
	   t.DetailName, 
	   t.PriceLogo,
	   t.Quantity, 
	   t.PackQuantity, 
	   0,--pt.Term,
	   isnull(t.WeightKGF, t.WeightKG),--
	   isnull(t.VolumeKGf, t.VolumeKG)
                    * case --коэффициенты [VolumeKG]
                        when isnull(t.VolumeKGf, t.VolumeKG) < 10                 then isnull(pd.VolumeKG_Rate1, 1) -- 1. Коэффициент на детали у которых [VolumeKG] строго меньше 10 кг
                        when isnull(t.VolumeKGf, t.VolumeKG) between 10 and 19.99 then isnull(pd.VolumeKG_Rate2, 1) -- 2. Коэффициент на детали у которых [VolumeKG] от 10 кг включительно, но строго меньше 20 кг
                        when isnull(t.VolumeKGf, t.VolumeKG) between 20 and 24.99 then isnull(pd.VolumeKG_Rate3, 1) -- 3. Коэффициент на детали у которых [VolumeKG] от 20 кг включительно, но строго меньше 25 кг
                        when isnull(t.VolumeKGf, t.VolumeKG) >= 25                then isnull(pd.VolumeKG_Rate4, 1) -- 4. Коэффициент на детали у которых [VolumeKG] от 25 кг включительно
                        else 1
                      end,
	   t.MOSA,
       t.Fragile
  from tProfilesCustomer pc (nolock)
 inner join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
 inner join tPrice t with (nolock index=ao3)
         on t.PriceLogo = pc.UploadPriceName
		 --and 1=1
             /*Если в форме была установлена галочка "Игнорировать детали без веса", то убираем все строки,
               у которых сразу в двух ячейках WeightKG и VolumeKG значение 0.*/
        and (@isIgnore = 0
         or (@isIgnore = 1 and not (isnull(t.WeightKGF, t.WeightKG) = 0 and isnull(t.VolumeKGf, t.VolumeKG) = 0)))
            --Убираем все строки, у которых значения в столбце Reliability строго меньше, чем reliability из формы
        and t.Reliability >= @Reliability
		 --and t.Quantity > 0
        and  isnull(t.Restrictions, '') = case --если проставлен признак не выгружать с ограничениями
	                                        when isnull(pd.Restrictions, 0) = 1 and isnull(t.Restrictions, '') = 'NOAIR' then ''  
			                                else isnull(t.Restrictions, '')
                                          end

 where pc.Brief =  @ProfileName

  and t.DetailNum = @DetailNum

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
 order by PriceLogo
 --*/


exit_:


select * from tPrice where DetailNum='HYB168NA'