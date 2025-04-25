if OBJECT_ID('vApiKeys') is not null
    drop view vApiKeys
go
/* **********************************************************						
vApiKeys - 
********************************************************** */

create view vApiKeys
as

 select ak.ApiKeysID
       ,ak.ClientID
       ,ak.ApiKey
       ,ak.Name
       ,ak.inDatetime
       ,ak.EndDatetime
       ,dateadd(hh, 3, ak.ValidFrom) updDatetime
       ,ak.Flag
   from tApiKeys ak with (nolock)
            
go
grant all on vApiKeys to public
go
exec setOV 'vApiKeys', 'V', '20250423', '1'
go

select * from vApiKeys
select * from tApiKeys