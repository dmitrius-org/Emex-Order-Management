if OBJECT_ID('vBalanceShipments') is not null
    drop view vBalanceShipments
go
/* **********************************************************						
vBalanceShipments -
********************************************************** */

create view vBalanceShipments

as

Select p.ID
      ,p.Spid
      ,p.ClientID
      ,p.StatusID
      ,p.StatusName
      ,p.OrderType
      ,p.OrderSum
      ,p.Invoice
      ,p.PayType
      ,p.PaySum
      ,p.BalanceType
      ,p.BalanceSum
      ,p.OperDate
      ,p.OperDateS
      ,p.ReceiptDate
      ,nullif(p.ReceiptDate2, p.ReceiptDate) ReceiptDate2
      ,p.IsCalc
      ,p.Flag
  from pBalanceShipments p with (nolock index=ao2)
 where p.Spid = @@spid

go
grant all on vBalanceShipments to public
go
exec setOV 'vBalanceShipments', 'V', '20250217', '1'
go


select * from vBalanceShipments