alter table tBasket add OurDelivery             int            -- наш срок поставки, показываем клиенту

alter table tSupplierDeliveryProfiles add Delivery           int 



delete g 
 from tMenu m
 inner join tGrant g 
         on g.MenuID = m.MenuID
 where m.Name in (

 'TOrdersT.actGridSettingLoad'
,'TOrdersT.actGridSettingSave'
,'TOrdersT.actFormRefusalsOpen'
)


delete m 
 from tMenu m
 where m.Name in (

 'TOrdersT.actGridSettingLoad'
,'TOrdersT.actGridSettingSave'
,'TOrdersT.actFormRefusalsOpen'
)