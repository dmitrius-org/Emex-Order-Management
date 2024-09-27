 -- Данные по инвойсам
 --delete from tShipments -- where Invoice = '241017'
 delete pShipments from pShipments (rowlock) where Spid = @@Spid 


 insert pShipments
       (Spid, Invoice/*, ShipmentsDate*/)      
       
    --   select @@spid, 241629
       
 select distinct @@Spid, Invoice--, GetDate()
   from tOrders 
  where  Invoice is not null
--*/
 exec ShipmentsRefresh

 select * from pShipments where spid = @@spid