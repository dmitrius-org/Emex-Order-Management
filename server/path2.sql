alter table tPrice add Fragile bit

go
Update tPrice 
   set Fragile = 1,
       Restrictions = null
 where Restrictions = 'Fragile'
go
--  select * from tPrice where DetailNum = '32906'

alter table tSupplierDeliveryProfiles add Fragile            float                  -- ������� �� ���������
--alter table tClients drop column Reliability
go
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'isMyDelivery'          ,'������� � ������ ��������'
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'isIgnore'              ,'������������ ������ ��� ����'
exec dbo.sys_setTableDescription 'tSupplierDeliveryProfiles', 'Fragile'               ,'������� �� ���������'

