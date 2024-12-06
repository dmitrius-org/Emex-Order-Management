drop view if exists vCustomerInfoByToken
go
/* **********************************************************						
vCustomerInfoByToken - 
********************************************************** */
create view vCustomerInfoByToken
as
select c.ClientID
      ,c.Brief ClientBrief
      ,c.Email ClientEmail
      ,t.Token
  from system.tCustomerTokens t (nolock)
  left join tClients c with (nolock index=PK_tClients_ClientID) 
         on c.ClientID = t.ClientID
go
grant select on vCustomerInfoByToken to public
go
exec setOV 'vCustomerInfoByToken', 'V', '20240915', '0'
go

select * from vCustomerInfoByToken

/*
update  system.tTokens
set Expiration = '2024-12-04 14:33:32.4650000'
   ,Status = 0

*/