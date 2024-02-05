delete from pMovement where spid = @@spid

select Quantity, EmexQuantity, OrderDetailSubId, *
from tOrders
where DetailNumber ='5533038601'
begin tran

update pMovement
  set Spid=@@spid
from pMovement 
 where DetailNum ='5533038601'



select * from pMovement  where spid = @@spid


exec OrderArchive

delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid

-- 1. ѕо идентификатору OrderDetailSubId
Update p
   set p.OrderID = o.OrderID
      ,p.Tag     = 1 
    --  ,p.Flag    = isnull(p.Flag, 0)|1 --однозначно определили заказ
  from pMovement p (updlock) 
 cross apply (select top 1 *
                from tOrders o (nolock) 
               where o.EmexOrderID      = p.OrderNumber
                 and o.OrderDetailSubId = p.OrderDetailSubId
                 and p.OrderDetailSubId<> '' ) o 
where p.Spid = @@SPID


Update pMovement
   set pMovement.N = p.N
  from (Select ID,
               ROW_NUMBER() over(partition by OrderNumber, DetailNum, CustomerSubId, Reference order by StatusID, isnull(p.Tag, 999)) N
          from pMovement p (nolock)
         where p.Spid = @@Spid
        ) p
  where p.ID = pMovement.ID


declare @N int 
--объ€вл€ем курсор
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
--и крутимс€ там до тех пор, пока не закончатс€ строки в курсоре
WHILE @@FETCH_STATUS = 0
BEGIN
    --2.  оличество
    Update p
       set p.OrderID = o.OrderID
          ,p.Tag     = 2 
      from pMovement p (updlock) 
      left join tNodes n (nolock)
             on n.EID = p.StatusId
     cross apply (select top 1 *
                    from tOrders o (nolock) 
                   where o.EmexOrderID   = p.OrderNumber
                     and o.DetailNumber  = p.DetailNum            
                     and o.CustomerSubId = p.CustomerSubId
                     and o.Reference     = p.Reference 
                     and o.Quantity      = p.Quantity
                     and o.StatusID      = n.NodeID 
                     and not exists (select 1
                                       from pMovement m (nolock)
                                      where m.Spid        = @@spid
                                        and m.OrderID     = o.OrderID
                                        and m.OrderNumber = o.EmexOrderID 
                                     )
                  ) o   
    where p.Spid = @@SPID
      and isnull(p.OrderID, 0) = 0
      and p.N = @N


    --3. ¬се остальное
    Update p
       set p.OrderID = o.OrderID
          ,p.Tag     = 3
      from pMovement p (updlock) 
      left join tNodes n (nolock)
             on n.EID = p.StatusId
     cross apply (select top 1 o.*
                    from tOrders o (nolock) 
                   inner join tNodes nn (nolock)
                           on nn.NodeID = o.StatusID
                         -- and nn.EID   <= p.StatusId
                   where o.EmexOrderID   = p.OrderNumber 
                     and o.DetailNumber  = p.DetailNum               
                     and o.CustomerSubId = p.CustomerSubId
                     and o.Reference     = p.Reference 
                     and not exists (select 1
                                       from pMovement m (nolock)
                                      where m.Spid        = @@spid
                                        and m.OrderID     = o.OrderID
                                        and m.OrderNumber = o.EmexOrderID 
                                     )
                   order by  
                             case when p.Quantity         = o.Quantity         then 0 else 1 end
                            ,case when p.MakeLogo         = o.MakeLogo         then 0 else 1 end
                            ,case when n.NodeID           = o.StatusID         then 0 else 1 end
                            ,case when p.PriceSale        = o.ReplacementPrice then 0 else 1 end
                            ,case when nn.EID            <= p.StatusId         then 0 else 1 end
                            ,nn.EID desc
                  ) o  
    where p.Spid     = @@SPID
      and p.OrderID is null
      and p.N = @N

     --считываем следующую строку курсора
     FETCH NEXT FROM my_cur INTO @N
END

--закрываем курсор
CLOSE my_cur
DEALLOCATE my_cur

-- архивируем данные которые пришли с emex. ¬ызов тут чтобы записать в архив orderID
exec MovementArchive

--
Update p
   set p.Flag    = case
                     when p.Quantity<>o.Quantity then isnull(p.Flag, 0)|4 -- изменилось количество
                     else isnull(p.Flag, 0) 
                   end
  from pMovement p (nolock)
 inner join tOrders o (updlock) 
         on o.OrderID = p.OrderID
 where p.Spid = @@SPID

-- помечаем строки в которых изменилось количество и нет строк дл€ разбиени€, т.е. наоборот нужно строки собрать
Update p
   set p.Flag    = isnull(p.Flag, 0)|8 
  FROM pMovement p (nolock)
 where p.spid = @@spid
   and p.Flag&4>0
   and not exists (select 1
                     from pMovement pp (nolock)
                    where pp.spid = @@spid
                      and pp.CustomerSubId = pp.CustomerSubId
                      and pp.OrderID is null
                   )

 exec CloneOrders2 -- разбиение заказа

 delete o
   from pMovement p (updlock) 
  inner join tOrders op (nolock)
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
 -- and isnull(p.OrderID, 0) = 0
 -- and p.N = @N

