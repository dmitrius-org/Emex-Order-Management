if OBJECT_ID('vBalanceTotal') is not null
    drop view vBalanceTotal
go
/* **********************************************************						
vBalanceTotal -
********************************************************** */

create view vBalanceTotal

as

Select *
  from pBalanceTotal p (nolock)
 where p.Spid = @@spid

go
grant all on vBalanceTotal to public
go
exec setOV 'vBalanceTotal', 'V', '20240521', '1'
go


select * from vBalanceTotal