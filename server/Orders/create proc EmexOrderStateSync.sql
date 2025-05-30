if OBJECT_ID('EmexOrderStateSync') is not null
    drop proc EmexOrderStateSync
/*
  EmexOrderStateSync - Синронизация статусов с emex
*/
go
create proc EmexOrderStateSync
as

set nocount on;

declare @SNode numeric(18, 0) -- начальное состояние
       ,@r     int 

exec GetStartNode
       @ObjectTypeID = 3-- ид объекта системы для которого используется модель
      ,@StatusID    = @SNode output -- Ид начального состояния, данный ид пишется в tOrders.StatusID

delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid

-- 1. По идентификатору OrderDetailSubId
Update p
   set p.OrderID = o.OrderID
      ,p.Tag     = 1 
  from pMovement p (updlock) 
 cross apply (select top 1 *
                from tOrders o (nolock) 
               where o.EmexOrderID      = p.OrderNumber
                 and o.OrderDetailSubId = p.OrderDetailSubId
                 and p.OrderDetailSubId<> ''
               order by o.StatusID -- есть состояние "Возвращено" у котрого такой-же OrderDetailSubId
              ) o 
where p.Spid = @@SPID
  and SUBSTRING(p.OrderDetailSubId, 1,1) = '!'


Update pMovement -- 
   set pMovement.N = p.N
  from (Select ID,
               ROW_NUMBER() over(partition by OrderNumber, DetailNum, CustomerSubId, Reference order by StatusID, isnull(p.Tag, 999)) N
          from pMovement p (nolock)
         where p.Spid = @@Spid
        ) p
  where p.ID = pMovement.ID


-- 2. -- если количество заказа в статусе с признаком не синхронизируем совпадает с количеством всего, то такие заказы вообще не трокаем
UPDATE m
   SET m.Flag = 1
  FROM pMovement m WITH (NOLOCK)
  CROSS APPLY (
      SELECT SUM(o.Quantity) AS OrderQty
       FROM tOrders o WITH (NOLOCK)
      INNER JOIN tNodes n WITH (NOLOCK)
              ON n.NodeID = o.StatusID
             AND n.Flag & 2 = 0
      WHERE o.EmexOrderID   = m.OrderNumber
        AND o.DetailNumber  = m.DetailNum
        AND o.CustomerSubId = m.CustomerSubId
        AND o.Reference     = m.Reference
        AND o.PriceLogo     = m.PriceLogo -- 
  ) o
  CROSS APPLY (
      SELECT SUM(m2.Quantity) AS MovementQty
       FROM pMovement m2 WITH (NOLOCK)
      WHERE m2.spid = @@SPID
        AND m2.OrderNumber    = m.OrderNumber
        AND m2.DetailNum      = m.DetailNum
        AND m2.CustomerSubId  = m.CustomerSubId
        AND m2.Reference      = m.Reference
        AND m2.PriceLogo      = m.PriceLogo
         
  ) q
WHERE m.spid        = @@SPID
  AND q.MovementQty = o.OrderQty;


declare @N int 
--объявляем курсор
DECLARE my_cur CURSOR FOR 
 SELECT distinct N
   FROM pMovement (nolock)
  where spid = @@spid
  order by N

