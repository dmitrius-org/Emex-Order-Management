delete from tMenu

-- ���������� ��� ���������
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 1,   1,   '�������',                     'THomeF',       0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 20,  20,  '������',                      'TOrdersT',     0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 40,  40,  '�������',                     'TClientsT',    0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 60,  60,  '����������',                  'TSuppliersT',  0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 63,  63,  '��������',                    'TShipmentsT',  0,   0,  ''
--insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 70,  70,  '����������',                  'TEmployeesT',  0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 80,  80,  '�����������',                 '',             0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 83,  81,  '���������� �������������',    'TPricesT',     0,   80, ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 81,  89,  '�������',                     'TNodesT',      0,   80, ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 82,  82,  '���� ��������',               'TClientsTypeT',0,   80, ''

insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 90,  90,  '����������',                   'TStatisticsT', 0,   0,  '' 

insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 99,  99,  '����� �������',               '',             0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 100, 100, '������������ (����������)',   'TUsersT',      0,   99,  '' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 101, 101, '������',                      'TGroupsT',     0,   99,  '' 

insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 200, 200, '�������������� �������',      'TTask_T',      0,   0,  '' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 500, 500, '��������� �������',           'TInstrumentT', 0,   0,  '' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 900, 900, '���. ������',                 'TTexT',        0,   0,  '' 
go

select * 
from tMenu
where MenuID=63


select * 
from tMenu
where ParentID=63

delete
from tMenu
where ParentID=63


select * from tMenu

delete from tMenu where Name = 'TOrdersT.actGroupAction'
delete from tMenu where Name = 'TOrdersT.actGroupDetailNameEdit'

update tMenu
   set ParentID=964
 where MenuID=965

--delete tGrant
--select * from tMenu where Name = 'TClientsTypeT'
delete tGrant 
insert tGrant
      (ObjectID     
      ,MenuID
      ,ObjectType)
select u.UserID 
      ,m.MenuID
      ,0
  from tUser u (nolock)
 inner join tMenu m (nolock)
         on m.name not in ('TTexT'/*, 'TSearchF', 'TOrdersT2', 'TBasketF'*/)
 where u.Brief='admin'

insert tGrant
      (ObjectID     
      ,MenuID
      ,ObjectType)
select u.GroupID 
      ,m.MenuID
      ,1
  from tGroups u (nolock)
 inner join tMenu m (nolock)
         on m.name not in ('TTexT'/*, 'TSearchF', 'TOrdersT2', 'TBasketF'*/)
 where u.Brief='�����'


