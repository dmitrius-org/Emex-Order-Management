
--alter table tBasket

--add [ValidFrom]  DATETIME2 GENERATED ALWAYS AS ROW START /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidFrom DEFAULT SYSUTCDATETIME() 
--   ,[ValidTo]    DATETIME2 GENERATED ALWAYS AS ROW END   /*HIDDEN*/ CONSTRAINT DF_tBasket_ValidTo DEFAULT CONVERT(DATETIME2, '9999-12-31 23:59:59.9999999')
   
--    ,PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)

--    ,CONSTRAINT PK_tBasket_BasketID PRIMARY KEY CLUSTERED (BasketID)
--go
--ALTER TABLE tBasket
--SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = History.tBasket));
--go



 update tNodes 
 set flag = Flag|4
 where Type=0
 and nodeid in (
 1	--New	Новый
,2	--InChecked	Проверено
,3	--InBasket	В корзине
,4	--InWork	В работе
,5	--Purchased	Закуплено
,6	--ReceivedOnStock	Получено на склад в ОАЭ
,7	--ReadyToSend	Готово к отправке из ОАЭ
,8	--Send	Передано для доставки из ОАЭ в РФ
--,9	--NotAvailable	Нет в наличии
--,10	--LessMinLot	Меньше минимальной партии
--,11	--PriceChange	Изменение цены
--,12	--InCancel	Отказано
,22	--Preparation	Предварительный
--,24	--Received	Готовим к выдаче в РФ
--,26	--IssuedClient	Выдано клиенту
,32	--InShipment	На пути в РФ
,37	--InShipmentWait	Ожидает отправки из ОАЭ в РФ
,38	--InShipmentBorderPassed	Прошел границу РФ
,39	--InShipmentDelivered	Прибыл в РФ
,36	--OnHold	Задерживается
)


