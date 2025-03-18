if OBJECT_ID('EmexCreateOrderCheck') is not null
    drop proc EmexCreateOrderCheck
/*
  EmexCreateOrderCheck - проверка на то, что деталь уже заказана

*/
go
create proc EmexCreateOrderCheck
as
set nocount on;
declare @r int

Update pAccrualAction
   set RetVal  = 534 -- '[EmexCreateOrderCheck] Деталь уже размещена!'
      ,Message = ' OrderNumber: ' + convert(varchar(30), m.OrderNumber) + ', ' + convert(varchar(30),  m.DocumentDate, 120)

  from pAccrualAction p (nolock)
 inner join tOrders o(nolock)
         on o.OrderID = p.ObjectID
 inner join pMovement m (nolock)
         on m.Spid          = @@SPID
		and m.Reference     = o.Reference
		and m.CustomerSubId = o.CustomerSubId
        and ((o.Flag&524288 > 0 /*Деталь разделена на части менеджером*/ and m.PriceLogo = o.PriceLogo)
          or (o.Flag&524288 = 0)
            )
 where p.Spid   = @@SPID
   and p.RetVal = 0

Delete pAccrualAction -- нужно чтобы не добавлялся протокол
  from pAccrualAction p (rowlock)
 where p.Spid   = @@SPID
   and p.RetVal = 0
   and exists (select 1
                 from pAccrualAction p (rowlock)
                where p.Spid   = @@SPID
                  and p.RetVal = 534)
 exit_:
 return @r
go
grant exec on EmexCreateOrderCheck to public
go
exec setOV 'EmexCreateOrderCheck', 'P', '20240521', '4'
go
 
--Select * from pMovement where DetailNum='0RF0323806'
--Select * from tOrders where DetailNumber='0RF0323806'