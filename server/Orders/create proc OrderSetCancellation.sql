drop proc if exists OrderSetCancellation
/*
  OrderSetCancellation - установка признака запрошен отказ

*/
go
create proc OrderSetCancellation
as
  declare @r          int = 0        
		 ,@AuditID  numeric(18,0)

  -- отбор объектов к выполнению действия
  Delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid

  -- проверки
  if not exists (select 1
                   from tMarks (nolock)
				  where Spid = @@spid
				    and Type = 3)
  begin
    set @r = 500 -- 'Отсутствуют объекты для выполнения операции!'
	goto exit_
  end

  --select max(sgn) from pAccrualAction
  --
  insert into pAccrualAction
        (Spid,
		 ObjectID,
		 ActionID,
		 StateID,
		 NewStateID,
		 Retval,
		 sgn)
  Select @@Spid,
         o.OrderID,
		 0,
		 o.StatusID, -- текущее состояние
		 0,
		 0,
		 9
    from tMarks m (nolock)
   inner join tOrders o (nolock)
           on o.OrderID = m.ID
  where m.Spid = @@spid
	and m.Type = 3

  update t
     set t.Flag    = isnull(t.Flag, 0) | 128 -- Запрошен отказ, признак проставлен менеджером
	from pAccrualAction p (nolock)
   inner join tOrders t (updlock)
           on t.OrderID = p.ObjectID
   where p.Spid   = @@spid
	 and p.Retval = 0

  -- аудит
  delete pAuditInsert from pAuditInsert (rowlock) where spid=@@spid
  insert pAuditInsert
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
       ,'Установка признака: Запрошен отказ' 
  from pAccrualAction p (nolock)
   where p.Spid   = @@spid
	 and p.Retval = 0
                
   exec MassAuditInsert

   if exists (select 1
                from pAccrualAction (nolock)
               where Spid   = @@SPID
                 and RetVal <> 0)
     set @r = 506 -- 'Ошибка!'

 exit_:
 return @r
go
grant exec on OrderSetCancellation to public
go
exec setOV 'OrderSetCancellation', 'P', '20240418', '1'
go
 