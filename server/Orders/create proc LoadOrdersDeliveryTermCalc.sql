drop proc if exists LoadOrdersDeliveryTermCalc
/*
  LoadOrdersDeliveryTermCalc - расчет сроков доставки при создании заказа:

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
create proc LoadOrdersDeliveryTermCalc
              @IsSave bit =  null           
as
set nocount on;
SET DATEFIRST 1 ;  

declare @r int = 0

Update p
   set p.ClientID           = o.ClientID
      ,p.OrderDate          = o.OrderDate
      ,p.PriceLogo          = o.PriceLogo
      ,p.DestinationLogo    = isnull(nullif(o.DestinationLogo, ''), pd.DestinationLogo) 
      ,p.ProfilesDeliveryID = o.ProfilesDeliveryID
  from pDeliveryTerm p (nolock)
 inner join tOrders o (nolock)
         on o.OrderID = p.OrderID
  left join tSupplierDeliveryProfiles pd (nolock)
         on pd.ProfilesDeliveryID = o.ProfilesDeliveryID
 where p.Spid = @@Spid

Update p   
   set p.DeliveryPlanDateSupplier  =  case 
                                        when t.DeliveryTerm < 5 -- В прайсах со сроком меньше 5 дней учитывать выходные как не рабочие дни
                                        then dbo.AddDaysAndWeekends(p.OrderDate, t.DeliveryTerm, 1)
                                        else DATEADD(dd, t.DeliveryTerm, p.OrderDate)
                                      end
      ,p.DeliveryTerm = t.DeliveryTerm
  from pDeliveryTerm p (nolock)
 inner join tPrices t (nolock)
         on t.Name = p.PriceLogo
 where p.Spid = @@Spid

/*В системе можно выставить несколько дней доставки, поэтому обрабатываем в курсоре*/
declare @N int
       ,@Name nvarchar(15)

Declare @DeliveryNextDate table 
                                 (OrderID           numeric(18,0) 
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
			 when DATEPART(dw, p.DeliveryPlanDateSupplier) < @N
			 -- успеваем на этой неделе
			 then DATEADD(dd, @N - DATEPART(dw, p.DeliveryPlanDateSupplier), p.DeliveryPlanDateSupplier)

			 else (select DATEADD(DAY, @N - DATEPART(WEEKDAY, p2.wkNextDate), p2.wkNextDate)  -- начало недели
					 from (select DATEADD(wk, 1, p.DeliveryPlanDateSupplier) as wkNextDate) as p2
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
   set   /*Считаем дни запаса до вылета по формуле: (Ближайшая Дата Вылета) - (Плановая Дата Поступления Поставщику)
            Если Остаток Срока до Поступления Поставщику <0, начинаем считать параметр по другому алгоритму: 
            (Ближайшая Дата Вылета) - (Сегодня)
            Считаем до тех пор, пока статус детали не изменится на “Отказ”, или “Отправлено” */
		  p.DeliveryDaysReserve      = case
		                                    when datediff(dd, p.DeliveryPlanDateSupplier, p.DeliveryNextDate) > 0
											  then datediff(dd, p.DeliveryPlanDateSupplier, p.DeliveryNextDate)
											  else datediff(dd, p.DeliveryNextDate, GetDate()) 
		                               end
  from pDeliveryTerm p (updlock)
 inner join tOrders o (nolock)
         on o.OrderID = p.OrderID
        and o.StatusID not in (8	--Send
                              ,12--InCancel 
     	                      )
 where p.Spid = @@spid


if @IsSave = 1
    update o
       set o.DeliveryPlanDateSupplier = p.DeliveryPlanDateSupplier
          ,o.DeliveryNextDate         = p.DeliveryNextDate
		  ,o.DeliveryDaysReserve      = p.DeliveryDaysReserve -- Дней запаса до вылета
      from pDeliveryTerm p (nolock)
     inner join tOrders o (updlock)
             on o.OrderID=p.OrderID 
     where p.Spid = @@spid

 exit_:

 return @r
go
  grant exec on LoadOrdersDeliveryTermCalc to public
go
exec setOV 'LoadOrdersDeliveryTermCalc', 'P', '20240322', '1'
go
  