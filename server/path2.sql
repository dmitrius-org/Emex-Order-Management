alter table tPrice add Fragile bit

go
Update tPrice 
   set Fragile = 1,
       Restrictions = null
 where Restrictions = 'Fragile'
go
--  select * from tPrice where DetailNum = '32906'

alter table tSupplierDeliveryProfiles add Fragile            float                  -- Наценка за страховку
--alter table tClients drop column Reliability
go
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'isMyDelivery'          ,'Считать с учетом доставки'
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'isIgnore'              ,'Игнорировать детали без веса'
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'Fragile'               ,'Наценка за страховку'

