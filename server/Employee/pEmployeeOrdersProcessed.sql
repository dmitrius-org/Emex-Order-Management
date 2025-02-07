drop table if exists pEmployeeOrdersProcessed
/* **********************************************************
pEmployeeOrdersProcessed - 
********************************************************** */
begin
    create table pEmployeeOrdersProcessed
    (
     Spid          int
    ,EmployeeID    numeric(18,0) 
    ,Processed     int  -- Количество обработанных строк
    ,Incorrect     int  -- Количество неправильно обработанных строк
    ,Confirmed     int  -- Количество обработанных строк
    ,AmountSumAll  float -- Сумма вознаграждения за всю историю 
    ,AmountSum     float -- Сумма вознаграждения с момента последнего сброса 
    ,ProcessedSum  float -- Сумма верно обработанных строк 
    ,IncorrectSum  float -- Сумма неверно обработанных строк
    );

    create unique index ao1 on pEmployeeOrdersProcessed(Spid, EmployeeID);
end
go
grant select on pEmployeeOrdersProcessed to public
go
exec setOV 'pEmployeeOrdersProcessed', 'U', '20250207', '0'
go


 