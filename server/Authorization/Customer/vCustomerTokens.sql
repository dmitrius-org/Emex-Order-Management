drop view if exists vCustomerTokens
go
/* **********************************************************						
vCustomerTokens - 
********************************************************** */
create view vCustomerTokens
as
select t.*
      ,c.Brief ClientBrief
      ,c.Email ClientEmail
  from system.tCustomerTokens t (nolock)
  left join tClients c with (nolock index=PK_tClients_ClientID) 
         on c.ClientID = t.ClientID
go
grant select on vCustomerTokens to public
go
exec setOV 'vCustomerTokens', 'V', '20240915', '0'
go

select * from vCustomerTokens

/*
update  system.vCustomerTokens
set --Expiration = '2024-12-04 14:33:32.4650000'
   --,Status = 0
   Token = Token+ '1'

*/