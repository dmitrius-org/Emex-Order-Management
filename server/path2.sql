alter table tClients drop column Discount
alter table tClients drop column Commission
alter table tClients drop column Margin
alter table tClients drop column Reliability



alter table  tProfilesCustomer drop column  Discount
alter table  tProfilesCustomer drop column  Commission
alter table  tProfilesCustomer drop column  ExtraKurs
alter table  tProfilesCustomer drop column  isMyDelivery
alter table  tProfilesCustomer drop column  isIgnore



alter table tSuppliers add Discount          money    
alter table tSuppliers add Commission        money    
alter table tSuppliers add ExtraKurs         money    


alter table tSupplierDeliveryProfiles add isMyDelivery       bit 
alter table tSupplierDeliveryProfiles add isIgnore       bit 


alter table tSupplierDeliveryProfiles alter column name nVarchar(60)


alter table tOrders  add Kurs                            money
alter table hOrders  add Kurs                            money