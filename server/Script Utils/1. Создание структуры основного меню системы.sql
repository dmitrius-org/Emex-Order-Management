delete from tMenu

-- приложение для менеджера
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 1,   1,   'Главная',                     'THomeF',       0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 20,  20,  'Заказы',                      'TOrdersT',     0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 40,  40,  'Клиенты',                     'TClientsT',    0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 60,  60,  'Поставщики',                  'TSuppliersT',  0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 70,  70,  'Сотрудники',                  'TEmployeesT',  0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 80,  80,  'Справочники',                 '',             0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 81,  89,  'Статусы',                     'TNodesT',      0,   80, ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 82,  82,  'Типы клиентов',               'TClientsTypeT',0,   80, ''

insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 99,  99,  'Права доступа',               '',             0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 100, 100, 'Пользователи',                'TUsersT',      0,   99,  '' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 101, 101, 'Группы',                      'TGroupsT',     0,   99,  '' 

insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 200, 200, 'Автоматические задания',      'TTask_T',      0,   0,  '' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 500, 500, 'Настройки системы',           'TInstrumentT', 0,   0,  '' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 900, 900, 'Тех. панель',                 'TTexT',        0,   0,  '' 
go

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
         on 1=1
 where u.Brief='Админ'