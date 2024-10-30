
--alter table tBasket

--add [ValidFrom]  DATETIME2 GENERATED ALWAYS AS ROW START /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidFrom DEFAULT SYSUTCDATETIME() 
--   ,[ValidTo]    DATETIME2 GENERATED ALWAYS AS ROW END   /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999')
   
--    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

--    ,CONSTRAINT PK_tBasket_BasketID PRIMARY KEY CLUSTERED (BasketID)
--go
--ALTER TABLE tBasket
--SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.tBasket));
--go


Update o
   set o.DeliveryRestTermSupplier =       case 
         when datediff(dd, cast(getdate() as date), o.[DeliveryPlanDateSupplier]) > 0
         then datediff(dd, cast(getdate() as date), o.[DeliveryPlanDateSupplier])
         else 0
       end 
  from tOrders o (nolock)
 where isnull(o.isCancel, 0) = 0



Update o
   set o.DeliveryRestTermSupplier = o.DeliveryTerm - DATEDIFF(dd, o.OrderDate, getdate())  -- Остаток срока до поставки 
  from tOrders o (nolock)
 inner join tNodes n (nolock)
         on n.NodeID = o.StatusID
        and n.Flag&8>0 


tClients
tSuppliers

select *
from tNodes n (nolock)
where n.Flag&8>0 
  

exec OrdersSupplierDeliveryTermRecalc