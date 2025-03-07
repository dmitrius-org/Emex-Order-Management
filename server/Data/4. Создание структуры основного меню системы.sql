-- приложение для менеджера
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 1,   1,   'Главная',                     'THomeF',                  0,   0,  '14'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 20,  20,  'Заказы',                      'TOrdersT',                0,   0,  '0'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 30,  30,  'Ответы',                      'TRefusalsT',              0,   0,  '19'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 40,  40,  'Клиенты',                     'TClientsT',               0,   0,  '3'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 60,  60,  'Поставщики',                  'TSuppliersT',             0,   0,  '8'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 63,  63,  'Отгрузка',                    'TShipmentsT',             0,   0,  '10'
--insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 70,  70,  'Сотрудники',                  'TEmployeesT',             0,   0,  ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 64,  64,  'Информация',                  '',                        0,     0,'20'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 65,  65,  'Инструкции',                  'TInstructionT',           0,   64, ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 66,  66,  'Разработка',                  'TInstructionDevT',        0,   64, ''
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 80,  80,  'Справочники',                 '',                        0,   0,  '5'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 83,  81,  'Прайслисты автозапчастей',    'TPricesT',                0,   80, '12'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 81,  89,  'Статусы',                     'TNodesT',                 0,   80, '9'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 82,  82,  'Типы клиентов',               'TClientsTypeT',           0,   80, '13'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 102, 102, 'Исключения',                  'TExceptionsT',            0,   80, '22' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 90,  90,  'Статистика',                  'TStatisticsT',            0,   0,  '6' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 99,  99,  'Права доступа',               '',                        0,   0,  '4'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 100, 100, 'Пользователи (Сотрудники)',   'TUsersT',                 0,   99, '2' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 101, 101, 'Группы',                      'TGroupsT',                0,   99, '1' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 200, 200, 'Автоматические задания',      'TTask_T',                 0,   0,  '7' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 500, 500, 'Настройки системы',           'TInstrumentT',            0,   0,  '11'                                                                                                                                      
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 900, 900, 'Тех. панель',                 'TTexT',                   0,   0,  '' 
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 67,   67, 'Уведомления',                 'TChatsT',                 0,   0,  '22' 

go
--select * from tMenu
--select * from tMenu where Name = 'TConfluenceT'
--delete from tMenu where Name = 'TOrdersT.actGroupAction'
--delete from tMenu where Name = 'TOrdersT.actGroupDetailNameEdit'

Exceptions
select * from tMenu where ParentID = 0
