delete pOrdersFinIn

insert pOrdersFinIn (Spid, OrderID)
select @@spid, 
OrdersFinCalc