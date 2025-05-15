--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1047, 1047, 'Панель управления сервером',  'TMainForm.actServerControlPanel', 0, 1

insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1051, 1051, 'Изменить',  'TAPIFormT.actUpdate', 1047, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1050, 1050, 'Создать новый ключ',  'TAPIFormT.actInsert', 1047, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1049, 1049, 'Удалить',  'TAPIFormT.actDelete', 1047, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1048, 1048, 'Обновить таблицу',  'TAPIFormT.actRefreshAll', 1047, 1


insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1053, 1053, 'Включение/выключение задания',  'TTask_T.actTaskEnabled', 200, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1052, 1052, 'Удалить запись',  'TOrdersT.actDelete', 20, 1