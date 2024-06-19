drop proc if exists DeliveryDateCalc  
/*
  DeliveryDateCalc - расчет ближайшей дата вылета

  вызываем из LoadOrdersDeliveryTermCalc -> DeliveryDateCalc
  
  Входящий набор данных: pDeliveryDate
  Результат расчета:     pDeliveryDate
*/
go
create proc DeliveryDateCalc
                  
as
  SET NOCOUNT ON; SET DATEFIRST 1 ;  
  
  declare @r int = 0
  
  /*В системе можно выставить несколько дней доставки, поэтому обрабатываем в курсоре*/
  declare @N int
         ,@Name nvarchar(15)
  
  Declare @DeliveryNextDate table (OrderID        numeric(18,0) 
                                  ,DeliveryDate   datetime       -- Ближайшая дата вылета	
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
  		  ,DeliveryDate)
      select p.ID
  	      ,case 
  			 when DATEPART(dw, p.OrderDate) < @N
  			 -- успеваем на этой неделе
  			 then DATEADD(dd, @N - DATEPART(dw, p.OrderDate), p.OrderDate)
  
  			 else (select DATEADD(DAY, @N - DATEPART(WEEKDAY, p2.wkNextDate), p2.wkNextDate)  -- начало недели
  					 from (select DATEADD(wk, 1, p.OrderDate) as wkNextDate) as p2)
  		   end
  	  from pDeliveryDate p (nolock)
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
     set p.DeliveryDate = d.DeliveryDate -- Ближайшая дата вылета	
    from pDeliveryDate p (updlock)
   cross apply (select top 1 * 
                  from @DeliveryNextDate d
  			   where d.OrderID = p.ID
  			   order by d.DeliveryDate
  			  ) d
   where p.Spid = @@spid

 ------------
 exit_:

 return @r
go
  grant exec on DeliveryDateCalc to public
go
exec setOV 'DeliveryDateCalc', 'P', '20240403', '2'
go
  