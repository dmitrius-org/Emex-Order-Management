alter table tShipments add Flag                            int           -- �������������� ��������  

insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1054, 1054, '������� �������� ������ � 1�',  'TShipmentsT.actSet1C', 63, 1

insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1055, 1055, '����� �������: 1�',  'TShipmentsT.actUnSet1C', 63, 1


update tmenu
  set Caption = '���������� �������: 1�'
  where name = 'TShipmentsT.actSet1C'