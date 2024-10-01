if OBJECT_ID('vSearchHistory') is not null
    drop view vSearchHistory
go
/* **********************************************************						

********************************************************** */

create view vSearchHistory
as 

select DetailNum, ClientID, SearchHistoryID
 from (
        select ROW_NUMBER() over(Partition by ClientID, DetailNum order by SearchHistoryID desc) N, 
               DetailNum,
               ClientID,
               SearchHistoryID
          from tSearchHistory sh with (nolock index=ao1)
       ) as t
 Where t.N = 1
 
go
grant all on vSearchHistory to public
go
exec setOV 'vSearchHistory', 'V', '20240704', '0'
go


