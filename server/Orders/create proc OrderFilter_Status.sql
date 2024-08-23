if OBJECT_ID('OrderFilter_Status') is not null
    drop proc OrderFilter_Status
/*
  OrderFilter_Status - формирование значений для фильтра статус
*/
go
create proc OrderFilter_Status
as
  declare @r          int = 0

SELECT 
       n.[NodeID]
      ,n.[Name]
  FROM [tNodes] n (nolock)
 where n.Type   = 0 -- состояния
   and n.Brief <> 'Preparation'
 --order by case
 --           when n.Brief = 'Preparation' then 0
 --           else n.NodeID
 --         end
 --        ,n.[NodeID]

 exit_:
 return @r
go
grant exec on OrderFilter_Status to public
go
exec setOV 'OrderFilter_Status', 'P', '20240704', '0'
go
exec OrderFilter_Status 