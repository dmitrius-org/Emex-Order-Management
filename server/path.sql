alter table tSupplierDeliveryProfiles alter column DenVyleta          nvarchar(256) 


Update tSupplierDeliveryProfiles
set DenVyleta = case 

                  when DenVyleta = 1 then '�����������'
                  when DenVyleta = 2 then '�������'
                  when DenVyleta = 3 then '�����'
                  when DenVyleta = 4 then '�������'
                  when DenVyleta = 5 then '�������'
                  when DenVyleta = 6 then '�������'
                  when DenVyleta = 7 then '�����������'
                 end


alter table tOrders add DeliveryNextDate2               datetime       -- ��������� ���� ������, �������������� ���� ������ ���� DeliveryNextDate	
alter table hOrders add DeliveryNextDate2               datetime       -- ��������� ���� ������, �������������� ���� ������ ���� DeliveryNextDate	


alter table tOrders add DateDeparture                   datetime       -- �������� ���� ������ 
alter table tOrders add DaysInWork                      int            -- ���� � ������


alter table hOrders add DateDeparture                   datetime       -- �������� ���� ������ 
alter table hOrders add DaysInWork                      int            -- ���� � ������


update o
   set o.DateDeparture = p.OperDate
  from tOrders o (updlock)
 cross apply (select top 1 *
                from tProtocol p 
               where p.ObjectID= o.OrderID
			     and p.NewStateID in (8)
               order by p.ProtocolID
			) p


delete
  from tMenu  
where name in 
('TRefusalsT'
,'TRefusalsT.actUploadingRefusalsEmex'
,'TRefusalsT.actDelete'
,'TRefusalsT.actRefreshAll'
,'TOrdersT.actUploadingRefusalsEmex'
,'TOrdersT.actUploadingRefusals'
,'TRefusalsT.actUpload')

insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 30,  30,  '������',                      'TRefusalsT',   0,   0,  '19'
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 997, 997, '�������',  'TRefusalsT.actUpload', 30, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 998, 998, '�������',  'TRefusalsT.actDelete', 30, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 999, 999, '��������',  'TRefusalsT.actRefreshAll', 30, 1
insert tmenu (MenuID,N,Caption,Name,ParentID,Type) select 1000, 1000, '���������� ������ Emex',  'TRefusalsT.actUploadingRefusalsEmex', 30, 1


insert tMenu (MenuID, N, Caption, Name, Type, ParentID, Icon) select 64,  64,  '����������',                  'TInstructionsT', 0,   0,'20'

select * from tMenu where MenuID = 64

delete from tMenu where MenuID = 64