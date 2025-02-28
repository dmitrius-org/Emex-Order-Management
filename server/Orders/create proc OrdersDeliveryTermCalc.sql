drop proc if exists OrdersDeliveryTermCalc
/*
  OrdersDeliveryTermCalc - расчет сроков доставки при создании заказа:
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
      ,p.DeliveryTerm       = coalesce(p.DeliveryTerm, od.DeliveryTermSupplier, o.DeliveryTerm, 0) -- срок доставки поставщику
      ,p.DeliveryPlanDateSupplier = coalesce(od.DeliveryPlanDateSupplier, o.DeliveryPlanDateSupplier)
  from pDeliveryTerm p (updlock)
 inner join tOrders o (nolock)
         on o.OrderID = p.OrderID
  left join vOrdersDeliverySupplier od 
         on od.OrderID = o.OrderID 
 where p.Spid = @@Spid

-- расчет ближайшей дата вылета
delete pDeliveryDate from pDeliveryDate (rowlock) where spid = @@spid
insert pDeliveryDate with (rowlock)
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
 --inner join tOrders o (nolock)
 --        on o.OrderID = p.OrderID
 where p.Spid = @@spid


if @IsSave = 1
    update o
       set o.DeliveryNextDate         = p.DeliveryNextDate            -- Ближайшая дата вылета
		  ,o.DeliveryDaysReserve      = p.DeliveryDaysReserve         -- Дней запаса до вылета
      from pDeliveryTerm p (nolock)
     inner join tOrders o (updlock)
             on o.OrderID=p.OrderID 
     where p.Spid = @@spid

 exit_:

 return @r
go
  grant exec on OrdersDeliveryTermCalc to public
go
exec setOV 'OrdersDeliveryTermCalc', 'P', '20250204', '14'
go