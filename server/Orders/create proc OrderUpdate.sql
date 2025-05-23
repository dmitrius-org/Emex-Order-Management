drop proc if exists PartHistoryInsert
go
drop proc if exists OrderUpdate
go
create proc OrderUpdate
               @OrderID                 numeric(18,0)
              ,@DetailNameF             nvarchar(512) = null -- Наименование факт
              ,@WeightKGF               float         = null -- Вес Физический факт	
              ,@VolumeKGF               float         = null -- Вес Объемный факт
              ,@Fragile                 bit           = null 
              ,@NoAir                   bit           = null
              ,@NLA                     bit           = null -- No longer available Более недоступно                    
              ,@Price                   nvarchar(64)  = null -- Прайс
              ,@MakeLogo                nvarchar(20)  = null -- Код производителя
              ,@ReplacementPrice        float         = null -- Новая цена   
              ,@TargetStateID           numeric(18,0) = null
              ,@ProfilesCustomerID      numeric(18,0) = null
              ,@ProfilesDeliveryID      numeric(18,0) = null
              -- параметры для дробления заказа
              ,@IsSplit                 bit           = null
              ,@SplitQuality            int           = null

/*
  OrderUpdate - изменение данных по заказу/детали

  -- 20.10.2023 - добавлен расчет финансовых показателей
*/          
as
  declare @r            int = 0
		 ,@Type         int
		 ,@AuditID      numeric(18,0)
         ,@AuditComment nvarchar(2048)
         ,@DeliveryTermSupplier    int -- Срок доставки поставщику
         ,@DeliveryTermSupplierNew int -- Срок доставки поставщику

  if @IsSplit = 1 
  begin
    exec OrderSplitting
           @OrderID    = @OrderID
          ,@Quantity   = @SplitQuality
          ,@NewOrderID = @OrderID  out  
  end

  select @DeliveryTermSupplier    = t.DeliveryTerm
        ,@DeliveryTermSupplierNew = p.GuaranteedDay
	from tOrders t with (nolock index=ao1)
   outer apply ( select top 1 *
                   from pFindByNumber p with (nolock index=ao3)
                  where p.Spid = @@spid
                    and p.Make      = @MakeLogo
                    and p.DetailNum = t.DetailNumber
                    and p.PriceLogo = @Price
                ) as p
  where t.OrderID = @OrderID

  update t
     set t.PriceLogo          = isnull(@Price, t.PriceLogo  )
         -- направление отгрузки
        ,t.DestinationLogo    = pd.DestinationLogo
        ,t.DestinationName    = pd.DestinationName        
        ,t.ProfilesDeliveryID = @ProfilesDeliveryID
        ,t.ProfilesCustomerID = @ProfilesCustomerID
		,t.Flag               = isnull(t.Flag, 0) | case  
		                                               when t.PriceLogo <> nullif(@Price, '') then 256 --Был изменен Прайс-лист
							                           else 0
                                                    end
        ,t.ReplacementPrice   = case  
		                          when /*t.PriceLogo <> nullif(@Price, '') and*/ @ReplacementPrice <> isnull(t.PricePurchase, 0) then nullif(@ReplacementPrice, 0)
							      else nullif(t.ReplacementPrice, 0)
                                end
        ,t.DetailName         = nullif(@DetailNameF, '')
         -- параметры расчета себестоимости 
        ,t.PercentSupped      = coalesce(t.PercentSupped, p.PercentSupped, 0) 
        ,t.Margin             = coalesce(t.Margin       , p.Margin       , 0)
        ,t.Discount           = coalesce(t.Discount     , p.Discount     , 0)
        ,t.Kurs               = coalesce(t.Kurs         , p.Kurs         , 0)
        ,t.ExtraKurs          = coalesce(t.ExtraKurs    , p.ExtraKurs    , 0)
        ,t.Commission         = coalesce(t.Commission   , p.Commission   , 0)
        ,t.Reliability        = coalesce(t.Reliability  , p.Reliability  , 0)
        ,t.DeliveryTermFromSupplier2 = case 
                                         when t.DeliveryTermFromSupplier = pd.DeliveryTermFromSupplier then null
                                         else pd.DeliveryTermFromSupplier
                                       end
	from tOrders t with (updlock index=ao1)
   outer apply ( select top 1 *
                   from pFindByNumber p with (nolock index=ao3)
                  where p.Spid = @@spid
                    and p.Make      = @MakeLogo
                    and p.DetailNum = t.DetailNumber
                    and p.PriceLogo = @Price
                ) as p

    outer apply ( -- для клиентов работающих через файл, профилей может быть несколько
         select top 1
                pc.ProfilesDeliveryID,
                pc.DestinationLogo, 
                pc.DestinationName,
                pc.DeliveryTermFromSupplier-- Срок поставки клиента, для заказов из файла берем из профилей доставки
           from vClientProfilesParam pc
          where isnull(t.Flag, 0)&16 >0
            and pc.ClientID           = t.ClientID
            and pc.ProfilesCustomerID = @ProfilesCustomerID
         union all
         select top 1
                pc.ProfilesDeliveryID,
                pc.DestinationLogo, 
                pc.ProfileName,
                pc.DeliveryTermFromSupplier-- Срок поставки клиента, для заказов из файла берем из профилей доставки
           from vSupplierDeliveryParam pc
          where isnull(t.Flag, 0)&16  = 0
            and pc.ProfilesDeliveryID = @ProfilesDeliveryID

        ) as pd
  where t.OrderID = @OrderID
 
  declare @PartsUpdate as TABLE 
  (
  	 DetailName        varchar(256)   -- Наименование детали 
  	,WeightKG          float          -- Вес физический кг 
  	,VolumeKG          float          -- Вес объемный кг  
  	,NoAir             bit            -- 
    ,Fragile	       bit
    ,NLA               bit            -- No longer available или Более недоступно
 
  	,DetailNameOld     varchar(256)   -- Наименование детали 
  	,WeightKGOld       float          -- Вес физический кг 
  	,VolumeKGOld       float          -- Вес объемный кг  
  	,NoAirOld          bit   
    ,FragileOld	       bit
    ,NLAOld            bit            -- No longer available или Более недоступно
  );

  --delete from #PartsUpdate
  -- сохранение данных на позиции/детали
  update p
     set p.DetailNameF	= nullif(@DetailNameF, '')
        ,p.WeightKGF	= case
                            when isnull(@WeightKGF, 0) = 0 and t.WeightKG>p.WeightKG and t.Flag&512 > 0 then t.WeightKG
                            when isnull(@WeightKGF, 0) = 0 and p.WeightKG>0 then p.WeightKG
                            else @WeightKGF
                          end  
        ,p.VolumeKGF	= case 
                            when isnull(@VolumeKGF, 0) = 0 and t.VolumeKG>p.VolumeKG and t.Flag&512 > 0 then t.VolumeKG
                            when isnull(@VolumeKGF, 0) = 0 and p.VolumeKG>0 then p.VolumeKG
                            else @VolumeKGF
                          end  
        ,p.NoAir        = @NoAir
        ,p.Fragile      = @Fragile
        ,p.NLA          = @NLA 
        ,p.UserID       = dbo.GetUserID()
        
  OUTPUT INSERTED.DetailNameF
        ,INSERTED.WeightKGF
        ,INSERTED.VolumeKGF
        ,INSERTED.NoAir
        ,INSERTED.Fragile
        ,INSERTED.NLA

        ,Deleted.DetailNameF
        ,Deleted.WeightKGF
        ,Deleted.VolumeKGF
        ,Deleted.NoAir
        ,Deleted.Fragile
        ,Deleted.NLA
    INTO @PartsUpdate(      
         DetailName    
        ,WeightKG      
        ,VolumeKG      
        ,NoAir  
        ,Fragile	   
        ,NLA  
  
        ,DetailNameOld    
        ,WeightKGOld      
        ,VolumeKGOld      
        ,NoAirOld  
        ,FragileOld	      
        ,NLAOld
        )  
	from tOrders t  with (nolock index=ao1)
   inner join tParts p with (updlock index=ao2)
           on p.Brand  = t.MakeLogo -- производитель 
		  and p.DetailNum = t.DetailNumber
   where t.OrderID = @OrderID
     and (isnull(p.DetailNameF, '')	<> nullif(@DetailNameF, '')
       or isnull(p.WeightKGF, 0)	<> case
                                         when isnull(@WeightKGF, 0) = 0 and t.WeightKG>p.WeightKG and t.Flag&512 > 0 then t.WeightKG
                                         when isnull(@WeightKGF, 0) = 0 and p.WeightKG>0 then p.WeightKG
                                         else @WeightKGF
                                       end  
       or isnull(p.VolumeKGF, 0)	<> case 
                                         when isnull(@VolumeKGF, 0) = 0 and t.VolumeKG>p.VolumeKG and t.Flag&512 > 0 then t.VolumeKG
                                         when isnull(@VolumeKGF, 0) = 0 and p.VolumeKG>0 then p.VolumeKG
                                         else @VolumeKGF
                                       end  
       or isnull(p.NoAir, 0)        <> isnull(@NoAir, 0)
       or isnull(p.Fragile, 0)      <> isnull(@Fragile, 0) 
       or isnull(p.NLA, 0)          <> isnull(@NLA, 0)  
       )


  -- расчет финнасовых показателей
  delete pOrdersFinIn from pOrdersFinIn with (rowlock index=ao1) where spid = @@Spid
  insert pOrdersFinIn with (rowlock) 
        (Spid, OrderID)
  Select @@spid, @OrderID

  exec OrdersFinCalc 
         @IsSave = 1

  --! расчет сроков доставки поставщика
  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm with (rowlock) 
        (Spid, OrderID, DeliveryTerm) 
  Select @@spid, 
         @OrderID,
         iif(@DeliveryTermSupplier <> @DeliveryTermSupplierNew, @DeliveryTermSupplierNew, null)
  
  exec OrdersSupplierDeliveryCalc @IsSave = 1


  /* расчет сроков доставки :
      - Следующая ближайшая дата вылета DeliveryNextDate2
      - Дней запаса до вылета*/
  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm with (rowlock) 
        (Spid, OrderID) 
  Select @@spid, 
         @OrderID
  
  exec OrdersDeliveryTermCalcNext @IsSave = 1, @IsUpdate = 1


  if exists (select 1
               from tOrders with (nolock index=ao1)
              where OrderID = @OrderID
                and DeliveryTermFromSupplier <> DeliveryTermFromSupplier2
                and DeliveryTermFromSupplier2 is not null)
  begin
      -- расчет сроков доставки клиента
      delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
      insert pDeliveryTerm with (rowlock) 
            (Spid, OrderID) 
      Select @@spid, 
             @OrderID
             
      exec OrdersDeliveryCustomerTermCalcNext @IsSave = 1
  end

  
  if @TargetStateID > 0
  begin
      delete pAccrualAction from pAccrualAction with (rowlock index=ao1) where spid = @@spid

      Update p 
         set p.Retval = 545 --Заказ в работе!
	    from pAccrualAction p with (updlock index=ao2)
       where p.Spid   = @@spid
         and p.retval = 0
         and exists ( select 1
                       from tProtocol o with (nolock index=ao2)
	                  where o.ObjectID   = p.ObjectID
                        and o.NewStateID = 4 -- InWork В работе
                    )

      insert pAccrualAction with (rowlock) 
            (Spid,   
             ObjectID,  
             StateID,
             NewStateID,
             ActionID,
             OperDate,
             Message)
      select @@Spid, 
             o.OrderID, 
             o.StatusID, 
             @TargetStateID,
             case
               when @TargetStateID = 2  then 13	--ToChecked	Проверка выполнена 
               when @TargetStateID = 12 then 16	--ToCancel	Отказать
               else 0
             end,
             cast(getdate() as date),
             case
               when @TargetStateID = 2  then 'Автоматическое подтверждение из формы изменения'
               when @TargetStateID = 12 then 'Автоматический отказ из формы изменения'
               else null
             end
        from tOrders o (nolock) 
       where o.OrderID = @OrderID
  
      exec ProtocolAdd
  end

  select @AuditComment = iif(isnull(DetailNameOld,'')<>isnull(DetailName,''), 'Изменение названия: ''' + isnull(DetailNameOld,'') + ''' -> '''+ isnull(DetailName,'') +  '''<br>', '') + 
                         iif(isnull(WeightKGOLD  , 0)<>isnull(WeightKG  , 0), 'Изменение физического веса: ''' + cast(isnull(WeightKGOLD, 0.00) as varchar) + ''' -> '''+ cast(isnull(WeightKG, 0.00) as varchar) + '''<br>', '') + 
                         iif(isnull(VolumeKGOLD  , 0)<>isnull(VolumeKG  , 0), 'Изменение объемного веса: ''' + cast(isnull(VolumeKGOLD, 0.00) as varchar) + ''' -> '''+ cast(isnull(VolumeKG, 0.00) as varchar) + '''<br>', '') + 
                         iif(isnull(NoAirOld     , 0)<>isnull(NoAir     , 0), 'NoAir: ''' +  cast(isnull(NoAirOld, 0) as varchar)  + ''' -> '''+ cast(isnull(NoAir, 0) as varchar)  + '''<br>', '') + 
                         iif(isnull(FragileOLD   , 0)<>isnull(Fragile   , 0), 'Fragile: '''+ cast(isnull(FragileOLD, 0) as varchar) + ''' -> '''+ cast(isnull(Fragile, 0) as varchar) + '''<br>', '') + 
                         iif(isnull(NLAOLD       , 0)<>isnull(NLA       , 0), 'NLA: ''' + cast(isnull(NLAOLD, 0) as varchar) + ''' -> '''+ cast(isnull(NLA, 0) as varchar) +'''', '') 
    from @PartsUpdate

  -- аудит
  exec AuditInsert
         @AuditID          = @AuditID out         
        ,@ObjectID         = @OrderID
        ,@ObjectTypeID     = 3
        ,@ActionID         = 2 -- ИД выполняемое дейстие из tAction
        ,@Comment          = @AuditComment

  exec EmployeeOrdersProcessed
         @OrderID = @OrderID  
         

  Update pShipmentsBoxes 
     set WeightKG   = @WeightKGF
        ,WeightKGS  = @WeightKGF * Quantity

        ,VolumeKG   = @VolumeKGF
        ,VolumeKGs  = @VolumeKGF * Quantity

   where spid    = @@spid
     and OrderID = @OrderID
  
  exit_:
  return @r

go
grant exec on OrderUpdate to public
go
exec setOV 'OrderUpdate', 'P', '20250531', '22'
go
 