if OBJECT_ID('ProtocolRollBackCheck') is not null
    drop proc ProtocolRollBackCheck
/*
  ProtocolRollBackCheck - Проверка возможности удаления протокола
*/
go
create proc ProtocolRollBackCheck
as
  declare @r          int = 0
         ,@OldStateID numeric(18,0)  -- ид объекта системы для которого используется модель

  if not exists (select 1
                   from tMarks (nolock)
				  where Spid = @@spid
				    and Type = 3)
  begin
    set @r = 500 -- 'Отсутствуют объекты для выполнения операции!'
	goto exit_
  end

  Delete pAccrualAction from pAccrualAction (rowlock) where spid = @@spid

  insert into pAccrualAction
        (Spid,
		 ObjectID,
		 ActionID,
		 ProtocolID,
		 StateID,
		 NewStateID,
		 sgn)
  Select @@Spid,
         p.ObjectID,
		 p.ActionID,
		 p.ProtocolID,
		 p.NewStateID, --текущее состояние
		 p.StateID,
		 5
    from tMarks m (nolock)
   cross apply (select top 1 *
                  from tProtocol p (nolock)
                 where p.ObjectID = m.ID
		         order by p.ProtocolID desc 
              ) p
  where m.Spid = @@spid
	and m.Type = 3

 Update p 
    set p.retval = case 
	                 when n.Brief  = 'InWork'   then 512-- 'Состояние "В работе" запрещено откатывать!'
					 when n.Brief  = 'InCancel' and p.StateID in (3	/*InBasket	В корзине*/) then 515-- 'Состояние "Отказан" запрещено откатывать!'
					 else 0
                   end
   from pAccrualAction p (updlock)
  inner join tNodes n (nolock)
	      on n.NodeID = p.StateID
         and n.Type   = 0
  where p.Spid        = @@spid
    and p.retval      = 0

 Update p 
    set p.retval = 548 -- Отмена операции запрещена: по заказу уже отправлены ответы (отказы)
   from pAccrualAction p (updlock)
  inner join tNodes n with (nolock index=ao1)
	      on n.NodeID = p.StateID
         and n.Brief  = 'InCancel'
         and n.Type   = 0
  inner join tAudit a with (nolock index=ao2)
          on a.ObjectTypeID = 3
         and a.ObjectID = p.ObjectID
         and a.ActionID = 5
  where p.Spid        = @@spid
    and p.retval      = 0

 exit_:
 return @r
go
grant exec on ProtocolRollBackCheck to public
go
exec setOV 'ProtocolRollBackCheck', 'P', '20250531', '2'
go

 