if OBJECT_ID('ShipmentsProtocolAdd') is not null
    drop proc ShipmentsProtocolAdd
/*
  ShipmentsProtocolAdd - добавление протокола

  pAccrualAction - входящий набор данных
*/
go
create proc ShipmentsProtocolAdd
as
  set nocount on;

  declare @r          int = 0

  declare @ID as table (ID          numeric(18, 0), 
                        ShipmentsID numeric(18, 0),
                        OperDate    datetime)

  Update p 
     set p.Retval = 1
        ,p.Message = 'Не все обязательные параметры заполнены'
	from pShipmentsProtocol p (updlock)
   where p.Spid     = @@spid
     and isnull(p.retval, 0) = 0
     and ( p.NewStateID is null
        or p.ActionID is null)

  insert into tShipmentsProtocol with (rowlock)
        (ShipmentsID    
        ,StateID 
		,NewStateID 
        ,ActionID    
        ,OperDate  
        ,Comment   
        ,Flag
        ,UserID      
        )
  OUTPUT INSERTED.ShipmentsProtocolID, INSERTED.ShipmentsID, inserted.OperDate INTO @ID
  Select p.ShipmentsID
        ,p.StateID
		,p.NewStateID
		,p.ActionID		
		,isnull(p.OperDate, getDate())
		,isnull(p.Message, '')
        ,p.Flag
		,dbo.GetUserID()
    from pShipmentsProtocol p (nolock)
   where p.Spid              = @@spid
     and isnull(p.retval, 0) = 0     
   order by p.ord

  -- изменение состояния отгрузки
  Update s 
     set s.StatusID = p.NewStateID
        ,s.updDatetime = GetDate()
	from @ID id
   inner join pShipmentsProtocol p (nolock)
	       on p.Spid     = @@spid
	      and p.ShipmentsID = id.ShipmentsID
  inner join tShipments s (updlock)
          on s.ShipmentsID = p.ShipmentsID


  -- !!! ---------------------------------------------------------------------
  -- обновление статусов связанных заказов  
  delete pAccrualAction from pAccrualAction (rowlock) where spid = @@Spid
  insert pAccrualAction 
        (Spid, ObjectID, NewStateID, ActionID, OperDate, Message, sgn)
  select @@Spid, 
         o.OrderID, 
         s.StatusID,--NewStateID
         n2.NodeID, --ActionID
         id.OperDate,
         'Автоматическия синхронизация стаусов из Отгрузки',
         10
    from @ID id
   inner join tShipments s (updlock)
          on s.ShipmentsID = id.ShipmentsID
   inner join tOrders o with (nolock index=ao3)
           on o.Invoice = s.Invoice
          and o.StatusID <> 26 -- IssuedClient
          and o.StatusID <> s.StatusID

   inner join tNodes n2 (nolock)  
           on n2.Brief = 'AutomaticSynchronization'
   
   exec ProtocolAdd
  -- !!! ---------------------------------------------------------------------

 exit_:
 return @r
go
grant exec on ShipmentsProtocolAdd to public;
go
exec setOV 'ShipmentsProtocolAdd', 'P', '20241002', '1';
go
 