--открываем курсор
OPEN my_cur
--считываем данные первой строки в наши переменные
FETCH NEXT FROM my_cur INTO @N
--если данные в курсоре есть, то заходим в цикл
--и крутимся там до тех пор, пока не закончатся строки в курсоре
WHILE @@FETCH_STATUS = 0
BEGIN
    --2. Количество
    Update p
        set p.OrderID = o.OrderID
           ,p.Tag     = 3 
       from pMovement p (updlock) 
      inner join tNodes n (nolock)
              on n.EID = p.StatusId
      cross apply (select top 1 o.OrderID
                     from tOrders o (nolock) 
                     left join pMovement m (nolock)
                            on m.Spid        = @@spid
                           and m.OrderID     = o.OrderID
                           and m.OrderNumber = o.EmexOrderID 
                    where o.EmexOrderID   = p.OrderNumber
                      and o.DetailNumber  = p.DetailNum            
                      and o.CustomerSubId = p.CustomerSubId
                      and o.Reference     = p.Reference 
                      and o.Quantity      = p.Quantity
                      and o.StatusID      = n.NodeID 

                      and m.OrderID is null

                    order by case when p.PriceLogo = o.PriceLogo then 0 else 1 end
                    ) o   
    where p.Spid = @@SPID
      and isnull(p.OrderID, 0) = 0
      and p.N = @N

    --3. Все остальное
    Update p
       set p.OrderID = o.OrderID
          ,p.Tag     = 4
      from pMovement p (updlock) 
     inner join tNodes n (nolock)
             on n.EID = p.StatusId
     cross apply (select top 1 o.*
                    from tOrders o (nolock) 
                   inner join tNodes nn (nolock)
                           on nn.NodeID = o.StatusID
                         -- and nn.EID   <= p.StatusId
                    left join pMovement m (nolock)
                           on m.Spid        = @@spid
                          and m.OrderID     = o.OrderID
                          and m.OrderNumber = o.EmexOrderID 
                   where o.EmexOrderID   = p.OrderNumber 
                     and o.DetailNumber  = p.DetailNum               
                     and o.CustomerSubId = p.CustomerSubId
                     and o.Reference     = p.Reference 

                     and m.OrderID is null
                   order by  
                            -- case when p.Quantity         = o.Quantity         then 0 else 1 end
                            
                             case when p.PriceLogo        = o.PriceLogo         then 0 else 1 end
                            ,case 
                               when n.NodeID = o.StatusID then 0 
                               when n.EID = 6 /*НЕТ В НАЛИЧИИ*/ then
                                      case 
                                        when nn.EID = 1 /* InWork        	В работе*/            then 2
                                        when nn.EID = 2 /* Purchased	    Закуплено*/           then 20
                                        when nn.EID = 3 /* ReceivedOnStock	Получено на склад*/   then 30
                                        when nn.EID = 4 /* ReadyToSend	    Готово к выдаче*/     then 40
                                        when nn.EID = 5 /* Sent             Отправлено*/          then 50
                                        when nn.EID = 6 /* NOT AVAILABLE	НЕТ В НАЛИЧИИ*/       then 1
                                        --when nn.EID = 0 /**/ 	                                  then 
                                        when nn.EID = 7 /* AGREE	Изменение цены*/              then 70
                                        else 99 -- закуплено в последнюю очередь                  
                                      end
                               else 1 
                             end
                            ,case when p.Quantity         = o.Quantity         then 0 else 1 end -- ??
                            ,case when p.MakeLogo         = o.MakeLogo         then 0 else 1 end -- ??
                            ,case when nn.EID            <= p.StatusId         then 0 else 1 end
                           -- ,nn.EID desc
                  ) o  
    where p.Spid     = @@SPID
      and isnull(p.OrderID, 0) = 0
      and p.N = @N

     exec CloneOrders @N = @N -- разбиение заказа

     --считываем следующую строку курсора
     FETCH NEXT FROM my_cur INTO @N
END

