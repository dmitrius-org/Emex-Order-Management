if OBJECT_ID('GridOptionsSelect') is not null
    drop view GridOptionsSelect
go
/* 						
create view GridOptionsSelect - 
 */
create view GridOptionsSelect
as

  select 
          UserID	
         ,Grid	
         ,[Column]	
         ,Position	
         ,Width	
         ,Visible
    from tGridOptions with (nolock index=ao1)

go
grant all on GridOptionsSelect to public
go
exec setOV 'GridOptionsSelect', 'P', '20240101', '0'
go
select * from GridOptionsSelect