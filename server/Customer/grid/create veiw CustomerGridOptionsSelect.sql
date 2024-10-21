if OBJECT_ID('CustomerGridOptionsSelect') is not null
    drop view CustomerGridOptionsSelect
go
/* 						
create view CustomerGridOptionsSelect - 
 */
create view CustomerGridOptionsSelect
as

  select 
          ClientID	
         ,Grid	
         ,[Column]	
         ,Position	
         ,Width	
         ,Visible
    from tCustomerGridOptions with (nolock index=ao1)

go
grant all on CustomerGridOptionsSelect to public
go
exec setOV 'CustomerGridOptionsSelect', 'P', '20240101', '0'
go
