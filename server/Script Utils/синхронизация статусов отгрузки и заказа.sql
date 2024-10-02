 --delete pShipmentsProtocol from pShipmentsProtocol (rowlock) where spid = @@Spid
 --insert pShipmentsProtocol 
 --      (Spid,   ShipmentsID,  StateID, Message, ord)
 --select @@Spid, s.ShipmentsID, s.StatusID, 'Синхранизация статусов с транспортной компанией', 0
 --  from tShipments s (updlock)
 -- where s.ShipmentsID=854

 --exec ShipmentsStatusSync


 --select * from pAccrualAction (rowlock) where spid = @@Spid
 
 -- select * from pShipmentsProtocol (rowlock) where spid = @@Spid




  delete pAccrualAction from pAccrualAction (rowlock) where spid = @@Spid
  insert pAccrualAction 
        (Spid, ObjectID, NewStateID, ActionID, OperDate, Message, sgn)
  select @@Spid, 
         o.OrderID, 
         
         s.StatusID, 
         n2.NodeID, --	Received	Готовим к выдаче клиенту в РФ
         sp.OperDate,
         'Автоматическия синхронизация стаусов из Отгрузки',
         10
    from tShipments s (updlock)
   inner join tOrders o with (nolock index=ao3)
           on o.Invoice = s.Invoice
           and s.StatusID <> o.StatusID
   inner join tNodes n2 (nolock)  
           on n2.Brief = 'AutomaticSynchronization'
  cross apply (select top 1 *
                 from tShipmentsProtocol sp
                where sp.ShipmentsID = s.ShipmentsID
                  and sp.NewStateID is not null
                order by sp.ShipmentsProtocolID desc
                ) as sp

    where 1=1-- s.ShipmentsID = 822
    and  isnull(s.StatusID, 0 ) <> 0
   
   exec ProtocolAdd


    select * from pAccrualAction (rowlock) where spid = @@Spid
