if OBJECT_ID('ActionExecuteCheck') is not null
    drop proc ActionExecuteCheck
/*
  ActionExecuteCheck - Проверка возможности выполнения действия
                     - заполнение главной таблицы для выполнения действия: pAccrualAction
*/
go
create proc ActionExecuteCheck
              @ActionID     numeric(18,0)  -- Ид начального состояния 
as
  declare @r          int = 0        
		 ,@NodeBrief  nvarchar(256)

  -- отбор объектов к выполнению действия
  Delete pAccrualAction from pAccrualAction with (rowlock) where spid = @@spid
  Delete pMovement from pMovement with (rowlock) where spid = @@spid

  -- проверки
  if not exists (select 1
                   from tMarks with (nolock index=pk_tMarks)
				  where Spid = @@spid
				    and Type = 3)
  begin
    set @r = 500 -- 'Отсутствуют объекты для выполнения операции!'
	goto exit_
  end

  select @NodeBrief = Brief
    from tNodes (nolock)
   where NodeID = @ActionID 

  if @NodeBrief = 'InBasket'
  begin
      if not exists (select 1
	                      from tSettings with (nolock index=ao2)
		                 where Brief = 'CoeffMaxAgree')
      begin
	      set @r = 502 -- 'Отсутствует настройка [CoeffMaxAgree] Максимальный коэффициент превышения цены продажи для клиента над ценой!'
	      goto exit_
      end

      if not exists (select 1
	                      from tSettings with (nolock index=ao2)
		                 where Brief = 'CoeffMaxAgree'
			               and val = '')
      begin
	      set @r = 503-- 'Необходимо проставить значение настройки [CoeffMaxAgree]. Максимальный коэффициент превышения цены продажи для клиента над ценой!'
	      goto exit_
      end  

  end

 -- if exists (select 1
 --              from tMarks m (nolock)
 --             inner join tOrders o (nolock)
 --                     on o.OrderID = m.ID
	--          where m.Spid = @@spid
	--		    and m.Type = 3
	--		  group by o.ClientID 
	--		  Having count(distinct o.ClientID)  > 1
	--        )
 -- begin
 --   set @r = 516 -- 'Необходимо выделить заказы только одного клиента!'
	--goto exit_
 -- end

  --
  insert into pAccrualAction with (rowlock)
        (Spid,
		 ObjectID,
		 ActionID,
		 StateID,
		 NewStateID,
         Flag,
		 sgn)
  Select @@Spid,
         o.OrderID ,
		 @ActionID,
		 o.StatusID, -- текущее состояние
		 mo.TargetStateID,
         case 
           when @ActionID = 40 then 2
           else 0
         end,
		 1
    from tMarks m with (nolock index=pk_tMarks)
   inner join tOrders o with (nolock index=ao1)
           on o.OrderID = m.ID
   inner join tModel mo with (nolock)
	       on mo.StateID = o.StatusID
		  and mo.ActionID= @ActionID
  where m.Spid = @@spid
	and m.Type = 3

  insert into pAccrualAction with (rowlock) -- если размещаем заказ необходимо докинуть все детали в статусе "В корзине", т.к апи emex формирует заказ на основе всей корзины
        (Spid,
		 ObjectID,
		 ActionID,
		 StateID,
		 NewStateID,
		 sgn)
  Select distinct @@Spid,
         o.OrderID ,
		 p.ActionID,
		 o.StatusID, -- текущее состояние
		 p.NewStateID,
		 2
    from pAccrualAction p with (nolock) 
   inner join tNodes n with (nolock)
           on n.Brief     = 'InWork'	-- В работе
		  and n.NodeID    = p.NewStateID
   inner join tOrders op with (nolock)
           on op.OrderID  = p.ObjectID 
   inner join tClients cp with (nolock)
           on cp.ClientID = op.ClientID


   inner join tClients c with (nolock)
           on c.SuppliersID = cp.SuppliersID
   inner join tOrders o with (nolock)
           on o.ClientID    = c.ClientID
   inner join tNodes n2 with (nolock)
           on n2.NodeID     = o.StatusID
		  and n2.Brief      = 'InBasket'-- В корзине
  where p.Spid = @@spid 
    and not exists (select 1
	                  from pAccrualAction pp with (nolock)
					 where pp.Spid     = @@spid
					   and pp.ObjectID = o.OrderID)



  -- Обновляем pAccrualAction с проверками в одном запросе
  UPDATE pAccrualAction
     SET RetVal = CASE 
                    -- Проверка на пустое наименование
                    WHEN o.DetailName IS NULL OR LTRIM(RTRIM(o.DetailName)) = '' 
                    THEN 540 -- 'Поле наименования пустое!'
     
                    -- Проверка на недопустимые символы
                    WHEN o.DetailName LIKE '%[^а-яА-Я0-9\-\(\)\.\,\ ]%' ESCAPE '\' 
                    THEN 541 -- 'Наименование содержит недопустимые символы!'
     
                    -- Проверка на запрещенные слова
                    WHEN o.DetailName LIKE '%Запчасть%' 
                      OR o.DetailName LIKE '%Запасные части%'
                      OR o.DetailName LIKE '%Автозапчасть%'
                      OR o.DetailName LIKE '%Автозч%'
                      OR o.DetailName LIKE '%Деталь%'
                      OR o.DetailName LIKE '%Автодеталь%'
                      OR o.DetailName LIKE '%Автопринадлежность%'
                      OR o.DetailName LIKE '%Автокомпонент%' 
                    THEN 542 -- 'Наименование содержит запрещенные слова!'
     
                    -- Проверка на только пробелы
                    WHEN LTRIM(RTRIM(o.DetailName)) = '' 
                    THEN 543 -- 'Наименование содержит только пробелы!'
     
                    -- Проверка веса
                    WHEN o.WeightKG = 0  AND (o.WeightKGF IS NULL OR o.WeightKGF = 0) 
                    THEN 544 -- 'Вес Физический из прайса = 0, и Вес Физический Факт пустой или равен 0!'
     
                    ELSE p.RetVal -- Если ошибок нет, оставляем текущее значение
                  END
    FROM pAccrualAction p with (NOLOCK)
   INNER JOIN tNodes n2 with (NOLOCK)
           ON n2.NodeID = p.NewStateID
          AND n2.Brief in ('InChecked', 'InBasket')
   INNER JOIN vOrders o --(nolock) нужно выпилить vOrders
           ON o.OrderID = p.ObjectID
   WHERE p.Spid = @@SPID
     AND p.RetVal = 0;

                         
  if exists (select count(distinct cp.SuppliersID)
               from pAccrualAction p with (nolock)
              inner join tNodes n2 with (nolock)
                      on n2.NodeID = p.NewStateID
	                 and n2.Brief = 'InWork'	-- В корзине
              inner join tOrders o with (nolock)
                      on o.OrderID = p.ObjectID
              inner join tClients cp with (nolock)
                      on cp.ClientID = o.ClientID
	          where p.Spid = @@spid
			 Having count(distinct cp.SuppliersID)  > 1
	        )
  begin
    set @r = 526 -- невозможно разместить заказы так как выбраны детали разных клиентов
	goto exit_
  end

  --
  Update pAccrualAction
     set RetVal = 501 -- 'Не удалось определить целевое состояние!'
    from pAccrualAction p with (updlock)
   where p.Spid = @@SPID
     and isnull(p.NewStateID, 0) = 0

  Update pAccrualAction
     set RetVal = case 
	                when (coalesce(nullif(o.PricePurchase, 0), o.ReplacementPrice, 0) = 0  or isnull(o.AmountPurchase, 0) = 0) then 504-- 'Необходимо заполнить обязательные поля "Цена закупки" и "Сумма закупки"!'
					when isnull(o.Reference, '') = ''     then 513 -- 'Необходимо заполнить обязательное поле "Reference"!'
					when isnull(o.CustomerSubId, '') = '' then 514 -- 'Необходимо заполнить обязательное поле "CustomerSubId"!'
					else 0
                  end
    from pAccrualAction p with (updlock)
   inner join tNodes n2 with (nolock)
           on n2.NodeID = p.ActionID
		  and n2.Brief <> 'ToCancel'	-- Отказать
   inner join tOrders o with (nolock)
           on o.OrderID = p.ObjectID
   where p.Spid   = @@SPID
     and p.RetVal = 0

  Update pAccrualAction
     set RetVal = case 
	                when isnull(pd.DestinationLogo, '') = '' then 518 -- 'Необходимо заполнить обязательное поле "DestinationLogo"!'
					else RetVal
                  end
    from pAccrualAction p with (updlock)
   inner join tNodes n2 with (nolock)
           on n2.NodeID = p.ActionID
		  and n2.Brief  = 'ToBasket' -- Добавить к корзину
   inner join tOrders o with (nolock)
           on o.OrderID = p.ObjectID
   inner join tProfilesCustomer pc with (nolock)
           on pc.ClientPriceLogo = o.CustomerPriceLogo
   inner join vSupplierDeliveryParam pd 
           on pd.ProfilesDeliveryID =  isnull(o.ProfilesDeliveryID, pc.ProfilesDeliveryID)
   where p.Spid   = @@SPID
     and p.RetVal = 0

  Update pAccrualAction
     set RetVal =  538 -- 'Ошибка выполнения действия, по позиции выгружен отказ!'
    from pAccrualAction p with (updlock)
   inner join tNodes n with (nolock)
           on n.NodeID = p.ActionID
		  and n.Brief  = 'ToReNew'
   inner join tOrders o with (nolock)
           on o.OrderID  = p.ObjectID
          and o.StatusID = 12 -- отказан
   where p.Spid   = @@SPID
     and p.RetVal = 0
     and exists (select 1
                    from tUnloadRefusals up with (nolock)
                   where up.ClientID     = o.ClientID
                     and up.DetailNumber = o.DetailNumber 
                     and up.Reference    = o.Reference
                     and up.DetailID     = o.DetailID
                     and up.Quantity     = 0--o.Quantity
                   )
	

   if exists (select 1
                from pAccrualAction with (nolock)
               where Spid   = @@SPID
                 and RetVal <> 0)
     set @r = 506 -- 'Ошибка!'

 exit_:
 return @r
go
grant exec on ActionExecuteCheck to public
go
exec setOV 'ActionExecuteCheck', 'P', '20250320', '6'
go
