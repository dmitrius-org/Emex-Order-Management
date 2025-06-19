if OBJECT_ID('ShipmentOrdersStatusSync') is not null
    drop proc ShipmentOrdersStatusSync
/*
  ShipmentOrdersStatusSync - 

  pAccrualAction - входящий набор данных
*/
go
create proc ShipmentOrdersStatusSync
as
  set nocount on;

  declare @r  int = 0

  -- проверки
  if not exists (select 1
                   from tMarks (nolock)
				  where Spid = @@spid
				    and Type = 10)
  begin
    set @r = 500 -- 'Отсутствуют объекты для выполнения операции!'
	goto exit_
  end
  -- !!! ---------------------------------------------------------------------
  -- обновление статусов связанных заказов  
  delete pAccrualAction from pAccrualAction (rowlock) where spid = @@Spid
  insert pAccrualAction with (rowlock)
        (Spid, ObjectID, NewStateID, ActionID, OperDate, Message, sgn)
  select @@Spid, 
         o.OrderID, 
         s.StatusID,--NewStateID
         n2.NodeID, --ActionID
         sp.OperDate,
         'Cинхронизация стаусов из Отгрузки',
         13
    from tMarks m (nolock)
   inner join tShipments s (nolock)
          on s.ShipmentsID = m.id
   inner join tShipmentsProtocol sp (nolock)
           on sp.ShipmentsID = s.ShipmentsID
          and sp.NewStateID  = s.StatusID
   inner join tOrders o with (nolock index=ao3)
           on o.Invoice = s.Invoice
          and o.StatusID <> s.StatusID
   inner join tNodes st (nolock)
           on st.NodeID  = o.StatusID
          and st.Flag&16 = 0 -- Прекратить выполнение синхронизации с Поставками
   inner join tNodes n2 (nolock)  
           on n2.Brief = 'AutomaticSynchronization'

   where m.Spid = @@spid
	 and m.Type = 10

   exec ProtocolAdd

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
       ,10        
       ,2 -- acUpdate        
       ,'Cинхронизация стаусов из Отгрузки' 
  from pAccrualAction p (nolock)
 where p.Spid   = @@spid
   and p.Retval = 0
        
   exec MassAuditInsert

  -- !!! ---------------------------------------------------------------------

 exit_:
 return @r
go
grant exec on ShipmentOrdersStatusSync to public;
go
exec setOV 'ShipmentOrdersStatusSync', 'P', '20250618', '0';
go
 