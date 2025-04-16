if OBJECT_ID('RestCalc') is not null
    drop proc RestCalc
/*
  RestCalc - расчет баланса для клиента
*/
go
create proc RestCalc
              @ClientID       numeric(18, 0)  
as
  set nocount on
  declare @r int
         ,@StatusRequiringPayment varchar(256)

  select @R         = 0

  delete pBalanceTotal
    from pBalanceTotal with (rowlock index=ao2)
   where Spid = @@spid

  exec BalanceTotalCalc @ClientID = @ClientID

  if not exists (Select 1
                   from tRest r (nolock)
                  where r.ClientID = @ClientID)
    insert tRest (ClientID, Amount) select @ClientID, 0.0

  Update r
     set r.Amount = t.BalanceSum
    from pBalanceTotal t (nolock)
   inner join tRest r  (updlock) 
           on r.ClientID = t.ClientID    
   where t.Spid     = @@Spid
     and t.StatusID = 0

  if @@ROWCOUNT = 0
    insert tRest with (rowlock)
           (ClientID, Amount)
    select t.ClientID
          ,t.BalanceSum
      from pBalanceTotal t (nolock)   
     where t.Spid     = @@Spid
       and t.StatusID = 0
exit_:
return @r
go
grant exec on RestCalc to public
go
exec setOV 'RestCalc', 'P', '20241112', '1'
go

