
--alter table tBasket add Flag                    int


insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1008, 1008, '������',  'TUsersT.actGroup', 100, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1009, 1009, '���� ��������',  'TClientsT.actClientType', 40, 1

Update tMenu
   set N = 31
      ,Caption='��������'
  from tMenu where MenuID = 63

Update tMenu
   set N = 32
  from tMenu where MenuID = 90

insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 600,  600,  '� ���������',                 '',                        0,   0,  '2'
insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 400,  400,  '���������',                   '',                        0,   0,  '11'

--����������
delete
  from tMenu where MenuID in ( 64 --����������
  ,99	--����� �������
  ,101	--������
  ,82	--���� ��������
  )

Update tMenu
   set ParentID = 600
      ,N = 601
  from tMenu where MenuID = 65	--����������

Update tMenu
   set ParentID = 600
      ,N = 602
  from tMenu where MenuID = 66	--����������


Update tMenu
   set ParentID = (select MenuID from tMenu where Name = 'TUsersT.actGroup')
  from tMenu where ParentID = 914

Update tMenu
   set ParentID = 80,
      caption = '����������'
  from tMenu where MenuID =100	--������������ (����������)



  Update tMenu
   set ParentID = 80 ,  N = 82
  from tMenu where MenuID =40	--�������

 Update tMenu
   set ParentID = 80,  N = 81
  from tMenu where MenuID =60--	����������

  Update tMenu
   set   N = 83
  from tMenu where MenuID = 82	--���� ��������

   Update tMenu
   set ParentID = 400
  from tMenu where MenuID in 
  (
  200	--�������������� �������
 ,500	--��������� �������
 ,900	--���. ������
  )
  Update tMenu
   set  N = 401
  from tMenu where MenuID = 200	--�������������� �������

    Update tMenu
   set  N = 502, ParentID = 400
  from tMenu where MenuID = 81	--�������
 

 
 Update tMenu
   set Caption='����������'
  from tMenu where MenuID = 83


  Update tMenu
   set ParentID = (select MenuID from tMenu where Name = 'TClientsT.actClientType')
  from tMenu where ParentID = 82

 
select * from tMenu where Type = 0


