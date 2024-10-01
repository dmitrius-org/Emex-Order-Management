if OBJECT_ID('ShipmentsStatusSync') is not null
    drop proc ShipmentsStatusSync
/*
  ShipmentsStatusSync - Синронизация статусов с транспортной компанией
*/
go
create proc ShipmentsStatusSync
as

set nocount on;

  declare @r          int = 0

 ---- для добавления протокола
 Update pAccrualAction
    set ActionID   = n2.NodeID
       ,StateID    = s.StatusID
       ,NewStateID = n.NodeID
       ,Retval     = case
                       when n.NodeID = s.StatusID then 1 -- в случае если состояние не меняется не добавляем протокол
                       else 0
                     end  
       ,OperDate  = isnull(p.OperDate, ss.Date)
       ,ord       = n.SID
   from pAccrualAction p (updlock)
  inner join tShipments s (nolock)
          on s.ShipmentsID = p.ObjectID
  
  cross apply (select top 1 *
                 from tShipmentsStatus ss (nolock)
                where ss.Number = s.TransporterNumber
                order by ss.ID desc
              ) as ss

  inner join tNodes n (nolock)
          on n.SID = ss.ID

  inner join tNodes n2 (nolock)  
          on n2.Brief = 'AutomaticSynchronization'

  where p.Spid = @@Spid
    and isnull(p.Retval, 0) = 0
    and not exists (select 1
                      from tShipmentsProtocol sp (nolock)
                     where sp.ShipmentsID = p.ObjectID
                       and sp.NewStateID  = n.NodeID)

 exec ShipmentsProtocolAdd

 exit_:
 return @r
go
grant exec on ShipmentsStatusSync to public
go
exec setOV 'ShipmentsStatusSync', 'P', '20240916', '1'
go
 
