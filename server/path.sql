
--alter table tBasket add InDateTime  datetime default getdate()        -- ���� ���������� ������ � �������


delete from tMenu where MenuID=65
delete from tMenu where MenuID=66
--Update tMenu
--   set Name = 'TInstructionT'
-- where Name = 'TConfluenceT'


insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 65,  65,  '����������',                  'TInstructionT', 0,   64, ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 66,  66,  '����������',                  'TInstructionDevT', 0,   64, ''




alter table tSupplierDeliveryProfiles add [Image]            nvarchar(256)
alter table tSupplierDeliveryProfiles add [ImageHelp]        nvarchar(2048)



Update tSupplierDeliveryProfiles
   set [Image] = '<i class="fa fa-plane"></i>'
      ,ImageHelp = '�������� ��������: ������� ������������: ������ � ������. ���� �������� ������� ���������� ��������� ������ ��� ��������� ����. � �������� �� ����������� ������� ����. ����� ��������� ������������� ����������� ��� � ������� ��������, ��� ������ ������ ������������� � ��������������������� ������ ( �����, ������� ������������ � �.�.)'
   where Name = 'ADQ-Express'
   

Update tSupplierDeliveryProfiles
   set [Image] = '<i class="fa fa-car"></i>'
      ,ImageHelp = '����������� ��������: ��������� ������������ � ���������� � ����������� � �������� ���������. ���� �������� ������� ���������� 90% �������, �� ��� �������� ������� � ������� �������� ����� ����� ������� ������������ ��������.'
   where Name = 'ADQ-Charter'
   


Update tSupplierDeliveryProfiles
   set [Image] = '<i class="fa fa-ship"></i>'
      ,ImageHelp = '������������ ��������: ����� ������� ������ �������� ������, �� �� � ����� ������. ���� ������ �������� ��� �������� ������� ��� ������� ������� � ������� �������. ����� ����� ���������� ����� ������� ����: �����, ������� ������������ � ������������� � ��� �����.�'
   where Name = 'ADQ-Container'

delete from tSettings 
where SettingsID in (70,71,72)

