if OBJECT_ID('vOrderRefusals') is not null
    drop view vOrderRefusals
go
/* **********************************************************						
vOrderRefusals - Отказы
********************************************************** */
create view vOrderRefusals
as
select OrderRefusalsID
     -- ,Folder
      ,FileName
      ,Flag
      ,InDateTime
  from tOrderRefusals (nolock)
 where Flag&4=4
   and Flag&8=0 -- Удален

go
grant select on vOrderRefusals to public
go