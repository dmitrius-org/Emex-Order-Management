delete from tObjectType
/*
Flag   1 - ������������ ������ ����������
       2 - �������
       4 - ������������ ����� �������
*/
go
insert tObjectType (ObjectTypeID, Brief, Name)       select   1, '�����������',   '���������: ����������� ������������'
insert tObjectType (ObjectTypeID, Brief, Name)       select   2, '������������',  '���������: ������������' -- otUser
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select   3, '������',        '���������: ������', 1
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select   4, '����� �������', '���������: ����� �������', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select   5, '����� �������� � �����������', '����� �������� � �����������', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select   6, '�������',       '���������: �������', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select   7, '�������',       '���������: �������', 4
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select  10, 'Shipments',     '���������: ��������', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select  11, 'Task',          '�������������� �������', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select 101, 'TaskProc',      '��������� �������������� �������', 0




select * From tObjectType-- where flag&4=4
