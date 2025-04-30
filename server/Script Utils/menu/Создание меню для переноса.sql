select 'insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select ' 
     + cast(MenuID as varchar) + ', ' + cast(N as varchar) + ', ''' + Caption + ''', ' + ' ''' + Name + ''', ' + cast(ParentID as varchar) + ', ' + cast(Type as varchar) 
from tmenu
--where ParentID=30
order by N desc



--select * from tmenu
--where ParentID=0
--delete
--  from tMenu  
--where name in 
--('TAPIFormT.actUpdate'
--,'TAPIFormT.actInsert'
--,'TAPIFormT.actDelete'
--,'TRefusalsT.actRefreshAll'
--,'TOrdersT.actUploadingRefusalsEmex'
--,'TRefusalsT.actUpload')



--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1048, 1048, 'Изменить',  'TAPIFormT.actUpdate', 1043, 1
--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1047, 1047, 'Добавить',  'TAPIFormT.actInsert', 1043, 1
--insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1046, 1046, 'Удалить',  'TAPIFormT.actDelete', 1043, 1