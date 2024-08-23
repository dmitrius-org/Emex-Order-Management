 -- Данные по инвойсам
 delete from tShipments
 delete pShipments from pShipments (rowlock) where Spid = @@Spid 


 insert pShipments
       (Spid, Invoice/*, ShipmentsDate*/)           
 select distinct @@Spid, Invoice--, GetDate()
   from tOrders 
  where  Invoice is not null

 exec ShipmentsInsert

  select * from tShipments