--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1047, 1047, '������ ���������� ��������',  'TMainForm.actServerControlPanel', 0, 1

insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1051, 1051, '��������',  'TAPIFormT.actUpdate', 1047, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1050, 1050, '������� ����� ����',  'TAPIFormT.actInsert', 1047, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1049, 1049, '�������',  'TAPIFormT.actDelete', 1047, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1048, 1048, '�������� �������',  'TAPIFormT.actRefreshAll', 1047, 1


insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1053, 1053, '���������/���������� �������',  'TTask_T.actTaskEnabled', 200, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1052, 1052, '������� ������',  'TOrdersT.actDelete', 20, 1