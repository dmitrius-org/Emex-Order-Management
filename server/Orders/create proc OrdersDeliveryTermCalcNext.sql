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
  Результат расчета: pDeliveryTerm
*/
go
create proc OrdersDeliveryTermCalcNext
              @IsSave bit =  null           
as
SET NOCOUNT ON;
SET DATEFIRST 1 ;  

declare @r int = 0

Update p
   set p.ClientID                  = o.ClientID
      ,p.ProfilesDeliveryID        = o.ProfilesDeliveryID	  
	  ,p.DeliveryNextDate          = coalesce(o.DeliveryNextDate2, o.DeliveryNextDate) --, cast(GetDate() as date)
	  ,p.DeliveryPlanDateSupplier  = o.DeliveryPlanDateSupplier-- Доставлена поставщику
  from pDeliveryTerm p (updlock)
 inner join tOrders o (nolock)
         on o.OrderID = p.OrderID
		and coalesce(o.DeliveryNextDate2, o.DeliveryNextDate, getdate()) < GetDate()
        and isnull(o.Invoice, '') = '' --+Перестать отображать в меню “Заказы” в поле “Ближайшая дата вылета” новые варианты дат, если у детали статус сменился на “Отгружена” (дополнительно проговорили по телефону, разобрались). Ставим дату которую получаем по API
  left join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = o.ProfilesDeliveryID
 where p.Spid = @@Spid

-- расчет ближайшей дата вылета
delete pDeliveryDate from pDeliveryDate (rowlock) where spid = @@spid
insert pDeliveryDate 
      (Spid, ID, OrderDate, ProfilesDeliveryID)
select @@SPID, 
       OrderID, 
       DeliveryNextDate, 
       ProfilesDeliveryID
  from pDeliveryTerm (nolock)
 where Spid = @@Spid

exec DeliveryDateCalc  

Update f 
   set f.DeliveryNextDate2 = p.DeliveryDate -- ближайшая дата вылета
  from pDeliveryDate p with (nolock index=ao1)
 inner join pDeliveryTerm f with (updlock index=ao1)
         on f.Spid    = @@Spid
        and f.OrderID = p.ID
 where p.Spid = @@Spid


update p
       -- Дней запаса до вылета	
   set /*Считаем дни запаса до вылета по формуле: (Ближайшая Дата Вылета) - (Плановая Дата Поступления Поставщику)
         Если Остаток Срока до Поступления Поставщику <0, начинаем считать параметр по другому алгоритму: 
        (Ближайшая Дата Вылета) - (Сегодня)
         Считаем до тех пор, пока статус детали не изменится на “Отказ”, или “Отправлено” */
		p.DeliveryDaysReserve      = case
		                               when datediff(dd, cast(p.DeliveryPlanDateSupplier as date), p.DeliveryNextDate2) > 0
									   then datediff(dd, cast(p.DeliveryPlanDateSupplier as date), p.DeliveryNextDate2)
									   else datediff(dd, p.DeliveryNextDate, GetDate()) 
		                             end
   from pDeliveryTerm p (updlock)
  where p.Spid = @@spid


Update s 
   set s.DeliveryNextDate  = o.OperDate
      ,s.DeliveryNextDate2 = o.OperDate
      ,s.DeliveryPlanDateSupplier  = o.DeliveryPlanDateSupplier                   
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
where s.Spid = @@SPID


if @IsSave = 1
    update o
       set o.DeliveryNextDate2        = p.DeliveryNextDate2   -- Следующая ближайшая дата вылета
		  ,o.DeliveryDaysReserve2     = p.DeliveryDaysReserve -- Дней запаса до вылета
          ,o.DeliveryRestTermSupplier = p.DeliveryTerm  - DATEDIFF(dd, o.OrderDate, getdate())  -- Остаток срока до поставки поставщику
      from pDeliveryTerm p (nolock)
     inner join tOrders o (updlock)
             on o.OrderID=p.OrderID 
     where p.Spid = @@spid
	   and isnull(p.DeliveryNextDate, '') <> ''

 exit_:

 return @r
go
  grant exec on OrdersDeliveryTermCalcNext to public
go
exec setOV 'OrdersDeliveryTermCalcNext', 'P', '20240911', '4'
go
  