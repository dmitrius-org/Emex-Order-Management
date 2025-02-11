if OBJECT_ID('vSupplierDeliveryParam') is not null
    drop view vSupplierDeliveryParam
go
/* **********************************************************						
vSupplierDeliveryParam - 
********************************************************** */
create view vSupplierDeliveryParam
as

select s.SuppliersID  
      ,sd.ProfilesDeliveryID -- ������ �� ������� ��������
      ,sd.DestinationLogo
      ,sd.Delivery as DestinationDeliveryTerm -- ���� �������� �� �����������
  from tSuppliers s with (nolock index=ao1)
  left join tSupplierDeliveryProfiles sd with (nolock index=ao1)
         on sd.SuppliersID = s.SuppliersID   

go
grant all on vSupplierDeliveryParam to public
go
exec setOV 'vSupplierDeliveryParam', 'V', '20250211', '0'
go
Select * from vSupplierDeliveryParam
