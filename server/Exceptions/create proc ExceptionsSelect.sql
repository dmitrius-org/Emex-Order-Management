drop proc if exists ExceptionsSelect
/*
  ExceptionsSelect -
*/
go
create proc ExceptionsSelect
              @Type as ID readonly
             ,@DetailNum  varchar(20)
as
 declare @NLA bit=0
 declare @DetailNameF bit=0
 declare @WeightKGF bit=0
 declare @VolumeKGf bit=0
 declare @Restrictions bit=0
 declare @Fragile bit=0

 declare @Parts ID

 select @DetailNameF= 1  from @Type where id =2
 select @WeightKGF= 1    from @Type where id =1
 select @VolumeKGf= 1    from @Type where id =1
 select @Restrictions= 1 from @Type where id =3
 select @Fragile = 1     from @Type where id =4
 select @NLA = 1         from @Type where id =5

 if @DetailNameF = 0 and @WeightKGF = 0 and @VolumeKGf = 0 and @Restrictions = 0 and @Fragile = 0 and @NLA = 0 and isnull(@DetailNum, '') = ''
   goto exit_
print sysdatetime()
 insert @Parts 
       (ID)
 Select max(p.PriceID)
   from tPrice p  with (nolock)
  where p.DetailNum = isnull(nullif(@DetailNum, ''), p.DetailNum )
  
    and (( @DetailNameF=1  and isnull(p.DetailNameF, '') <> '' )
       or ( @WeightKGF=1    and isnull(p.WeightKGF	,0) <> 0  )
       or ( @VolumeKGf =1   and isnull(p.VolumeKGf	,0) <> 0  )
       or ( @Restrictions=1 and isnull(p.Restrictions,'') <> '' )
       or ( @Fragile=1      and isnull(p.Fragile,0) <> 0        )
       or ( @NLA = 1        and isnull(p.NLA,0) <> 0            ))

  --*/
  group by p.DetailNum, p.MakeLogo
--       Select 1 as ID, 'Детали у которых изменен вес, либо объем' as Name
--union select 2, 'Детали у которых изменено наименование'
--union select 3, 'Детали с пометкой NoAir'  
--union select 4, 'Детали с пометкой Fragile'
--union select 5, 'Детали с пометкой NLA'

print sysdatetime()

Exit_:

 Select  t.Brand
        ,t.DetailNum
        ,t.DetailName
        ,convert(varchar(60), t.DetailNameF) as DetailNameF
        ,t.WeightKGF
        ,t.VolumeKGf
        ,convert(varchar(60), t.Restrictions) as Restrictions
        ,t.Fragile
        ,t.NLA
        ,t.PriceID
    from @Parts p 
   inner join tPrice t with (nolock index=ao1)
           on t.PriceID = p.ID

go
grant exec on ExceptionsSelect to public
go
exec setOV 'ExceptionsSelect', 'P', '20250307', '0'
go
 