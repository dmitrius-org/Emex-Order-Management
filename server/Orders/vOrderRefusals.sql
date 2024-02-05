if OBJECT_ID('vOrderRefusals') is not null
    drop view vOrderRefusals
go
/* **********************************************************						
vOrderRefusals - ������
********************************************************** */

create view vOrderRefusals

as

--SET DATEFIRST 1;

select OrderRefusalsID
     -- ,Folder
      ,FileName
      ,Flag
      ,InDateTime
  from tOrderRefusals (nolock)
 where Flag&4=4
   and Flag&8=0 -- ������



		 

go
grant select on vOrderRefusals to public
go

select * from vOrderRefusals 
