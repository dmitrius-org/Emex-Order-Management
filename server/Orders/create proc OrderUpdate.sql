drop proc if exists OrderUpdate
/*
  OrderUpdate - изменение данных по заказу/детали

  -- 20.10.2023 - добавлен расчет финансовых показателей
*/
go
create proc OrderUpdate
               @OrderID                 numeric(18,0)
              ,@DetailNameF             nvarchar(512) = null -- Наименование факт
              ,@WeightKGF               money         = null -- Вес Физический факт	
              ,@VolumeKGF               money         = null -- Вес Объемный факт
              ,@Fragile                 bit           = null 
              ,@NoAir                   bit           = null 
              ,@Price                   nvarchar(64)  = null -- Прайс
              ,@DestinationLogo         nvarchar(64)  = null -- Направление отгрузки 
              ,@Comment                 nvarchar(1024)= null
              ,@TargetStateID           numeric(18,0) = null
              
              
as
  declare @r       int = 0
		 ,@Type    int
		 ,@AuditID  numeric(18,0)

  declare @PriceID as table(PriceID numeric(18, 0))

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

  update t
     set t.PriceLogo       = nullif(@Price, '')
        ,t.DestinationLogo = nullif(@DestinationLogo, '')
		,t.Flag            = isnull(t.Flag, 0) | case  
		                                            when t.PriceLogo <> nullif(@Price, '') then 256 --Был изменен Прайс-лист
							                        else 0
                                                  end
        ,t.Comment         = @Comment                                          
	from tOrders t (updlock)
   where t.OrderID = @OrderID

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

  -- аудит
  exec AuditInsert
         @AuditID          = @AuditID out         
        ,@ObjectID         = @OrderID
        ,@ObjectTypeID     = 3
        ,@ActionID         = 2 -- ИД выполняемое дейстие из tAction
        ,@Comment          = 'Изменение DetailNameF, WeightKGF, VolumeKGF' 
  

  exit_:
  return @r

go
grant exec on OrderUpdate to public
go
exec setOV 'OrderUpdate', 'P', '20240702', '3'
go
 