--закрываем курсор
CLOSE my_cur
DEALLOCATE my_cur


     --Update p
     --   set p.Flag    = case
     --                     when p.Quantity<>o.Quantity then isnull(p.Flag, 0)|4 -- изменилось количество
     --                     else isnull(p.Flag, 0) 
     --                   end
     --  from pMovement p (updlock)
     -- inner join tOrders o (nolock) 
     --         on o.OrderID = p.OrderID
     -- where p.Spid = @@SPID

  -- помечаем строки в которых изменилось количество и нет строк для разбиения, т.е. наоборот нужно строки собрать
  Update p
     set p.Flag    = isnull(p.Flag, 0)|8 
    FROM pMovement p (updlock)
   where p.spid = @@spid
     --and p.Flag&4>0
     and not exists (select 1
                       from pMovement pp (nolock)
                      where pp.spid = @@spid
                        and pp.CustomerSubId = pp.CustomerSubId
                        and pp.OrderID is null
                     )

 -- архивируем данные которые пришли с emex. Вызов тут чтобы записать в архив orderID
 exec MovementArchive


 -- чистим ошибочные заказа после разбиения, иногда такое бывает
 /*--
 delete o
   from pMovement p (nolock) 
  inner join tOrders op (rowlock)
          on op.OrderID = p.OrderID 
   --left join tNodes n (nolock)
   --       on n.EID = p.StatusId
  cross apply (select *
                 from tOrders o (nolock) 
                where o.EmexOrderID   = p.OrderNumber
                  and o.DetailNumber  = p.DetailNum            
                  and o.CustomerSubId = p.CustomerSubId
                  and o.Reference     = p.Reference 
                 -- and o.Quantity      = p.Quantity
                 -- and o.StatusID      = n.NodeID 
                  and not exists (select 1
                                    from pMovement m (nolock)
                                   where m.Spid        = @@spid
                                     and m.OrderID     = o.OrderID
                                     and m.OrderNumber = o.EmexOrderID 
                                  )
              ) o   
 where p.Spid = @@SPID
   and p.Flag&8>0
 --*/

 insert pAccrualAction 
       (Spid,   ObjectID,  StateID, ord)
 select @@Spid, p.OrderID, o.StatusID, 0
   from pMovement p (nolock)
  inner join tOrders o (nolock) 
          on o.OrderID = p.OrderID
  where p.Spid = @@SPID


 Update p
    set p.Retval     = 1 
       ,p.Message   = 'Не синхронизируем'
   from pAccrualAction p (updlock)
  inner join pMovement m (nolock)
          on m.spid    = @@spid
         and m.OrderID = p.ObjectID
  inner join tOrders o (nolock)
          on o.OrderID = m.OrderID
  inner join tNodes n (nolock)
          on n.NodeID = o.StatusID
         and n.Flag&2=0
  where p.Spid = @@Spid
    and isnull(p.Retval, 0) = 0


 ---- для добавления протокола
 Update pAccrualAction
    set ActionID   = n.NodeID
       ,NewStateID = isnull(s.NodeID, p.StateID)
       ,Retval     = case
                       when isnull(s.NodeID, p.StateID) = p.StateID and m.Flag&8 =0  then 1 -- в случае если состояние не меняется не добавляем протокол
                       else 0
                     end  
       ,Message   = m.StateText 
       ,OperDate  = m.DocumentDate
   from pAccrualAction p (updlock)
  inner join pMovement m (nolock)
          on m.spid    = @@spid
         and m.OrderID = p.ObjectID
  inner join tNodes s (nolock)
          on s.EID = m.StatusId
  inner join tNodes n (nolock)  
          on n.Brief = 'AutomaticSynchronization'
  where p.Spid = @@Spid
    and isnull(p.Retval, 0) = 0


 exec ProtocolAdd

 Update o
    set o.StatusID = n.NodeID
       ,o.isCancel = case
                       --При отказе по причине "Нет в наличии", если отказ по всему количеству, изменять статус на "Нет в наличии", в столбец отказ проставлять True
                       when p.StatusId  = 6 /*NotAvailable*/ /*and p.Quantity = o.Quantity*/  then 1
                       --При отказе по причине "Изменение цены" проставлять отказ "Изменение цены" и подтягивать новую цену в столбец "Цена фактическая", в столбец отказ проставлять True
                       when p.StatusId  = 7 /*AGREE*/  then 1
                       else 0
                     end
       ,o.Warning  = case
                       when p.StatusId  = 5 /*Sent*/  then p.Comment
                       else o.Warning
                     end
       ,o.Flag     = case
                       when p.StatusId  = 5 /*Sent*/ then ((o.Flag & ~1) & ~2)
                       when p.StatusId in (6, 7) then (o.Flag & ~8192 ) /*8192 - Перезаказан*/
                       else o.Flag 
                     end
       ,o.updDatetime = GetDate()
       ,o.ReplacementMakeLogo     = p.ReplacementMakeLogo
       ,o.ReplacementDetailNumber = p.ReplacementDetailNumber
       --,o.ReplacementPrice        = case 
       --                               when isnull(p.PriceSale, 0) > 0 and p.PriceSale <> o.PricePurchase then p.PriceSale
       --                               else o.PricePurchase
       --                             end    
        /*Если у детали обновляется цена, то прописывать ее не стрелкой внизу, а в поле “Цена закупки Факт” и ставить красную стрелочку перед ней. Но делать это в одну строку. 
		Таким образом мы увидим какое превышение цены было пропущено в работу менеджером, а какое прислал сам поставщик. Пересчитывать сумму закупки Факт соответственно.*/
       ,o.PricePurchaseF         = case 
                                      when isnull(p.PriceSale, 0) > 0 and p.PriceSale <> o.PricePurchase then p.PriceSale
                                      else o.PricePurchase
                                    end   									
       ,o.OrderDetailSubId        = p.OrderDetailSubId
       ,o.Invoice                 = case 
	                                  when CHARINDEX('#', StateText) > 0 
	                                  then SUBSTRING(StateText, CHARINDEX('#', StateText) +1, CHARINDEX(',', StateText) - CHARINDEX('#', StateText)-1 )
                                      else o.Invoice
                                    end
       ,o.Box                 = case 
	                                  when CHARINDEX('box:', p.StateText) > 0 
	                                  then SUBSTRING(p.StateText, CHARINDEX('box:', p.StateText) + LEN('box:'), LEN(p.StateText))
                                      else o.Box
                                    end
       ,o.DeliveredDateToSupplier = case -- Доставлена поставщику
                                      when n.Brief  in ('ReceivedOnStock' /*Получено на склад*/
									                   ,'ReadyToSend'     /*Готово к выдаче*/)
									  then p.DocumentDate
                                      else o.DeliveredDateToSupplier
                                    end
       ,o.Quantity                = p.Quantity	       	   					          
	   ,o.DateDeparture           = case --Добавить дату вылета (дата когда статус сменился на Отгружено)
                                      when p.StatusId  = 5 /*Sent*/  then p.DocumentDate
                                      else o.DateDeparture
                                    end 
   from pMovement p (nolock)
  inner join pAccrualAction aa (nolock)
          on aa.Spid     = @@spid
         and aa.ObjectID = p.OrderID
         and aa.Retval   = 0
  inner join tOrders o (updlock) 
          on o.OrderID = p.OrderID
   left join tNodes n (nolock)
          on n.EID = p.StatusId
 where p.Spid = @@SPID

 -- пересчитываем суммы
 update o 
    set o.AmountPurchaseF = o.Quantity * o.PricePurchaseF
   from pMovement p (nolock) 
  inner join tOrders o (updlock)
          on o.OrderID = p.OrderID and o.Quantity * isnull(o.PricePurchaseF, 0) <> isnull(o.AmountPurchaseF, 0)
  where p.Spid = @@SPID

 update o 
    set o.AmountPurchase = o.Quantity * o.PricePurchase
   from pMovement p (nolock) 
  inner join tOrders o (updlock)
          on o.OrderID = p.OrderID and o.Quantity * o.PricePurchase <> o.AmountPurchase
  where p.Spid = @@SPID

 update o 
    set o.Amount = o.Quantity * o.Price
   from pMovement p (nolock) 
  inner join tOrders o (updlock)
          on o.OrderID = p.OrderID and o.Quantity * o.Price <> o.Amount
  where p.Spid = @@SPID



 -- расчет сроков дотавки
 delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
 insert pDeliveryTerm (Spid, OrderID)
 Select distinct @@spid, OrderID
   from pMovement (nolock)
  where Spid = @@SPID
  
 exec OrdersDeliveryTermCalcNext @IsSave = 1



 -- Данные по инвойсам
 delete pShipments from pShipments (rowlock) where Spid = @@Spid 
 insert pShipments
       (Spid, Invoice, ShipmentsDate)           
 select distinct
        @@SPid      
       ,case 
 	        when CHARINDEX('#', StateText) > 0 
 	        then SUBSTRING(StateText, CHARINDEX('#', StateText) +1, CHARINDEX(',', StateText) - CHARINDEX('#', StateText)-1 )
             else ''
        end Invoice
       ,DocumentDate
   from pMovement (nolock)
  where Spid = @@Spid
    and case 
          when CHARINDEX('#', StateText) > 0 
          then SUBSTRING(StateText, CHARINDEX('#', StateText) +1, CHARINDEX(',', StateText) - CHARINDEX('#', StateText)-1 )
          else ''
        end <> ''
 
 exec ShipmentsRefresh


