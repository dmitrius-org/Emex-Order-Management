alter table tProfilesCustomer
add SuppliersID	         numeric(18, 0) -- ���������

alter table tSuppliers
add GroupName	         varchar(64) -- ���������
update tSuppliers
set GroupName = 'Emex'



-- update tmenu
--   set Caption = '���������� �������: 1�'
--   where name = 'TShipmentsT.actSet1C'

alter table tSuppliers
add ApiAddress        varchar(256 ) -- 

update tSuppliers
set ApiAddress = 'http://soap.emexdwc.ae:3000/service.asmx'

delete
               from GridOptionsSelect
              where [Column]='Rest'



update tProfilesCustomer
   set SuppliersID = c.SuppliersID
  from tProfilesCustomer p
 inner join tClients c
         on c.ClientID = p.ClientID


--select SuppliersID, * from tProfilesCustomer

--update tClients
--set SuppliersID = cc.SuppliersID
--from tClients c
--inner join testdb.dbo.tClients cc
--on cc.ClientID = c.ClientID

-- alter table tClients
-- drop column SuppliersID     

