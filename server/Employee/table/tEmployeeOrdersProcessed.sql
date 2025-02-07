if OBJECT_ID('tEmployeeOrdersProcessed') is null
/* **********************************************************
tOrdersProcessed - Заказы
********************************************************** */
begin
    create table tEmployeeOrdersProcessed
    (
     OrderID       numeric(18,0) 
    ,EmployeeID    numeric(18,0) 
    ,Flag          int
    ,InDateIime    datetime      
    );

    create unique index ao1 on tEmployeeOrdersProcessed(OrderID);

    create index ao2 on tEmployeeOrdersProcessed(EmployeeID);
end
go
grant select on tEmployeeOrdersProcessed to public
go
exec setOV 'tEmployeeOrdersProcessed', 'U', '20250207', '0'
go