/*
-- ситуация когда деталь разделисась, а после на все пришел отказ одной строкой 
declare @Archiving ID

;with p as ( SELECT 
          o.OrderID
         ,o.OrderNum   
         ,o.DetailNumber 
         ,o.CustomerSubId
         ,o.Reference    
         --,max(o.EmexQuantity) EmexQuantity
         --,Sum(o.Quantity)     SumQuantity
         --,max(o.QuantityOrg)  SumQuantityOrg
    FROM pMovement p (nolock)
   inner join tOrders o WITH (NOLOCK)
           on o.EmexOrderID   = p.OrderNumber 
          and o.DetailNumber  = p.DetailNum               
          and o.CustomerSubId = p.CustomerSubId
          and o.Reference     = p.Reference 
          and o.StatusID = 9
          and o.Quantity > 0
   WHERE p.Spid = @@Spid 
   group by o.OrderID
           ,o.OrderNum 
           ,o.DetailNumber 
           ,o.CustomerSubId
           ,o.Reference    
           ,o.PriceLogo    
  having  max(o.EmexQuantity)=Sum(o.Quantity)
)
insert @Archiving (ID)
select distinct
       o.OrderID
  from p
 inner join tOrders o (nolock)
         on o.OrderNum     = p.OrderNum
        and o.DetailNumber = p.DetailNumber
        and o.CustomerSubId= p.CustomerSubId
        and o.Reference    = p.Reference  
 where not exists (select 1
                     from p as p2
                    where p2.OrderID=o.OrderID)
   and exists (select 1
                 from tOrders as o (nolock)
                where o.OrderNum     = p.OrderNum
                  and o.DetailNumber = p.DetailNumber
                  and o.CustomerSubId= p.CustomerSubId
                  and o.Reference    = p.Reference  
                  and o.Quantity     < 0)

exec OrderArchiving
      @OrderID = @Archiving

delete o
  from @Archiving A
 inner join tOrders o (rowlock)
         on o.OrderID = a.ID
*/
 exit_:
 return @r
go
grant exec on EmexOrderStateSync to public
go
exec setOV 'EmexOrderStateSync', 'P', '20250215', '10'
go
 
