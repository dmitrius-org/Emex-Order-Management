if OBJECT_ID('ProtocolAdd') is not null
    drop proc ProtocolAdd
/*
  ProtocolAdd - добавление протокола

  pAccrualAction - входящий набор данных
*/
go
create proc ProtocolAdd
as
  set nocount on;

  declare @r          int = 0

  declare @ID as table (ID       numeric(18, 0), 
                        ObjectID numeric(18, 0))
  
  Update p 
     set p.StateID = o.StatusID -- текущий статус
	from pAccrualAction p (updlock)
   inner join tOrders o (nolock)
	       on o.OrderID = p.ObjectID
  where p.Spid     = @@spid
    and p.retval = 0
    and isnull(p.StateID, 0) = 0


  Update p 
     set p.Retval = 539
        ,p.Message= 'Объект уже находится в текущем статусе!'
	from pAccrualAction p (updlock)
   inner join tOrders o (nolock)
	       on o.OrderID = p.ObjectID
          and o.StatusID = p.NewStateID 
  where p.Spid   = @@spid
    and p.retval = 0

  insert into tProtocol with (rowlock)
        (ObjectID    
        ,StateID 
		,NewStateID 
        ,ActionID    
        ,OperDate  
        ,Comment   
        ,Flag
        ,UserID      
        )
  OUTPUT INSERTED.ProtocolID, INSERTED.ObjectID INTO @ID
  Select p.ObjectID
        ,p.StateID
		,p.NewStateID
		,p.ActionID		
		,isnull(p.OperDate, getDate())
		,isnull(p.Message, '')
        ,p.Flag
		,dbo.GetUserID()
    from pAccrualAction p (nolock)
   where p.Spid              = @@spid
     and isnull(p.retval, 0) = 0

  Update p 
     set p.ProtocolID = id.ID
    from @ID id
   inner join pAccrualAction p (Updlock)
	       on p.Spid     = @@spid
	      and p.ObjectID = id.ObjectID

  -- изменение состояния заказа
  Update o 
     set o.StatusID = p.NewStateID
        ,o.isCancel = case
	                    when ns.Brief = 'InCancel' then 1
						when act.Brief = 'ToReNew' then 0 -- вернуть в работу
		                else o.isCancel 
		              end
	    ,o.Flag     = case
	                    when ns.Brief = 'InCancel' then (isnull (o.flag, 0) | 4 /*Отказан*/) 
                                                                        & ~8192 /*Перезаказан*/
						when act.Brief = 'ToReNew' then isnull (o.flag, 0) & ~4 -- признак "Отказан"
					    else o.flag
	                  end
        ,o.updDatetime = GetDate()
	from @ID id
   inner join pAccrualAction p (nolock)
	       on p.Spid     = @@spid
	      and p.ObjectID = id.ObjectID
		  and p.retval = 0
   inner join tOrders o (updlock)
	       on o.OrderID = id.ObjectID
   inner join tNodes ns (nolock)
           on ns.NodeID = p.NewStateID
   inner join tNodes act (nolock)
           on act.NodeID = p.ActionID



  --! расчет статистики по заказам
  declare @Orders as ID
  insert @Orders (ID) select ObjectID from @ID
  
  EXEC PartsStatisticsCalc @Orders = @Orders;

 exit_:
 return @r
go
grant exec on ProtocolAdd to public;
go
exec setOV 'ProtocolAdd', 'P', '20241122', '4';
go
 