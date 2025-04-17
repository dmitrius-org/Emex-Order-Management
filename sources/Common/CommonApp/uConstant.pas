unit uConstant;
//                     Пользовательские типы и константы
interface

uses System.SysUtils;


const  NullDate: TDateTime = 0; // 30.12.1899
       //
       AppManager: string = 'Manager';
       AppCustomer: string = 'Customer'; // жестко прописан в TLoggerF.Query, vClients
       AppScheduler: string = 'Scheduler';

Type
{
tOrders - заказы
flag  int   0-
            1 - Превышение цены
            2 - Нет цены
            4 - Отказан
            8 - Запись добавлена в результате дробления заказа
           16 - Онлайн заказ
           32 - Сообщение для клиента
           64 - Запрошен отказ
          128 - Отказ от детали
          256 - Был изменен Прайс-лист
}

TOrderFlag = (
   /// <summary>
   /// ORDER_ONLINE - Онлайн заказ
   /// </summary>
   ORDER_ONLINE                     = 16,
   ORDER_CHANGE_PRICELOGO           = 256
);




implementation


end.
