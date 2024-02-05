delete from tShipments 
delete from pShipments 

insert pShipments
      (Spid, 
       Invoice,
       ShipmentsDate)
Select distinct   @@Spid, Invoice, getDate()
  from tOrders 
where Invoice is not null




exec ShipmentsInsert


Select *
from tShipments 




--Select distinct top 5 *
--from tOrders 
--where Invoice is not null