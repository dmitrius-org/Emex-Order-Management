if OBJECT_ID('OrderF_PartDescription') is not null
    drop proc OrderF_PartDescription
/*
  OrderF_PartDescription - 
*/
go
create proc OrderF_PartDescription
             @Number nvarchar(256)
as
  declare @r int = 0

    select distinct top 50
           Name_RUS
      from tPartDescription (nolock)
     where Name_RUS LIKE '' + @Number + '%'

 exit_:
 return @r
go
grant exec on OrderF_PartDescription to public
go
exec setOV 'OrderF_PartDescription', 'P', '20241212', '1'
go



