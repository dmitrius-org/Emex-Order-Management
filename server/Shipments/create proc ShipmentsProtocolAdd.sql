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
                        ShipmentsID numeric(18, 0))

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
  OUTPUT INSERTED.ShipmentsProtocolID, INSERTED.ShipmentsID INTO @ID
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
     set p.Retval = 1
        ,p.Message = 'Не все обязательные параметры заполнены'
	from pAccrualAction p (updlock)
   where p.Spid     = @@spid
     and isnull(p.retval, 0) = 0
     and ( p.NewStateID is null
        or p.ActionID is null)

  -- изменение состояния заказа
  Update s 
     set s.StatusID = p.NewStateID
        ,s.updDatetime = GetDate()
	from @ID id
   inner join pAccrualAction p (nolock)
	       on p.Spid     = @@spid
	      and p.ObjectID = id.ShipmentsID
		  and isnull(p.retval, 0) = 0
  inner join tShipments s (updlock)
          on s.ShipmentsID = p.ObjectID

 exit_:
 return @r
go
grant exec on ShipmentsProtocolAdd to public;
go
exec setOV 'ShipmentsProtocolAdd', 'P', '20240916', '0';
go
 