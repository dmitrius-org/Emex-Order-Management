drop proc if exists OrderUpdate
go
create proc OrderUpdate
               @OrderID                 numeric(18,0)
              ,@DetailNameF             nvarchar(512) = null -- Наименование факт
              ,@WeightKGF               float         = null -- Вес Физический факт	
              ,@VolumeKGF               float         = null -- Вес Объемный факт
              ,@Fragile                 bit           = null 
              ,@NoAir                   bit           = null 
              
              ,@DestinationLogo         nvarchar(64)  = null -- Направление отгрузки               

              ,@Price                   nvarchar(64)  = null -- Прайс
              ,@MakeLogo                nvarchar(20)  = null -- Код производителя
              ,@ReplacementPrice        float         = null -- новая цена   
              
              ,@TargetStateID           numeric(18,0) = null
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

  declare @PriceID as table(PriceID numeric(18, 0))

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
     set t.PriceLogo       = isnull(@Price, t.PriceLogo  )
        ,t.DestinationLogo = isnull(@DestinationLogo, t.DestinationLogo)
        ,t.DestinationName = pd.DestinationName
		,t.Flag            = isnull(t.Flag, 0) | case  
		                                            when t.PriceLogo <> nullif(@Price, '') then 256 --Был изменен Прайс-лист
							                        else 0
                                                 end
        ,t.ReplacementPrice= case  
		                       when /*t.PriceLogo <> nullif(@Price, '') and*/ @ReplacementPrice <> t.PricePurchase then nullif(@ReplacementPrice, 0)
							   else nullif(t.ReplacementPrice, 0)
                             end
        ,t.DetailName      = nullif(@DetailNameF, '')
        
         -- параметры расчета себестоимости 
        ,t.PercentSupped   = coalesce(t.PercentSupped, p.PercentSupped, 0) 
        ,t.Margin          = coalesce(t.Margin       , p.Margin       , 0)
        ,t.Discount        = coalesce(t.Discount     , p.Discount     , 0)
        ,t.Kurs            = coalesce(t.Kurs         , p.Kurs         , 0)
        ,t.ExtraKurs       = coalesce(t.ExtraKurs    , p.ExtraKurs    , 0)
        ,t.Commission      = coalesce(t.Commission   , p.Commission   , 0)
        ,t.Reliability     = coalesce(t.Reliability  , p.Reliability  , 0)

         -- cроки поставки клиента
        --,t.DeliveryTermToCustomer = p.OurDelivery -- Срок поставки клиенту
        --,t.DeliveryDateToCustomer = cast( dateadd(dd, p.OurDelivery, getdate()) as date )-- Дата поставки клиенту    
        --,t.DeliveryRestToCustomer = p.OurDelivery -- Остаток срока до поставки клиенту

        ,t.ProcessingDate         = cast(getdate() as date)

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
                pd.DestinationLogo, 
                pd.Name DestinationName,
                pd.Delivery-- Срок поставки клиента, для заказов из файла берем из профилей доставки
           from tProfilesCustomer pc with (nolock index=ao2)
           left join tSupplierDeliveryProfiles pd with (nolock index=ao1)
                  on pd.ProfilesDeliveryID = pc.ProfilesDeliveryID
          where pc.ClientID        = t.ClientID
            and pd.DestinationLogo = @DestinationLogo   
        ) as pd
  where t.OrderID = @OrderID

  -- сохранение данных на позиции/детали
  update p
     set p.DetailNameF	= nullif(@DetailNameF, '')
        ,p.WeightKGF	= case 
                            when isnull(@WeightKGF, 0) = 0 and p.WeightKG>0 then p.WeightKG
                            else @WeightKGF
                          end  
        ,p.VolumeKGF	= case 
                            when isnull(@VolumeKGF, 0) = 0 and p.VolumeKG>0 then p.VolumeKG
                            else @VolumeKGF
                          end  
        ,p.Restrictions = case
                            when @NoAir = 1 then 'NOAIR'
                            else null
                          end
        ,p.Fragile      = nullif(@Fragile, 0) 
  OUTPUT INSERTED.PriceID INTO @PriceID(PriceID)  
	from tOrders t  with (nolock index=ao1)
   inner join tPrice p with (updlock index=ao2)
           on p.DetailNum = t.DetailNumber
		  and p.MakeLogo  = t.MakeLogo -- производитель
   where t.OrderID = @OrderID

  -- расчет финнасовых показателей
  delete pOrdersFinIn from pOrdersFinIn with (rowlock index=ao1) where spid = @@Spid
  insert pOrdersFinIn with (rowlock) 
        (Spid, OrderID)
  Select @@spid, @OrderID

  exec OrdersFinCalc 
         @IsSave = 1

  --! расчет сроков доставки
  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm with (rowlock) 
        (Spid, OrderID, DeliveryTerm) 
  Select @@spid, 
         @OrderID,
         iif(@DeliveryTermSupplier <> @DeliveryTermSupplierNew, @DeliveryTermSupplierNew, null)
  
  exec OrdersSupplierDeliveryCalc @IsSave = 1

  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm with (rowlock) 
        (Spid, OrderID) 
  Select @@spid, 
         @OrderID
  
  exec OrdersDeliveryTermCalc @IsSave = 1
  
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

  select @AuditComment =  'Изменение DetailNameF:' + nullif(@DetailNameF, '') + ', WeightKGF:' + cast(@WeightKGF as nvarchar) + ', VolumeKGF:' + cast(@VolumeKGF as nvarchar) 
  -- аудит
  exec AuditInsert
         @AuditID          = @AuditID out         
        ,@ObjectID         = @OrderID
        ,@ObjectTypeID     = 3
        ,@ActionID         = 2 -- ИД выполняемое дейстие из tAction
        ,@Comment          = @AuditComment
  
  exit_:
  return @r

go
grant exec on OrderUpdate to public
go
exec setOV 'OrderUpdate', 'P', '20250204', '14'
go
 