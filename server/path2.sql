alter table tBasket add ItemKey                 varchar(256)


insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 102, 102, '����������',                  'TExceptionsT',            0,   80, '22' 


insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1037, 1037, '��������',  'TExceptionsT.actAdd', 102, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1038, 1038, '��������',  'TExceptionsT.actEdit', 102, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1039, 1039, '�������',  'TExceptionsT.actDelete', 102, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1040, 1040, '�������� �������',  'TExceptionsT.actRefreshAll', 102, 1