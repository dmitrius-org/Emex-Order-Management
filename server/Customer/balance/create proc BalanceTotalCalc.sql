if OBJECT_ID('BalanceTotalCalc') is not null
    drop proc BalanceTotalCalc
/*
  BalanceTotalCalc - 
*/
go
create proc BalanceTotalCalc
              @ClientID       numeric(18, 0)  
as
  set nocount on
  declare @r int
         ,@StatusRequiringPayment varchar(256)

  select @R         = 0

  -- test !!!
  if @ClientID in (57)
    select @ClientID= 39

  select @StatusRequiringPayment = c.StatusRequiringPayment  
    from tClients c (nolock)
   where c.ClientID = @ClientID


  delete pBalanceTotal
    from pBalanceTotal with (rowlock index=ao2)
   where Spid = @@spid

  insert pBalanceTotal with (rowlock)
        (Spid,
         ClientID, 
         StatusID,
         StatusName)
  select @@SPid, @ClientID, 0, 'Всего заказов'      union all 
  select @@SPid, @ClientID, 1, 'Новые'              union all
  select @@SPid, @ClientID, 2, 'В работе'           union all
  select @@SPid, @ClientID, 3, 'На складе в ОАЭ'    union all
  select @@SPid, @ClientID, 4, 'На пути в РФ'       union all
  select @@SPid, @ClientID, 5, 'Готовим к выдаче'   union all
  select @@SPid, @ClientID, 6, 'Задержано'          union all
  select @@SPid, @ClientID, 7, 'Выдано клиенту'

  Update pBalanceTotal
     set OperDate = cast(getdate() as date)
   where Spid     = @@Spid



  if not exists (select 1 
                   from STRING_SPLIT(@StatusRequiringPayment, ';')
                )
      Update pBalanceTotal
         set IsCalc    = 1
       where Spid     = @@Spid
  else
      Update p
         set p.IsCalc    = 1
        from pBalanceTotal p (updlock)
       inner join STRING_SPLIT(@StatusRequiringPayment, ';') AS s
               on s.value = p.StatusID
       where p.Spid     = @@Spid
    

  Update pBalanceTotal
     set OrderSum = isnull(( Select sum(o.Amount) 
                                from tNodes n (nolock)
                               inner join tOrders o (nolock)
                                       on o.ClientID = @ClientID
                                      and o.StatusID = n.NodeID
                               where n.SearchID <> 8 
                              ), 0)
   where Spid     = @@Spid
     and StatusID = 0

  Update p
     set p.OrderSum = isnull(( Select sum(o.Amount) 
                                from tNodes n (nolock)
                               inner join tOrders o (nolock)
                                       on o.ClientID = @ClientID
                                      and o.StatusID = n.NodeID
                               where n.SearchID = p.StatusID
                              ), 0)
   from pBalanceTotal p (updlock)
  where p.Spid     = @@Spid
    and p.StatusID > 0

  -- всего оплат
  Update pBalanceTotal
     set PaySum      = isnull(( select sum(t.Amount * t.Type) from tDocuments t (nolock) where t.ClientID = @ClientID ), 0)
        ,PayType     = 'Всего оплат'
        ,BalanceType = 'Баланс'
   where Spid     = @@Spid
     and StatusID = 0


  -- Баланс
  Update t
     set BalanceSum = (isnull(( select sum(p.OrderSum) from pBalanceTotal p (nolock) where p.spid = @@spid and p.StatusID >= t.StatusID ), 0) - 
                       isnull(( select sum(p.PaySum)   from pBalanceTotal p (nolock) where p.spid = @@spid), 0))  * -1
    from pBalanceTotal t (updlock)
   where t.Spid     = @@Spid
     and (t.isCalc  = 1)

  Update t
     set BalanceSum = (isnull(( select sum(p.OrderSum) from pBalanceTotal p (nolock) where p.spid = @@spid and p.isCalc  = 1 and p.StatusID >= t.StatusID ), 0) - 
                       isnull(( select sum(p.PaySum)   from pBalanceTotal p (nolock) where p.spid = @@spid), 0))  * -1
    from pBalanceTotal t (updlock)
   where t.Spid     = @@Spid
     and t.StatusID = 0
exit_:
return @r
go
grant exec on BalanceTotalCalc to public
go
exec setOV 'BalanceTotalCalc', 'P', '20240917', '2'
go

