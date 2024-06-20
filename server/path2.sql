alter table tPrice add Fragile bit

go
Update tPrice 
   set Fragile = 1,
       Restrictions = null
 where Restrictions = 'Fragile'
go
--  select * from tPrice where DetailNum = '32906'

--alter table tClients drop column Margin
--alter table tClients drop column Reliability
