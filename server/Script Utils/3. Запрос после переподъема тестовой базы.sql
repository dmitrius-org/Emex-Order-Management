use testdb
go


Update tSuppliers 
   set EmexUsername = EmexUsername + '_'
      ,EmexPassword = EmexPassword + '-'
where SuppliersID <> 8

select * 
  from tSuppliers



--Update tClients 
--   set SuppliersID = 8
--where ClientID <> 15


--select * 
--  from tClients 


update tTask
   set IsActive = 0

update tTaskProperties
   set IsActive = 0
--update tClients
--set Password='0x0eb2316c9b184a5e4f7476ab43e18ff33a8af6e898f394216c23e38a994e4724f40544fd8af03c85049362f9dc99913f878ae38c441cec5b680f115ab559b250'
--where ClientID = 57


--select * from tUsersAuthorization


Update tSettings
set Val = 'http://soaptest.emexdwc.ae/service.asmx'
where Brief = 'EmexServiceSoapUrl'

