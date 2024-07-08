if OBJECT_ID('ProtocolRollBack') is not null
    drop proc ProtocolRollBack
/*
  ProtocolRollBack - Удаление/откат протокола
*/
go
create proc ProtocolRollBack
as
  declare @r          int = 0
         ,@OldStateID numeric(18,0)  -- ид объекта системы для которого используется модель

   Update o 
      set o.StatusID = p.NewStateID
	     ,o.updDatetime      = GetDate()
	 from pAccrualAction p (nolock)
    inner join tOrders o (updlock)
	        on o.OrderID = p.ObjectID
    where p.Spid        = @@spid
	  and p.retval      = 0
	  and p.NewStateID <> 0

   -- если откатываем действие Добавить в корзину, то нужно затереть BasketId 
   Update o 
      set o.BasketId       = null
	     ,o.EmexQuantity   = null
		 ,o.PricePurchaseF = null
		 ,o.AmountPurchaseF= null
		 ,o.OverPricing    = null
		 ,o.Warning        = ''
		 ,o.Flag           = ((o.Flag & ~1) & ~2)
		 --,o.updDatetime      = GetDate()
	 from pAccrualAction p (nolock)
    inner join tOrders o (updlock)
	        on o.OrderID = p.ObjectID
    inner join tNodes n (nolock)
	        on n.NodeID = p.ActionID
		   and n.Brief  = 'ToBasket'
    where p.Spid        = @@spid
	  and p.retval      = 0
	
   -- если откатываем действие отказать
   Update o 
      set-- o.BasketId       = null
	    -- ,o.EmexQuantity   = null
		-- ,o.PricePurchaseF = null
		-- ,o.AmountPurchaseF= null
		-- ,o.OverPricing    = null
		 --,o.Warning        = ''
		  o.Flag           = ((o.Flag & ~4))
		 ,o.isCancel         = 0
		 --,o.updDatetime      = GetDate()
	 from pAccrualAction p (nolock)
    inner join tOrders o (updlock)
	        on o.OrderID = p.ObjectID
    inner join tNodes n (nolock)
	        on n.NodeID = p.ActionID
		   and n.Brief  = 'ToCancel'
    where p.Spid        = @@spid
	  and p.retval      = 0

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
        ,27	--acRollback	Откат действия     
        --Отменили: Действие=ОфПрПроц,  Состояние=Предоставл, Пользователь=Захарова А.И., Опер.день=30/06/2024, Физ.дата=01/07/2024 12:18:11
        ,'Отменили: Действие=' + isnull(act.Name, '') + ', Состояние='+isnull(ns.Name, '') + ', Пользователь=' + isnull(u.Name, '') + ', Опер.день=' + convert(nvarchar, p.OperDate, 21) +  ', Физ.дата=' +  convert(nvarchar, p.InDateTime, 21)
    from pAccrualAction a (nolock)
   inner join tProtocol p (rowlock)
	       on p.ProtocolID = a.ProtocolID
   inner join tNodes ns (nolock)
           on ns.NodeID  = p.NewStateID 
   inner join tNodes act (nolock)
           on act.NodeID = p.ActionID  
   inner join tUser u (nolock)
           on u.UserID = p.UserID
    where a.Spid        = @@spid
	  and a.retval      = 0
          
  exec MassAuditInsert

  -- удаление протокола
  delete tProtocol
    from pAccrualAction p
   inner join tProtocol o (rowlock)
	        on o.ProtocolID = p.ProtocolID
   where p.Spid        = @@spid
     and p.retval      = 0

 exit_:
 return @r
go
grant exec on ProtocolRollBack to public
go
exec setOV 'ProtocolRollBack', 'P', '20240704', '1'
go
