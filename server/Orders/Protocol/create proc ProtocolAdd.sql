if OBJECT_ID('ProtocolAdd') is not null
    drop proc ProtocolAdd
/*
  ProtocolAdd - добавление протокола

  pAccrualAction - Входящий/Исходящий набор данных
*/
go
create proc ProtocolAdd
as
  set nocount on;

  declare @r               int = 0

  declare @ID as table (ID         numeric(18, 0), 
                        OrderID    numeric(18, 0),
                        OldStateID numeric(18, 0),
                        NewStateID numeric(18, 0),
                        ActionID   numeric(18, 0))
  
  Update p 
     set p.StateID = o.StatusID -- текущий статус
    from pAccrualAction p with (updlock)
   inner join tOrders o with (nolock)
           on o.OrderID = p.ObjectID
  where p.Spid     = @@spid
    and p.retval = 0
    and isnull(p.StateID, 0) = 0

/*  есть действия которые не меняют состояние
  Update p 
     set p.Retval = 539
        ,p.Message= 'Объект уже находится в текущем статусе!'
    from pAccrualAction p with (updlock)
   inner join tOrders o with (nolock)
           on o.OrderID = p.ObjectID
          and o.StatusID = p.NewStateID 
  where p.Spid   = @@spid
    and p.retval = 0
  --*/

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
  OUTPUT INSERTED.ProtocolID, INSERTED.ObjectID, INSERTED.StateID, INSERTED.NewStateID, INSERTED.ActionID  INTO @ID
  Select p.ObjectID
        ,p.StateID
        ,p.NewStateID
        ,p.ActionID        
        ,isnull(p.OperDate, getDate())
        ,isnull(p.Message, '')
        ,p.Flag
        ,dbo.GetUserID()
    from pAccrualAction p with (nolock)
   where p.Spid              = @@spid
     and isnull(p.retval, 0) = 0

  Update p 
     set p.ProtocolID = id.ID
    from @ID id
   inner join pAccrualAction p with (Updlock)
           on p.Spid     = @@spid
          and p.ObjectID = id.OrderID

  -- изменение состояния заказа
  Update o 
     set o.StatusID    = p.NewStateID
        ,o.isCancel    = case
                           when ns.Brief = 'InCancel' then 1
                           when act.Brief = 'ToReNew' then 0 -- вернуть в работу
                           else o.isCancel 
                         end
        ,o.Flag        = case
                           when ns.Brief = 'InCancel' then (isnull (o.flag, 0) | 4 /*Отказан*/) 
                                                                              & ~8192 /*Перезаказан*/
                           when act.Brief = 'ToReNew' then isnull (o.flag, 0) & ~4 -- признак "Отказан"
                           else o.flag
                         end
        ,o.updDatetime = GetDate()
        ,o.DateInWork  = case -- дата перевода в работу
                           when ns.Brief = 'InWork' then cast(getdate() as date)
                           else o.DateInWork
                         end
    from @ID id
   inner join pAccrualAction p with (nolock)
           on p.Spid     = @@spid
          and p.ObjectID = id.OrderID
          and p.retval = 0
   inner join tOrders o with (updlock)
           on o.OrderID = id.OrderID
   inner join tNodes ns with (nolock)
           on ns.NodeID = p.NewStateID
   inner join tNodes act with (nolock)
           on act.NodeID = p.ActionID

  --! Расчет сроков доставки поставщика
  delete pDeliveryTerm from pDeliveryTerm with (rowlock) where spid = @@Spid
  insert pDeliveryTerm with (rowlock) 
        (Spid, OrderID) 
  Select @@spid, OrderID
    from @ID      
   where ActionID = 15 -- ToInWork

  exec OrdersSupplierDeliveryCalc @IsSave = 1

  --
  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm with (rowlock) 
        (Spid, OrderID) 
  Select @@spid, 
         OrderID
    from @ID
   where ActionID = 15 -- ToInWork
  
  exec OrdersDeliveryTermCalcNext @IsSave = 1, @IsUpdate = 1

  -- если ручное изменение даты поступления поставщику
  if OBJECT_ID('tempdb..#ActionParams') is not null
  begin
    update o
       set o.DeliveryPlanDateSupplier = ap.DateValue
          ,o.DeliveryTermSupplier     = DATEDIFF(dd, op.OperDate, ap.DateValue)
          ,o.DeliveryRestTermSupplier = DATEDIFF(dd, getdate(),   ap.DateValue)
      from @ID p
     inner join vOrdersProtocolInWork op 
             on op.OrderID=p.OrderID
     inner join #ActionParams ap (nolock)
             on ap.ActionID = p.ActionID
     inner join tOrdersDeliverySupplier o with (updlock index=PK_tOrdersDeliverySupplier_OrderID)
             on o.OrderID=p.OrderID 
     where p.ActionID = 40 --SetNewDeliveryDate Установить новый срок поставки
  
    insert tOrdersDeliverySupplier with (rowlock)
          (OrderID,
           DeliveryPlanDateSupplier,
           DeliveryTermSupplier,
           DeliveryRestTermSupplier)
    select p.OrderID
          ,ap.DateValue
          ,DATEDIFF(dd, op.OperDate, ap.DateValue)
          ,DATEDIFF(dd, getdate(),   ap.DateValue)
      from @ID p
     inner join vOrdersProtocolInWork op
             on op.OrderID=p.OrderID
     inner join #ActionParams ap (nolock)
             on ap.ActionID = p.ActionID
     where p.ActionID = 40 --SetNewDeliveryDate Установить новый срок поставки
       and not exists ( select 1
                          from tOrdersDeliverySupplier o with (nolock index=PK_tOrdersDeliverySupplier_OrderID)
                         where o.OrderID = p.OrderID )

    update o
       set o.DeliveryRestTermSupplier = op.DeliveryRestTermSupplier
      from @ID p
     inner join tOrdersDeliverySupplier op with (nolock index=PK_tOrdersDeliverySupplier_OrderID)
             on op.OrderID=p.OrderID
     inner join tOrders o with (updlock index=ao1)
             on o.OrderID=p.OrderID 
     where p.ActionID = 40 --SetNewDeliveryDate Установить новый срок поставки

  delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
  insert pDeliveryTerm with (rowlock) 
        (Spid, OrderID) 
  Select @@spid, 
         OrderID
    from @ID
   where ActionID = 40 -- SetNewDeliveryDate    Установить новый срок поставки
  
  exec OrdersDeliveryTermCalcNext @IsSave = 1, @IsUpdate = 1


    delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
    insert pDeliveryTerm with (rowlock) 
          (Spid, OrderID) 
    Select @@spid, 
           OrderID
      from @ID
     where ActionID =40 -- SetNewDeliveryDate    Установить новый срок поставки
    
    exec OrdersDeliveryCustomerTermCalcNext @IsSave = 0
 
  
    insert tChats with (rowlock)   
          (OrderID, ClientID)
    select p.OrderID, odc.ClientID
      from @ID p
     inner join pDeliveryTerm pt (nolock)
             on pt.Spid = @@SPID
            and pt.OrderID = p.OrderID
     inner join vOrdersDeliveryCustomer odc (nolock) 
             on odc.OrderID=pt.OrderID
            and odc.DeliveryDateToCustomer < pt.DeliveryDateToCustomer -- если изменился срок

     where p.ActionID = 40 --SetNewDeliveryDate Установить новый срок поставки
       and not exists (select 1
                         from tChats c (nolock)
                        where c.ClientID = odc.ClientID
                          and c.OrderID  = odc.OrderID)
    declare @Chats as ID
    insert into tChatsMessage with (rowlock)
          ([ChatID]             
          ,[UserID]          
    	  ,[Message]         
    	  ,[Flag]) 
    OUTPUT INSERTED.ChatID INTO @Chats
    select c.ChatID
          ,dbo.GetUserID()
          ,'<p>Изменен срок поставки по детали:<br>' +
            isnull(b.Name, o.Manufacturer) + ' ' + 
            isnull(o.ReplacementDetailNumber, o.DetailNumber) + ' (' +
            cast(o.Quantity as varchar) + ' шт.) по заказу от ' +
            convert(varchar(10), o.OrderDate, 104) + '<br> '+
           'Плановая дата поставки: ' + convert(varchar(10), odc.DeliveryDateToCustomer , 104) + '<br>' +
           'Новая дата поставки: ' + convert(varchar(10), pt.DeliveryDateToCustomer, 104) + '<br><br>' +     
           'Приносим свои извинения за задержку.<br>' +
           '<br>' +
           'Если вы готовы дождаться поставки, напишите "ОК"<br>' +
           'Если вы хотите отказаться, напишите "Отказаться"' +
           '</p>'
          ,1 -- Сообщение из менеджерского приложения
      from @ID p
     inner join pDeliveryTerm pt (nolock)
             on pt.Spid = @@SPID
            and pt.OrderID = p.OrderID
     inner join vOrdersDeliveryCustomer odc (nolock) 
             on odc.OrderID=pt.OrderID
            and odc.DeliveryDateToCustomer < pt.DeliveryDateToCustomer -- если изменился срок

     inner join tOrders o (nolock) 
             on o.OrderID=p.OrderID
      left join tMakes b with (nolock index=ao2) -- брент замены
             on cast(b.Code as nvarchar)= o.ReplacementMakeLogo
     inner join tChats c (nolock)
             on c.OrderID  = o.OrderID
            and c.ClientID = o.ClientID
     where p.ActionID = 40 --SetNewDeliveryDate Установить новый срок поставки

    Update o 
       set o.flag = o.Flag|32 -- Сообщение от менеджера  
      from @Chats p
     inner join tChats t (nolock) 
             on t.ChatID = p.ID
     inner join tOrders o (updlock) 
             on o.OrderID=t.OrderID

    delete pDeliveryTerm from pDeliveryTerm (rowlock) where spid = @@Spid
    insert pDeliveryTerm with (rowlock) 
          (Spid, OrderID) 
    Select distinct
           @@spid, 
           t.OrderID
      from @Chats p
     inner join tChats t (nolock) 
             on t.ChatID = p.ID
    
    exec OrdersDeliveryCustomerTermCalcNext @IsSave = 1
  end

  --! расчет статистики по заказам
  declare @Orders as ID
  insert @Orders (ID) 
  select OrderID 
    from @ID
  
  EXEC PartsStatisticsCalc @Orders = @Orders;

 exit_:
 return @r
go
grant exec on ProtocolAdd to public;
go
exec setOV 'ProtocolAdd', 'P', '20250210', '7';
go
 