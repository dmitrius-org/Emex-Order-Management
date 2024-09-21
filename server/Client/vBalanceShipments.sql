if OBJECT_ID('vBalanceShipments') is not null
    drop view vBalanceShipments
go
/* **********************************************************						
vBalanceShipments -
********************************************************** */

create view vBalanceShipments

as

Select *
  from pBalanceShipments p (nolock)
 where p.Spid = @@spid



go
grant all on vBalanceShipments to public
go
exec setOV 'vBalanceShipments', 'V', '20240918', '0'
go


select * from vBalanceShipments