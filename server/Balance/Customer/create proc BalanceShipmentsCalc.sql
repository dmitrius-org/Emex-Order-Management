if OBJECT_ID('BalanceShipmentsCalc') is not null
    drop proc BalanceShipmentsCalc
/*
  BalanceShipmentsCalc - 
*/
go
create proc BalanceShipmentsCalc
              @ClientID       numeric(18, 0)  
as
  set nocount on
  declare @r int

  select @R         = 0

  -- test !!!
  --if @ClientID in (57)
  --  select @ClientID= 39

  delete pBalanceShipments
    from pBalanceShipments with (rowlock index=ao2)
   where Spid = @@spid

  insert pBalanceShipments with (rowlock)
        (Spid,
         ClientID, 
         StatusID,
         StatusName,
         OperDate,
         OrderType,
         OrderSum,
         Invoice,
         OperDateS, -- поле для сортировки
         ReceiptDate,
         ReceiptDate2
         )
  select @@spid
        ,@ClientID
        ,n.SearchID
        ,n.SearchBrief
        ,cast(s.ShipmentsDate as date) -- OperDate
        ,max(o.DestinationName) -- OperDateS
        ,sum(o.Amount)
        ,o.Invoice
        ,max(s.ShipmentsDate)-- OperDateS
        ,Max(s.ReceiptDate)
        ,Max(s.ReceiptDate2)
    from tNodes n with (nolock)
   inner join tOrders o with (nolock index =ao2)
           on o.ClientID = @ClientID
          and o.StatusID = n.NodeID
   --       and isnull(Invoice, '') <> ''
   inner join tShipments s (nolock)
           on s.Invoice = o.Invoice

   --cross apply (select max(cast(pr.OperDate as date)) as OperDate,
   --                    max(pr.OperDate) as OperDateS
   --               from tProtocol pr with (nolock index=ao2)
   --              where pr.ObjectID   = o.OrderID
   --                and pr.NewStateID = 8	--Send
   --            ) as pr

   where n.SearchID in ( 
                        
                         4 --На пути в РФ
                        ,5 -- 'Готовим к выдаче' 
                        ,6 -- Задержан
                        ,7 -- 'Выдано клиенту'
                         )

  group by cast(s.ShipmentsDate as date), n.SearchID, n.SearchBrief, o.Invoice

  --select * from tNodes


 -- order by max(pr.OperDates)
--
--order by OrderID desc
  --Update pBalanceTotal
  --   set OperDate = cast(getdate() as date)
  -- where Spid     = @@Spid

  --Update pBalanceTotal
  --   set OrderSum = isnull(( Select sum(o.Amount) 
  --                              from tNodes n (nolock)
  --                             inner join tOrders o (nolock)
  --                                     on o.ClientID = @ClientID
  --                                    and o.StatusID = n.NodeID
  --                             where n.SearchID <> 8 
  --                            ), 0)
  -- where Spid     = @@Spid
  --   and StatusID = 0



  --Update p
  --   set p.OrderSum = isnull(( Select sum(o.Amount) 
  --                              from tNodes n (nolock)
  --                             inner join tOrders o (nolock)
  --                                     on o.ClientID = @ClientID
  --                                    and o.StatusID = n.NodeID
  --                             where n.SearchID = p.StatusID
  --                            ), 0)
  -- from pBalanceTotal p 
  --where p.Spid     = @@Spid
  --  and p.StatusID > 0

  insert pBalanceShipments with (rowlock)
        (Spid,
         ClientID, 
         OperDate,
         PayType,
         PaySum,
         OperDateS)

  select @@SPid
        ,@ClientID
        ,t.Date
        ,p.Name
        ,sum(t.Amount * t.Type) 
        ,CAST(CAST(t.Date AS DATE) AS DATETIME) + CAST(CAST(max(t.inDatetime) AS TIME) AS DATETIME) AS CombinedDateTime
    from tDocuments t (nolock) 
    left join tProperty p (nolock)  
           on p.ObjectTypeID =12
          and p.PropertyID = t.PayType
   where t.ClientID = @ClientID
   group by t.Date, p.Name

  -- select * from tProperty -- Баланс
  Update t
     set BalanceSum = (isnull(( select sum(p.OrderSum) from pBalanceShipments p (nolock) where p.spid = @@spid and p.OperDateS <= t.OperDateS ), 0) -
                       isnull(( select sum(p.PaySum)   from pBalanceShipments p (nolock) where p.spid = @@spid and p.OperDateS <= t.OperDateS), 0)
                       ) * -1  
    from pBalanceShipments t (updlock)
   where t.Spid     = @@Spid


exit_:
return @r
go
grant exec on BalanceShipmentsCalc to public
go
exec setOV 'BalanceShipmentsCalc', 'P', '20240917', '2'
go

