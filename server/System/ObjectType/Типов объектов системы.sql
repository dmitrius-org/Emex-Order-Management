delete from tObjectType
/*
Flag   1 - поддерживает модель сосотояния
       2 - Активна
       4 - поддерживает права доступа
*/
go
--insert tObjectType (ObjectTypeID, Brief, Name)       select   1, 'Авторизация',   'Интерфейс: Авторизация пользователя'
insert tObjectType (ObjectTypeID, Brief, Name)       select   2, 'Пользователи',                  'Интерфейс: Пользователи' -- otUser
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select   3, 'Заказы',                        'Интерфейс: Заказы', 1
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select   4, 'Поиск деталей',                 'Интерфейс: Поиск деталей', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select   5, 'Связь клиентов и сотрудников',  'Связь клиентов и сотрудников', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select   6, 'Корзина',                       'Интерфейс: Корзина', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select   7, 'Клиенты',                       'Интерфейс: Клиенты', 4
insert tObjectType (ObjectTypeID, Brief, Name)       select   8, 'Клиенты search',                'Интерфейс: Клиенты search' -- otUser
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select  10, 'Shipments',                     'Интерфейс: Отгрузка', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select  11, 'Task',                          'Автоматические задания', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select  12, 'PayType',                       'Типы платежей', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select  13, 'CancelResponseType',            'Типы ответов на отказы', 0

insert tObjectType (ObjectTypeID, Brief, Name, Flag) select 101, 'TaskProc',                      'Процедуры автоматических заданий', 0
insert tObjectType (ObjectTypeID, Brief, Name, Flag) select 102, 'ModelMetod',                    'Процедуры для модели состояния', 0

select * From tObjectType-- where flag&4=4
