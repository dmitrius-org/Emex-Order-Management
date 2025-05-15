alter table tOrders
add  LastDateShipment                datetime       -- Крайняя  дата отгрузки со склада в ОАЭ
    ,LastTermShipment                int            -- Дней до крайней даты отгрузки со склада в ОАЭ


alter table history.tOrders
add   LastDateShipment                datetime       -- Крайняя  дата отгрузки со склада в ОАЭ
     ,LastTermShipment                int            -- Дней до крайней даты отгрузки со склада в ОАЭ