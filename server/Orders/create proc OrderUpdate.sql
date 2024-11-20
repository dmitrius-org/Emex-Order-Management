drop proc if exists OrderUpdate
/*
  OrderUpdate - изменение данных по заказу/детали

  -- 20.10.2023 - добавлен расчет финансовых показателей
*/
go
create proc OrderUpdate
               @OrderID                 numeric(18,0)
              ,@DetailNameF             nvarchar(512) = null -- Наименование факт
              ,@WeightKGF               float         = null -- Вес Физический факт	
              ,@VolumeKGF               float         = null -- Вес Объемный факт
              ,@Fragile                 bit           = null 
              ,@NoAir                   bit           = null 
              
              ,@DestinationLogo         nvarchar(64)  = null -- Направление отгрузки 
              ,@Comment                 nvarchar(1024)= null
              ,@TargetStateID           numeric(18,0) = null

              ,@Price                   nvarchar(64)  = null -- Прайс
              ,@MakeLogo                nvarchar(20)  = null -- посмотреть что сюда приходит !!!
              ,@ReplacementPrice        float         = null -- новая цена              
              
as
  declare @r             int = 0
		 ,@Type          int
		 ,@AuditID       numeric(18,0)
         ,@AuditComment  nvarchar(2048)

  declare @PriceID as table(PriceID numeric(18, 0))

  select @Price            = case 
                               when @Price = '' then null
                               when @Price = '-1' then null
                               else @Price
                             end             
        ,@MakeLogo         = case 
                              when @MakeLogo = '' then null
                              when @MakeLogo = '-1' then null
                              else @MakeLogo
                            end
        ,@DestinationLogo = case 
                              when @DestinationLogo = '' then null
                              when @DestinationLogo = '-1' then null
                              else @DestinationLogo
                            end

  update t
     set t.PriceLogo       = isnull(@Price, t.PriceLogo  )
        --,t.MakeLogo        = isnull(@MakeLogo , t.MakeLogo ) 
        ,t.DestinationLogo = isnull(@DestinationLogo, t.DestinationLogo)
		,t.Flag            = isnull(t.Flag, 0) | case  
		                                            when t.PriceLogo <> nullif(@Price, '') then 256 --Был изменен Прайс-лист
							                        else 0
                                                 end
        ,t.ReplacementPrice= case  
		                       when t.PriceLogo <> nullif(@Price, '') and @ReplacementPrice <> t.PricePurchase then @ReplacementPrice
							   else null
                             end
        ,t.PercentSupped   = case  
		                       when t.PriceLogo <> nullif(@Price, '') then isnull((   select top 1 
                                                                                              p.PercentSupped
                                                                                         from pFindByNumber p with (nolock index= ao3)
                                                                                        where p.spid      = @@spid
                                                                                          and p.Make      = t.MakeLogo
                                                                                          and p.DetailNum = t.DetailNumber
                                                                                          and p.PriceLogo = @Price
                                                                                        order by p.PercentSupped desc), t.PercentSupped) 
							   else t.PercentSupped
                             end
        --,t.Comment         = @Comment     
        ,t.DetailName      = nullif(@DetailNameF, '')
	from tOrders t (updlock)
   where t.OrderID = @OrderID

  update p
     set p.DetailNameF	   = nullif(@DetailNameF, '')
        ,p.WeightKGF	   = case 
                               when isnull(@WeightKGF, 0) = 0 and p.WeightKG>0 then p.WeightKG
                               else @WeightKGF
                             end  
        ,p.VolumeKGF	   = case 
                               when isnull(@VolumeKGF, 0) = 0 and p.VolumeKG>0 then p.VolumeKG
                               else @VolumeKGF
                             end  
        ,p.Restrictions    = case
                               when @NoAir = 1 then 'NOAIR'
                               else null
                             end
         ,Fragile          = nullif(@Fragile, 0)
         
   OUTPUT INSERTED.PriceID INTO @PriceID(PriceID)  
	from tOrders t (nolock)
   inner join tPrice p (updlock)
           on p.DetailNum = t.DetailNumber
		  and p.MakeLogo  = t.MakeLogo -- производитель
   where t.OrderID       = @OrderID

  -- расчет финнасовых показателей
  delete pOrdersFinIn from pOrdersFinIn (rowlock) where spid = @@Spid
  insert pOrdersFinIn
        (Spid, OrderID)
  Select @@spid, t.OrderID
    from @PriceID p     
   inner join tOrders t (nolock)
           on t.PriceID = p.PriceID

  exec OrdersFinCalc @IsSave = 1

  if @TargetStateID > 0
  begin
      delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid
      insert pAccrualAction 
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
exec setOV 'OrderUpdate', 'P', '20240813', '7'
go
 