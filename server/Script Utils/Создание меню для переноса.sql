select 'insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select ' 
     + cast(MenuID as varchar) + ', ' + cast(N as varchar) + ', ''' + Caption + ''', ' + ' ''' + Name + ''', ' + cast(ParentID as varchar) + ', ' + cast(Type as varchar) 
from tmenu
where ParentID=63
order by N 


