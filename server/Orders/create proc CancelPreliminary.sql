if OBJECT_ID('CancelPreliminary') is not null
    drop proc CancelPreliminary
/*
  CancelPreliminary - 
*/
go
create proc CancelPreliminary
        
as
declare @r int = 0

  -- обновление статусов связанных заказов  
  delete pAccrualAction from pAccrualAction (rowlock) where spid = @@Spid
  insert pAccrualAction with (rowlock)
        (Spid, ObjectID, NewStateID, ActionID, OperDate, Message, sgn)
  select @@Spid, 
         o.OrderID, 
         12,-- InCancel	Отказано NewStateID
         16,-- ToCancel	Отказать ActionID
         cast(getdate() as date),
         'Автоматический отказ по истечении 48 часов',
         10
    from tNodes n with (nolock index=ao2)
   inner join tOrders o with (nolock index=ao3)
           on o.StatusID = n.NodeID
   cross apply ( select top 1 *
                   from tProtocol p with (nolock)
                  where p.ObjectID   = o.OrderID
                  order by p.InDateTime desc
                ) as p
  where n.Brief = 'CancelPreliminary'
    and p.NewStateID = o.StatusID
    and p.InDateTime <= dateadd(hh, -48, getdate())
  order by p.InDateTime

  exec ProtocolAdd

 exit_:
 return @r
go
  grant exec on CancelPreliminary to public
go
exec setOV 'CancelPreliminary', 'P', '20250531', '0'
go
 
 