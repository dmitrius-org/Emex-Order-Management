drop proc if exists OrdersLastDateShipmentCalc
/*
  OrdersLastDateShipmentCalc - расчет дат:
                                 Крайняя дата отгрузки со склада в ОАЭ
                                 Дней до крайней даты отгрузки со склада в ОАЭ
  
  

Крайняя дата отгрузки со склада в ОАЭ
Должна считаться так:
Берем поле “Дата поставки клиенту”, допустим это 15.03.2025
Вычитаем из нее срок поставки по конкретному направлению (на сегодня Авиа 10 дней, Контейнер 35 дней, они указаны в меню “Поставщики” - “Профили доставки” - “Срок доставки“. То есть 15.03.2025 - 10 = 05.03.2025
Находим ближайший день вылета по этому направлению. В нашем случае, он совпадает с результатом вычисления в прошлом пункте - 05.03.2025. Значит в столбце указываем именно эту дату.
Если бы результат в прошлом пункте был бы, к примеру 04.03.2025, то мы должны бы были указать крайним днем вылета 28.02.2025, то есть ближайший предшествующий день вылета.
*/
go
create proc OrdersLastDateShipmentCalc
              @IsSave   bit = null   
as
SET NOCOUNT  ON;
SET DATEFIRST 1;  

declare @r int = 0

Update p
   set p.ClientID                 = od.ClientID
      ,p.ProfilesDeliveryID       = od.ProfilesDeliveryID	  
	  --,p.DeliveryPlanDateSupplier = od.DeliveryNextDate
  from pDeliveryTerm p (updlock)
  left join vOrdersDeliverySupplier od 
         on od.OrderID = p.OrderID    
 where p.Spid = @@Spid

 
update p
   set p.DeliveryRestToCustomer = odc.DeliveryRestToCustomer
      ,p.DeliveryDateToCustomer = odc.DeliveryDateToCustomer
      ,p.DeliveryTermToCustomer = odc.DeliveryTermToCustomer
      ,p.DeliveryTerm           = sdp.DeliveryTermFromSupplier --срок поставки по направлению
  from pDeliveryTerm p (updlock)
 --inner join tOrders o with (nolock index=ao1)
 --        on o.OrderID=p.OrderID 
 --inner join vOrdersDeliverySupplier ods 
 --        on ods.OrderID=p.OrderID 
 inner join vOrdersDeliveryCustomer odc 
         on odc.OrderID=p.OrderID 
 inner join vSupplierDeliveryParam sdp
         on sdp.ProfilesDeliveryID = p.ProfilesDeliveryID
 where p.Spid = @@Spid

-- расчет ближайшей дата вылета
-- 1 
delete pDeliveryDate from pDeliveryDate with (rowlock) where spid = @@spid
insert pDeliveryDate with (rowlock)
      (Spid, ID, OrderDate, ProfilesDeliveryID)
select @@SPID, 
       OrderID, 
       dateadd(dd, -1*DeliveryTerm, DeliveryDateToCustomer),
       ProfilesDeliveryID
  from pDeliveryTerm (nolock)
 where Spid   = @@Spid
   and RetVal = 0

exec DeliveryDateCalc @ToDay=1 

Update f 
   set f.LastDateShipment = p.DeliveryDate -- ближайшая дата вылета
      ,f.OrderDate        = p.OrderDate 
  from pDeliveryDate p with (nolock index=ao1)
 inner join pDeliveryTerm f with (updlock index=ao1)
         on f.Spid    = @@Spid
        and f.OrderID = p.ID
        and f.RetVal = 0
 where p.Spid = @@Spid  

-- расчет ближайшей дата вылета
-- 2 если дата вылета равна OrderDate, то мы ее оставляем
--   если же дата вылета больше OrderDate, то нам нужна дата предыдущего вылета 
delete pDeliveryDate from pDeliveryDate with (rowlock) where spid = @@spid
insert pDeliveryDate with (rowlock)
      (Spid, ID, OrderDate, ProfilesDeliveryID)
select @@SPID, 
       OrderID, 
       dateadd(wk, -1, LastDateShipment),
       ProfilesDeliveryID
  from pDeliveryTerm (nolock)
 where Spid   = @@Spid
   and RetVal = 0
   and OrderDate < LastDateShipment

exec DeliveryDateCalc @ToDay=1  

Update f 
   set f.LastDateShipment = p.DeliveryDate -- ближайшая дата вылета
  from pDeliveryDate p with (nolock index=ao1)
 inner join pDeliveryTerm f with (updlock index=ao1)
         on f.Spid    = @@Spid
        and f.OrderID = p.ID
        and f.RetVal = 0

 where p.Spid = @@Spid 


-- Дней до крайней даты отгрузки со склада в ОАЭ
update p    
   set p.LastTermShipment =case 
                             when n.flag&32 > 0 
                             then datediff(dd, getdate(), p.LastDateShipment) 
                             else o.LastTermShipment
                           end
 from pDeliveryTerm p with (updlock index=ao1)
inner join tOrders o with (nolock index=ao1)
        on o.OrderID=p.OrderID 
inner join tNodes n (nolock)
        on n.NodeID = o.StatusID
where p.Spid   = @@spid
  and p.RetVal = 0
--*/

if @IsSave = 1
begin

  update o
     set o.LastDateShipment = p.LastDateShipment -- Крайняя дата отгрузки со склада в ОАЭ
        ,o.LastTermShipment = p.LastTermShipment -- Дней до крайней даты отгрузки со склада в ОАЭ       
    from pDeliveryTerm p with (nolock index=ao1)
   inner join tOrders o with (updlock index=ao1)
           on o.OrderID=p.OrderID 
   where p.Spid = @@spid

  --update o
  --   set o.DeliveryDateToCustomer = p.DeliveryDateToCustomer 
  --      ,o.DeliveryRestToCustomer = p.DeliveryRestToCustomer 
  --      ,o.DeliveryTermToCustomer = p.DeliveryTermToCustomer
  --  from pDeliveryTerm p (nolock)
  -- inner join tOrdersDeliveryCustomer o with (updlock index=PK_tOrdersDeliveryCustomer_OrderID)
  --         on o.OrderID=p.OrderID 
  -- where p.Spid = @@spid

  --insert tOrdersDeliveryCustomer with (rowlock)
  --      (OrderID,
  --       DeliveryDateToCustomer,
  --       DeliveryRestToCustomer,
  --       DeliveryTermToCustomer)
  --select p.OrderID 
  --      ,p.DeliveryDateToCustomer
  --      ,p.DeliveryRestToCustomer 
  --      ,p.DeliveryTermToCustomer
  --  from pDeliveryTerm p with (nolock index=ao1)
  -- where p.Spid = @@spid
  --   and not exists ( select 1
  --                      from tOrdersDeliveryCustomer o with (nolock index=PK_tOrdersDeliveryCustomer_OrderID)
  --                     where o.OrderID = p.OrderID )
end

 exit_:

 return @r
go
  grant exec on OrdersLastDateShipmentCalc to public
go
exec setOV 'OrdersLastDateShipmentCalc', 'P', '20250515', '0'
go
  

