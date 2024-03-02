--delete from tMenu
-- приложение для менеджера
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 1,   1,   'Главная',                     'THomeF',       0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 20,  20,  'Заказы',                      'TOrdersT',     0,   0,  '0'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 40,  40,  'Клиенты',                     'TClientsT',    0,   0,  '3'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 60,  60,  'Поставщики',                  'TSuppliersT',  0,   0,  '8'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 63,  63,  'Отгрузка',                    'TShipmentsT',  0,   0,  '10'
--insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 70,  70,  'Сотрудники',                  'TEmployeesT',  0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 80,  80,  'Справочники',                 '',             0,   0,  '5'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 83,  81,  'Прайслисты автозапчастей',    'TPricesT',     0,   80, '12'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 81,  89,  'Статусы',                     'TNodesT',      0,   80, '9'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 82,  82,  'Типы клиентов',               'TClientsTypeT',0,   80, '13'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 90,  90,  'Статистика',                   'TStatisticsT', 0,   0,  '6' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 99,  99,  'Права доступа',               '',             0,   0,  '4'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 100, 100, 'Пользователи (Сотрудники)',   'TUsersT',      0,   99, '2' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 101, 101, 'Группы',                      'TGroupsT',     0,   99, '1' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 200, 200, 'Автоматические задания',      'TTask_T',      0,   0,  '7' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 500, 500, 'Настройки системы',           'TInstrumentT', 0,   0,  '11' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 900, 900, 'Тех. панель',                 'TTexT',        0,   0,  '' 
go
update tMenu set Icon = '0' from tMenu where Name='TOrdersT'
update tMenu set Icon = '1' from tMenu where Name='TGroupsT'
update tMenu set Icon = '2' from tMenu where Name='TUsersT'
update tMenu set Icon = '3' from tMenu where Name='TClientsT'
update tMenu set Icon = '4' from tMenu where MenuID=99
update tMenu set Icon = '5' from tMenu where MenuID=80
update tMenu set Icon = '6' from tMenu where Name='TStatisticsT'
update tMenu set Icon = '7' from tMenu where Name='TTask_T'
update tMenu set Icon = '8' from tMenu where Name='TSuppliersT'
update tMenu set Icon = '9' from tMenu where Name='TNodesT'
update tMenu set Icon = '10' from tMenu where Name='TShipmentsT'
update tMenu set Icon = '11' from tMenu where Name='TInstrumentT'
update tMenu set Icon = '12' from tMenu where Name='TPricesT'
update tMenu set Icon = '13' from tMenu where Name='TClientsTypeT'

select * from tMenu

delete from tMenu where Name = 'TOrdersT.actGroupAction'
delete from tMenu where Name = 'TOrdersT.actGroupDetailNameEdit'
