if OBJECT_ID('EmexOrderStateSync') is not null
    drop proc EmexOrderStateSync
/*
  EmexOrderStateSync - Синронизация статусов с emex
*/
go
create proc EmexOrderStateSync
as

 set nocount on;

 declare @r     int 

 delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid

 exec EmexOrderStatusParser

 -- архивируем данные которые пришли с emex. Вызов тут чтобы записать в архив orderID
 exec MovementArchive

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
         and isnull(m.Flag, 0)&1 = 1
  where p.Spid = @@Spid
    and isnull(p.Retval, 0) = 0



 ---- для добавления протокола
 Update pAccrualAction
    set ActionID   = n.NodeID
       ,NewStateID = isnull(s.NodeID, p.StateID)
       ,Retval     = case
                       -- в случае если состояние не меняется не добавляем протокол
                       when isnull(s.NodeID, p.StateID) = p.StateID and m.Flag&2 =0 then 1 
                       else 0
                     end  
       ,Flag       = case
                       when isnull(s.NodeID, p.StateID) = p.StateID and m.Flag&2 =2 then 2 -- если мы отказались от детали, нужно добавить протокол !!!
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
   from pAccrualAction p (nolock) 
  inner join tOrders o (updlock)
          on o.OrderID = p.ObjectID and o.Quantity * isnull(o.PricePurchaseF, 0) <> isnull(o.AmountPurchaseF, 0)
  where p.Spid   = @@SPID
    and p.Retval = 0

 update o 
    set o.AmountPurchase = o.Quantity * o.PricePurchase
   from pAccrualAction p (nolock) 
  inner join tOrders o (updlock)
          on o.OrderID = p.ObjectID and o.Quantity * o.PricePurchase <> o.AmountPurchase
  where p.Spid   = @@SPID
    and p.Retval = 0

 update o 
    set o.Amount = o.Quantity * o.Price
   from pAccrualAction p (nolock) 
  inner join tOrders o (updlock)
          on o.OrderID = p.ObjectID and o.Quantity * o.Price <> o.Amount
  where p.Spid   = @@SPID
    and p.Retval = 0



 -- расчет сроков дотавки
 delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
 insert pDeliveryTerm (Spid, OrderID)
 Select distinct @@spid, ObjectID
   from pAccrualAction (nolock)
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

 exit_:
 return @r
go
grant exec on EmexOrderStateSync to public
go
exec setOV 'EmexOrderStateSync', 'P', '20250619', '11'
go
 
