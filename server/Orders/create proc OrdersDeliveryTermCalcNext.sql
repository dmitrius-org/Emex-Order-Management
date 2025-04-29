drop proc if exists OrdersDeliveryTermCalcNext
/*
  OrdersDeliveryTermCalcNext - расчет сроков доставки :
                                 - Следующая ближайшая дата вылета	DeliveryNextDate2
                                 - Дней запаса до вылета

    Считаем дни запаса до вылета по формуле: (Ближайшая Дата Вылета) - (Плановая Дата Поступления Поставщику)

    Если Остаток Срока до Поступления Поставщику <0, начинаем считать параметр по другому алгоритму: 
    (Ближайшая Дата Вылета) - (Сегодня)
    Считаем до тех пор, пока статус детали не изменится на “Отказ”, или “Отправлено”

    @IsSave - сохраняет данные в tOrders
              0 - нет
              1 - да
    
    Входящий набор данных: pDeliveryTerm
    Результат расчета:     pDeliveryTerm
*/
go
create proc OrdersDeliveryTermCalcNext
              @IsSave   bit = null,   
              @IsUpdate bit = null    
as
SET NOCOUNT  ON;
SET DATEFIRST 1;  

declare @r int = 0

select @IsUpdate = isnull(@IsUpdate, 0)

Update p
   set p.ClientID                 = o.ClientID
      ,p.ProfilesDeliveryID       = o.ProfilesDeliveryID	  
	  ,p.DeliveryNextDate         = coalesce(o.DeliveryNextDate2, o.DeliveryNextDate, coalesce(od.DeliveryPlanDateSupplier, 
                                                                                                o.DeliveryPlanDateSupplier))
	  ,p.DeliveryPlanDateSupplier = coalesce(od.DeliveryPlanDateSupplier, 
                                              o.DeliveryPlanDateSupplier)

      ,p.RetVal                   = case 
                                      when isnull(o.DeliveredDateToSupplier, '') <> '' then 1 -- доставлена поставщику
                                      else 0
                                    end
  from pDeliveryTerm p (updlock)
 inner join tOrders o with(nolock index=ao1)
         on o.OrderID = p.OrderID
		and (coalesce(o.DeliveryNextDate2, o.DeliveryNextDate, cast(getdate() as date)) < GetDate() 
          or @IsUpdate = 1)
        and isnull(o.Invoice, '') = '' 
  left join vOrdersDeliverySupplier od 
         on od.OrderID = o.OrderID    
 where p.Spid = @@Spid
 
-- расчет ближайшей дата вылета
delete pDeliveryDate from pDeliveryDate (rowlock) where spid = @@spid
insert pDeliveryDate with (rowlock)
      (Spid, ID, OrderDate, ProfilesDeliveryID)
select @@SPID, 
       OrderID, 
       case 
         when @IsUpdate=1 -- если вызвали зи формы изменения параметров заказа
           then DeliveryPlanDateSupplier
           else DeliveryNextDate -- если пересчитываем следующую дату вылета
       end, 
       ProfilesDeliveryID
  from pDeliveryTerm (nolock)
 where Spid   = @@Spid
   and RetVal = 0

exec DeliveryDateCalc  

Update f 
   set f.DeliveryNextDate2 = p.DeliveryDate -- ближайшая дата вылета
  from pDeliveryDate p with (nolock index=ao1)
 inner join pDeliveryTerm f with (updlock index=ao1)
         on f.Spid    = @@Spid
        and f.OrderID = p.ID
        and f.RetVal = 0
 where p.Spid = @@Spid   

update p
       -- Дней запаса до вылета	
   set /*Считаем дни запаса до вылета по формуле: (Ближайшая Дата Вылета) - (Плановая Дата Поступления Поставщику)
         Если Остаток Срока до Поступления Поставщику <0, начинаем считать параметр по другому алгоритму: 
        (Ближайшая Дата Вылета) - (Сегодня)
         Считаем до тех пор, пока статус детали не изменится на “Отказ”, или “Отправлено” */
		p.DeliveryDaysReserve  = case
                                   when datediff(dd, cast(p.DeliveryPlanDateSupplier as date), p.DeliveryNextDate2) > 0
                                   then datediff(dd, cast(p.DeliveryPlanDateSupplier as date), p.DeliveryNextDate2)
                                   else datediff(dd, p.DeliveryNextDate, GetDate()) 
                                 end
   from pDeliveryTerm p with (updlock index=ao1)
  where p.Spid   = @@spid
    and p.RetVal = 0

/* Перестать отображать в меню “Заказы” в поле “Ближайшая дата вылета” новые варианты дат, 
   если у детали статус сменился на “Отгружена”/ Ставим дату которую получаем по API*/
Update s 
   set s.DeliveryNextDate  = o.OperDate
      ,s.DeliveryNextDate2 = o.OperDate
     -- ,s.DeliveryPlanDateSupplier  = o.DeliveryPlanDateSupplier                   
  from pDeliveryTerm s with (Updlock index=ao1)
 cross apply (select top 1 
                     p.OperDate
                    ,o.DeliveryPlanDateSupplier   
                from tOrders o with (nolock index=ao1)
               inner join tProtocol p with (nolock index=ao2)
                       on p.ObjectID = o.OrderID 
               inner join tNodes n  with (nolock index=ao2)
                       on n.Brief  = 'Send'
                      and n.NodeID = p.NewStateID
              where o.OrderID = s.OrderID

              order by p.ProtocolID desc
             ) o
where s.Spid   = @@SPID
  and s.RetVal = 0 


if @IsSave = 1
    update o
       set o.DeliveryNextDate2    = p.DeliveryNextDate2   -- Следующая ближайшая дата вылета
          ,o.DeliveryDaysReserve2 = p.DeliveryDaysReserve -- Дней запаса до вылета
      from pDeliveryTerm p (nolock)
     inner join tOrders o (updlock)
             on o.OrderID=p.OrderID 
     where p.Spid   = @@spid
       and p.RetVal = 0
	   and isnull(p.DeliveryNextDate, '') <> ''

 exit_:

 return @r
go
  grant exec on OrdersDeliveryTermCalcNext to public
go
exec setOV 'OrdersDeliveryTermCalcNext', 'P', '20250210', '7'
go
  