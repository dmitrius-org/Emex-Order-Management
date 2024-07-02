delete pOrdersFinIn

insert pOrdersFinIn (Spid, OrderID)
select @@spid, 39162
exec OrdersFinCalc


select *
from pOrdersFin
where spid = @@spid