if OBJECT_ID('PartDescriptionUpdate') is not null
  drop proc PartDescriptionUpdate
go
/* **********************************************************
  PartDescriptionUpdate - Русские наименования
********************************************************** */
create proc PartDescriptionUpdate
as

insert tPartDescription (
       Make
      ,Number
      ,Name_RUS
      ,Name_ENG
      ) 
select p.MAKE
      ,p.NUMBER
      ,p.NAME_RUS
      ,p.NAME_ENG
  from #Description p with (nolock index=ao1)
 where not exists (select 1
                     from tPartDescription t with (nolock index=ao2)
                    where t.Make  = p.MAKE
                      and t.Number= p.NUMBER
                  )

update t
   set t.Name_RUS    = p.NAME_RUS
      ,t.Name_ENG    = p.NAME_ENG
      ,t.updDatetime  = GetDate()
  from #Description p with (nolock index=ao1)
 inner join tPartDescription t with (updlock index=ao2)
         on t.Make  = p.MAKE
        and t.Number= p.NUMBER

go
grant execute on PartDescriptionUpdate to public
go
exec setOV 'PartDescriptionUpdate', 'P', '20240619', '1'
go