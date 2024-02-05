drop view if exists vStatus

drop view if exists vNodes
go
/* **********************************************************						
vNodes - ��������� � �������� 
********************************************************** */

create view vNodes

as

--SET DATEFIRST 1;

SELECT n.[NodeID]
      -- ���� ������
      ,n.[Flag] 
      --, '<div class="statusFlag">'+
      --  case when (s.[Flag]&1)>0 then '<span class="flagSystem">u</span>' else '<span class=""></span>' end  + -- ��������� ���
      --  case when (s.[Flag]&2)>0 then '<span class="flagBegin">u</span>' else '<span class=""></span>' end   + -- ��������� ���������
      --  case when (s.[Flag]&4)>0 then '<span class="flagDefault">u</span>' else '<span class=""></span>' end + -- �� ���������         
      --  '</div>' as [Status]        
      --,'<span class="char">test</span>' as test
	  ,n.Brief
      ,n.Name
      ,n.Comment
	  ,n.Type
	  ,Case n.Type
	     when 0 then '������'
		 when 1 then '��������'
		 else ''
       end TypeDescription
      ,sc.StatusColorID as ColorID
      ,sc.[Name]        as Color      
  FROM [tNodes] n (nolock)
  left join [tStatusColor] sc with (nolock index=ao1)
         on sc.[StatusColorID] = n.ColorID
  --left join tUser u  with (nolock index=ao1)
  --       on u.UserID = s.UserID

go
grant all on vNodes to public


select * from vNodes
