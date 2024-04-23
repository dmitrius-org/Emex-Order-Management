drop proc if exists OrdersDeliveryTermCalc
/*
  OrdersDeliveryTermCalc - расчет сроков доставки :
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
create proc OrdersDeliveryTermCalc
              @IsSave bit =  null           
as
SET NOCOUNT ON; SET DATEFIRST 1 ;  

declare @r int = 0

Update p
   set p.ClientID                   = o.ClientID
      ,p.ProfilesDeliveryID         = o.ProfilesDeliveryID
	  ,p.DeliveryNextDate           = o.DeliveryNextDate
	  ,p.DeliveryNextDate2          = coalesce(o.DeliveryNextDate2, o.DeliveryNextDate) 
	  ,p.DeliveryPlanDateSupplier   = o.DeliveryPlanDateSupplier
  from pDeliveryTerm p (nolock)
 inner join tOrders o (nolock)
         on o.OrderID = p.OrderID
		and coalesce(o.DeliveryNextDate2, o.DeliveryNextDate, '19000101') <= GetDate()
        and o.StatusID not in (8	--Send
		                      ,12	--InCancel 
		                       )
  left join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = o.ProfilesDeliveryID
 where p.Spid = @@Spid

/*В системе можно выставить несколько дней доставки, поэтому обрабатываем в курсоре*/
declare @N int
       ,@Name nvarchar(15)

Declare @DeliveryNextDate table (OrderID           numeric(18,0) 
                                ,DeliveryNextDate  datetime       -- Ближайшая дата вылета	
                                 )

DECLARE cr_Ekv1  CURSOR
FOR
      select 1 N,'Понедельник' Name
union select 2,  'Вторник'
union select 3,  'Среда'
union select 4,  'Четверг'
union select 5,  'Пятница'
union select 6,  'Суббота'
union select 7,  'Воскресенье'
  
OPEN cr_Ekv1
FETCH NEXT FROM cr_Ekv1 INTO @N, @Name

WHILE @@FETCH_STATUS = 0
BEGIN

	insert @DeliveryNextDate
	      (OrderID
		  ,DeliveryNextDate)
		   -- Ближайшая дата вылета	
    select p.OrderID
	      ,case 
			 when DATEPART(dw, p.DeliveryNextDate) < @N
			 -- успеваем на этой неделе
			 then DATEADD(dd, @N - DATEPART(dw, p.DeliveryNextDate2), p.DeliveryNextDate2)

			 else (select DATEADD(DAY, @N - DATEPART(WEEKDAY, p2.wkNextDate), p2.wkNextDate)  -- начало недели
					 from (select DATEADD(wk, 1, p.DeliveryNextDate2) as wkNextDate) as p2
				  )
		   end
	  from pDeliveryTerm p (nolock)
	 inner join tSupplierDeliveryProfiles pd (nolock)
			 on pd.ProfilesDeliveryID = p.ProfilesDeliveryID
			and pd.DenVyleta like '%'+ @Name +'%'
	 where p.Spid = @@spid

NEXT_: 
  
FETCH NEXT FROM cr_Ekv1 INTO @N, @Name
END
  
CLOSE cr_Ekv1
DEALLOCATE cr_Ekv1



update p
       -- Ближайшая дата вылета	
   set p.DeliveryNextDate2 = d.DeliveryNextDate
  from pDeliveryTerm p (updlock)
 cross apply (select top 1 * 
                from @DeliveryNextDate d
			   where d.OrderID = p.OrderID
			   order by d.DeliveryNextDate
			  ) d
 where p.Spid = @@spid

update p
       -- Дней запаса до вылета	
   set /*Считаем дни запаса до вылета по формуле: (Ближайшая Дата Вылета) - (Плановая Дата Поступления Поставщику)
         Если Остаток Срока до Поступления Поставщику <0, начинаем считать параметр по другому алгоритму: 
         (Ближайшая Дата Вылета) - (Сегодня)
         Считаем до тех пор, пока статус детали не изменится на “Отказ”, или “Отправлено” */
		p.DeliveryDaysReserve      = case
		                               when datediff(dd, p.DeliveryPlanDateSupplier, p.DeliveryNextDate) > 0
									   then datediff(dd, p.DeliveryPlanDateSupplier, p.DeliveryNextDate)
									   else datediff(dd, p.DeliveryNextDate, GetDate()) 
		                             end
   from pDeliveryTerm p (updlock)
  --inner join tOrders o (updlock)
  --        on o.OrderID=p.OrderID 
  where p.Spid = @@spid
  --select datediff(dd,'20240319', '20240323') 

if @IsSave = 1
    update o
       set o.DeliveryNextDate2   = p.DeliveryNextDate2
		  ,o.DeliveryDaysReserve = p.DeliveryDaysReserve
      from pDeliveryTerm p (nolock)
     inner join tOrders o (updlock)
             on o.OrderID=p.OrderID 
     where p.Spid = @@spid
	   and isnull(p.DeliveryNextDate, '') <> ''
	     --    ,DateDeparture
      --,DaysInWork   
 exit_:

 return @r
go
  grant exec on OrdersDeliveryTermCalc to public
go
exec setOV 'OrdersDeliveryTermCalc', 'P', '20240323', '1'
go
  