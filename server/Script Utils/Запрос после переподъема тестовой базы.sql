


Update tSuppliers 
   set EmexUsername = EmexUsername + '_'
      ,EmexPassword = EmexPassword + '-'
where SuppliersID <> 8

select * 
  from tSuppliers



Update tClients 
   set SuppliersID = 8
where ClientID <> 15


select * 
  from tClients 



--select * from tUsersAuthorization