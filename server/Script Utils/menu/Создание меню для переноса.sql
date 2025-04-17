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
--('TRefusalsT'
--,'TRefusalsT.actUploadingRefusalsEmex'
--,'TRefusalsT.actDelete'
--,'TRefusalsT.actRefreshAll'
--,'TOrdersT.actUploadingRefusalsEmex'
--,'TRefusalsT.actUpload')