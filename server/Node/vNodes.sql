drop view if exists vNodes
go
/* **********************************************************						
vNodes - 
********************************************************** */
create view vNodes
as
SELECT n.[NodeID]
      -- поле статус
      ,n.[Flag] 
      --, '<div class="statusFlag">'+
      --  case when (s.[Flag]&1)>0 then '<span class="flagSystem">u</span>' else '<span class=""></span>' end  + -- системный тип
      --  case when (s.[Flag]&2)>0 then '<span class="flagBegin">u</span>' else '<span class=""></span>' end   + -- начальное состо¤ние
      --  case when (s.[Flag]&4)>0 then '<span class="flagDefault">u</span>' else '<span class=""></span>' end + -- по умолчанию         
      --  '</div>' as [Status]        
      --,'<span class="char">test</span>' as test
	  ,n.Brief
      ,n.Name
      ,n.Comment
	  ,n.Type
	  ,Case n.Type
	     when 0 then 'Состояние'
		 when 1 then 'Действие'
		 else ''
       end TypeDescription
      ,sc.StatusColorID as ColorID
      ,sc.[Name]        as Color 
      ,n.N

  FROM [tNodes] n (nolock)
  left join [tStatusColor] sc with (nolock index=ao1)
         on sc.[StatusColorID] = n.ColorID
  --left join tUser u  with (nolock index=ao1)
  --       on u.UserID = s.UserID

go
grant all on vNodes to public
go
exec setOV 'vNodes', 'V', '20240915', '2'
go
 
