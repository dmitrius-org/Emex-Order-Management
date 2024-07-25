drop proc if exists OrdersDeliveryTermCalc
/*
  OrdersDeliveryTermCalc - расчет сроков доставки при создании заказа:

  - Ближайшая дата вылета	
    Добавить настройку дня вылета
    Добавить возможность указывать несколько дней вылета
    Если день вылета пропущен, то есть Ближайшая дата вылета рассчитана как, например, 20.03.2024, 
    сегодня уже 21.03.2024, а запчасть НЕ в статусе “Отправлено”, проставляем внизу следующую дату вылета,
    как с увеличением цены

  - Плановая дата поступления поставщику

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
create proc OrdersDeliveryTermCalc
              @IsSave bit =  null           
as
set nocount on;
SET DATEFIRST 1 ;  

declare @r int = 0

Update p
   set p.ClientID           = o.ClientID
      ,p.OrderDate          = o.OrderDate
      ,p.PriceLogo          = o.PriceLogo
      ,p.ProfilesDeliveryID = o.ProfilesDeliveryID
      ,p.DeliveryPlanDateSupplier  =  case 
	                                    when o.Flag&16>0 then DATEADD(dd, isnull(o.DeliveryTerm, 0), o.OrderDate)
                                        when isnull(t.InWorkingDays, 0) = 1 /*срок в рабочих днях*/ then dbo.AddDaysAndWeekends(o.OrderDate, isnull(t.DeliveryTerm, 0), 1)
                                        else DATEADD(dd, isnull(t.DeliveryTerm, 0), o.OrderDate)
                                      end
      ,p.DeliveryTerm = iif(o.Flag&16>0, isnull(o.DeliveryTerm, 0), isnull(t.DeliveryTerm, 0))
  from pDeliveryTerm p (nolock)
 inner join tOrders o (nolock)
         on o.OrderID = p.OrderID
  left join tPrices t (nolock)
         on t.Name = o.PriceLogo
 where p.Spid = @@Spid

-- расчет ближайшей дата вылета
delete pDeliveryDate from pDeliveryDate (rowlock) where spid = @@spid
insert pDeliveryDate 
      (Spid, ID, OrderDate, ProfilesDeliveryID)
select @@SPID, 
       OrderID, 
       DeliveryPlanDateSupplier, 
       ProfilesDeliveryID
  from pDeliveryTerm (nolock)
 where Spid = @@Spid

exec DeliveryDateCalc  

Update f 
   set f.DeliveryNextDate = p.DeliveryDate -- ближайшая дата вылета
  from pDeliveryDate p with (nolock index=ao1)
 inner join pDeliveryTerm f with (updlock index=ao1)
         on f.Spid    = @@Spid
        and f.OrderID = p.ID
 where p.Spid = @@Spid

update p
   set   /*Считаем дни запаса до вылета по формуле: (Ближайшая Дата Вылета) - (Плановая Дата Поступления Поставщику)
            Если Остаток Срока до Поступления Поставщику <0, начинаем считать параметр по другому алгоритму: 
            (Ближайшая Дата Вылета) - (Сегодня)
            Считаем до тех пор, пока статус детали не изменится на “Отказ”, или “Отправлено” */
		p.DeliveryDaysReserve   = case
		                            when datediff(dd, p.DeliveryPlanDateSupplier, p.DeliveryNextDate) > 0
								    then datediff(dd, p.DeliveryPlanDateSupplier, p.DeliveryNextDate)
									else datediff(dd, p.DeliveryNextDate, GetDate()) 
		                          end
  from pDeliveryTerm p (updlock)
 inner join tOrders o (nolock)
         on o.OrderID = p.OrderID
        and isnull(o.StatusID, 0) not in (8  -- Send
                                         ,12 -- InCancel 
     	                                 )
 where p.Spid = @@spid


if @IsSave = 1
    update o
       set o.DeliveryPlanDateSupplier = p.DeliveryPlanDateSupplier
          ,o.DeliveryNextDate         = p.DeliveryNextDate
		  ,o.DeliveryDaysReserve      = p.DeliveryDaysReserve -- Дней запаса до вылета
		  ,o.DeliveryTerm             = iif(o.Flag&16>0, o.DeliveryTerm, p.DeliveryTerm) -- срок доставки
      from pDeliveryTerm p (nolock)
     inner join tOrders o (updlock)
             on o.OrderID=p.OrderID 
     where p.Spid = @@spid

 exit_:

 return @r
go
  grant exec on OrdersDeliveryTermCalc to public
go
exec setOV 'OrdersDeliveryTermCalc', 'P', '20240619', '10'
go
  