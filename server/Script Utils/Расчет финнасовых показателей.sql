
---- расчет финасовых показателей
delete pOrdersFinIn from pOrdersFinIn where spid = @@Spid
insert pOrdersFinIn
      (Spid
      ,OrderID)
Select @@spid
      ,86319

exec OrdersFinCalc @IsSave = 0


select * from pOrdersFin where spid = @@Spid