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
       ,ak.Flag
   from tApiKeys ak with (nolock)
            
go
grant all on vApiKeys to public
go
exec setOV 'vApiKeys', 'V', '20241112', '0'
go

select * from vApiKeys