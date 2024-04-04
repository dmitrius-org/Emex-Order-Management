if OBJECT_ID('EmexCreateOrderCheck') is not null
    drop proc EmexCreateOrderCheck
/*
  EmexCreateOrderCheck - 

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
 where p.Spid   = @@SPID
   and p.RetVal = 0

 exit_:
 return @r
go
grant exec on EmexCreateOrderCheck to public
go
exec setOV 'EmexCreateOrderCheck', 'P', '20240402', '2'
go
 
