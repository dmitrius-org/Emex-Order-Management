if OBJECT_ID('SupplierSpecifyDeliveryTime') is not null
    drop proc SupplierSpecifyDeliveryTime
/*
   SupplierSpecifyDeliveryTime - формирование запроса на уточнение срока поставки 
*/
go
create proc SupplierSpecifyDeliveryTime
as
  declare @r        int = 0        

  -- отбор объектов к выполнению действия
  Delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid

  -- проверки
  if not exists (select 1
                   from tMarks with (nolock index = pk_tMarks)
				  where Spid = @@spid
				    and Type = 3)
  begin
    set @r = 500 -- 'Отсутствуют объекты для выполнения операции!'
	goto exit_
  end

  insert into pAccrualAction with (rowlock)
        (Spid,
		 ObjectID,
		 Retval,
		 sgn)
  Select @@Spid,
         m.ID,
		 0,
		 12 -- sgn
    from tMarks m with (nolock index = pk_tMarks)
  where m.Spid = @@spid
	and m.Type = 3

  Update pAccrualAction
     set RetVal = 546 -- 'Запрос существует!'
        ,Message= 'Запрос на уточнение срока поставки существует' + 
                  case
                    when isnull(t.Number, '') <> '' 
                    then ' Номер запроса: ' + t.Number
                    else ''
                  end +
                  case 
                    when isnull(t.StatusID, -1) <> -1
                    then ' Статус: ' +
                         case 
                           when t.StatusID = 0 then 'Открыто'
                           when t.StatusID = 1 then 'В ожидании'
                           when t.StatusID = 2 then 'Закрыто'
                           else ''
                         end
                    else ''
                  end
    from pAccrualAction p  with (updlock index=ao2)
   inner join tAutoCallsToEmex t with (nolock index=ao1)
           on t.OrderID   = p.ObjectID
		  and isnull(t.StatusID, 0) in (0, 1)
   where p.Spid   = @@SPID
     and p.RetVal = 0

  insert tAutoCallsToEmex with (rowlock)
        (OrderID  
        ,Type
        ,InDateTime    
        ,UpdDateTime)
  select p.ObjectID
        ,0 -- запрос на уточнение срока доставки
        ,GetDate()
        ,GetDate()
    from pAccrualAction p  with (nolock index=ao2)
   inner join tOrders o with (nolock index=ao1)
           on o.OrderID = p.ObjectID
 where p.Spid   = @@spid
   and p.Retval = 0


 -- update t
 --    set t.Flag = isnull(t.Flag, 0) | 131072 -- Обращение открыто
	--from pAccrualAction p  with (nolock index=ao1)
 --  inner join tOrders t  with (updlock index=ao1)
 --          on t.OrderID = p.ObjectID
 --  where p.Spid   = @@spid
	-- and p.Retval = 0

  -- аудит
  delete pAuditInsert from pAuditInsert (rowlock) where spid=@@spid
  insert pAuditInsert with (rowlock)
        (Spid
        ,ObjectID
        ,ObjectTypeID
        ,ActionID
        ,Comment
        )
  select @@Spid 
       ,p.ObjectID       	         
       ,3        
       ,2 -- acUpdate        
       ,'Уточнить срок поставки' 
  from pAccrualAction p with (nolock index=ao2)
 where p.Spid   = @@spid
   and p.Retval = 0
        
   exec MassAuditInsert

   if exists (select 1
                from pAccrualAction with (nolock index=ao2)
               where Spid   = @@SPID
                 and RetVal <> 0)
     set @r = 506 -- 'Ошибка!'

 exit_:
 return @r
go
grant exec on SupplierSpecifyDeliveryTime to public
go
exec setOV 'SupplierSpecifyDeliveryTime', 'P', '20250220', '0'
go
 