/*   
--
declare @OrderID   numeric(18, 0) 
       ,@Quantity  int
       ,@OrderID2  numeric(18, 0) 
       ,@Quantity2 int
--объ€вл€ем курсор
DECLARE my_cur CURSOR FOR 
 SELECT distinct N
   FROM pMovement p (nolock)
  where p.spid = @@spid
    and p.Flag&8>0
  order by N

--открываем курсор
OPEN my_cur
FETCH NEXT FROM my_cur INTO @N
WHILE @@FETCH_STATUS = 0
BEGIN

  --  select @N

    DECLARE my_cur2 CURSOR FOR 
     SELECT op.OrderID, p.Quantity-op.Quantity, o.OrderID, o.Quantity
       from pMovement p (updlock) 
      inner join tOrders op (nolock)
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
     -- and isnull(p.OrderID, 0) = 0
      and p.N = @N

    --открываем курсор
    OPEN my_cur2
    FETCH NEXT FROM my_cur2 INTO @OrderID, @Quantity, @OrderID2, @Quantity2
    WHILE @@FETCH_STATUS = 0
    BEGIN

         select @N

         --считываем следующую строку курсора
         FETCH NEXT FROM my_cur2 INTO @OrderID, @Quantity, @OrderID2, @Quantity2
    END

    --закрываем курсор
    CLOSE my_cur2
    DEALLOCATE my_cur2

    --считываем следующую строку курсора
    FETCH NEXT FROM my_cur INTO @N
END

--закрываем курсор
CLOSE my_cur
DEALLOCATE my_cur


--*/

 insert pAccrualAction 
       (Spid,   ObjectID,  StateID, ord)
 select @@Spid, p.OrderID, o.StatusID, 0
   from pMovement p (nolock)
  inner join tOrders o (updlock) 
          on o.OrderID = p.OrderID
  where p.Spid = @@SPID
  --  and isnull(p.Flag, 0)&4=0

 ---- дл€ добавлени€ протокола
 Update pAccrualAction
    set ActionID   = n.NodeID
       ,NewStateID = isnull(s.NodeID, p.StateID)
       ,Retval     = case
                       when isnull(s.NodeID, p.StateID) = p.StateID and m.Flag&8=0 then 1 -- в случае если состо€ние не мен€етс€ не добавл€ем протокол
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

 --declare @Invoiceas table (InvoiceNumber nvarchar(64), InvoiceDate datetime)

 Update o
    set o.StatusID = n.NodeID
       ,o.isCancel = case
                       --ѕри отказе по причине "Ќет в наличии", если отказ по всему количеству, измен€ть статус на "Ќет в наличии", в столбец отказ проставл€ть True
                       when p.StatusId  = 6 /*NotAvailable*/ /*and p.Quantity = o.Quantity*/  then 1
                       --ѕри отказе по причине "»зменение цены" проставл€ть отказ "»зменение цены" и подт€гивать новую цену в столбец "÷ена фактическа€", в столбец отказ проставл€ть True
                       when p.StatusId  = 7 /*AGREE*/  then 1
                       else 0
                     end
       ,o.Warning  = case
                       when n.Brief  = 'Sent' then p.Comment
                       else o.Warning
                     end
       ,o.Flag     = case
                       when n.Brief  = 'Sent' then ((o.Flag&~1) &~2)
                       else o.Flag 
                     end
       ,o.updDatetime = GetDate()
       ,o.ReplacementMakeLogo     = p.ReplacementMakeLogo
       ,o.ReplacementDetailNumber = p.ReplacementDetailNumber
       ,o.ReplacementPrice        = case 
                                      when isnull(p.PriceSale, 0) > 0 and p.PriceSale <> o.PricePurchase then p.PriceSale
                                      else null
                                    end
       
       ,o.OrderDetailSubId = p.OrderDetailSubId
       ,o.Invoice          = case 
	                           when CHARINDEX('#', StateText) > 0 
	                           then SUBSTRING(StateText, CHARINDEX('#', StateText) +1, CHARINDEX(',', StateText) - CHARINDEX('#', StateText)-1 )
                               else o.Invoice
                             end
       ,o.DeliveredDateToSupplier = case -- ƒоставлена поставщику
                                      when n.Brief  = 'ReceivedOnStock' then p.DocumentDate
                                      else o.DeliveredDateToSupplier
                                    end
       ,o.Quantity = p.Quantity
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

/*
exec ProtocolAdd

-
-- ƒанные по инвойсам
 delete pShipments from pShipments (rowlock) where Spid = @@Spid 
 insert pShipments
       (Spid, 
        Invoice,
        ShipmentsDate)           
 select distinct
        @@SPid      
       ,case 
 	        when CHARINDEX('#', StateText) > 0 
 	        then SUBSTRING(StateText, CHARINDEX('#', StateText) +1, CHARINDEX(',', StateText) - CHARINDEX('#', StateText)-1 )
             else ''
         end
       ,DocumentDate
   from pMovement (nolock)
  where Spid = @@Spid
    and case 
          when CHARINDEX('#', StateText) > 0 
          then SUBSTRING(StateText, CHARINDEX('#', StateText) +1, CHARINDEX(',', StateText) - CHARINDEX('#', StateText)-1 )
          else ''
        end <> ''
 
 exec ShipmentsInsert
--*/
select * from pMovement  where spid = @@spid
--rollback tran
--248

select Quantity, EmexQuantity, OrderDetailSubId, *
from tOrders
where DetailNumber ='5533038601'

--rollback tran