from asyncio.windows_events import NULL
import os, fnmatch
import pandas as pd
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from data import Sql
import time
import xlwings as xw
import numpy as np 
import excel_utils as eu
from pathlib import Path
import shutil
from _utils import *


'''
                     Загрузка заказов из EXCEL в базу данных
'''

config = configparser.ConfigParser()  # создаём объект парсера
config.read("settings.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'load_orders.log', level='DEBUG', rotation="1 MB")
logger.info('Начало импорта')

now = datetime.datetime.now()
if (now > datetime.datetime(now.year, now.month, now.day, 20, 55, 00, 000) ):
    exit

def load_orders(conn, data, batchsize=500):
    '''
    load_orders - Загрузка данных о заказе в базу данных
    '''
    logger.info('[load_orders] Начало загрузки данных в базу SQL')      
    tic2 = time.perf_counter()
    
    cursor = conn.cnxn.cursor()      # создаем курсор
    cursor.fast_executemany = True   # активируем быстрое выполнение
    try:
        data = data.replace(to_replace=np.nan, value=None, inplace=False)

        query = """ delete from pOrders --where spid = @@spid
                """    
        cursor.execute(query)

        query = """ INSERT INTO pOrders 
                           ([clientID], [manufacturer], [detailNumber], [quantity], [detailID], [detailName], [price], [amount], [orderNum], [orderDate], [priceNum], [FileDate]) 
                    VALUES (?,?,?,?,?,?,?,?,?,?,?,?) 
                """
        # вставляем данные в целевую таблицу
        for i in range(0, len(data), batchsize):
            if i+batchsize > len(data):
                batch = data[i: len(data)].values.tolist()
            else:
                batch = data[i: i+batchsize].values.tolist()
                
            # запускаем вставку батча        
            cursor.executemany(query, batch)
            
        logger.info(f'Выполнили загрузку данных во временную таблицу. Время выполнения {time.perf_counter() - tic2:0.4f}')
        tic3 = time.perf_counter()
        cursor.execute("exec LoadOrders")
        logger.info(f'Выполнили загрузку в постоянную таблицу. Время выполнения  {time.perf_counter() - tic3:0.4f}')
        return True
    except BaseException as err:
        logger.error(f"[load_orders] Ошибка загрузки в БД. Время выполнения  {time.perf_counter() - tic2:0.4f}")
        logger.error(err)
        return False


def prepare_orders_data(prow, filexls):
    '''
    prepare_orders_data - подготовка данных для загрузки
                          выполняем чтение данных из файла excel в объект dataFrame       
    '''
    tic2 = time.perf_counter()  
    logger.info(f'[prepare_orders_data] Начало подготовки данных. Файл: {filexls}')

    # параметры начитки данных
    firstline    = prow.Firstline
    manufacturer = prow.Manufacturer
    detailNumber = prow.DetailNumber
    quantity     = prow.Quantity
    detailID     = prow.DetailID
    detailName   = prow.DetailName
    price        = prow.Price
    amount       = prow.Amount
    orderNum     = prow.OrderNum
    orderDate    = prow.OrderDate
    priceNum     = prow.PriceNum
    clientID     = prow.ClientID
    # Commission= prow.Commission

    order_df = pd.DataFrame(columns = ['clientID', 'manufacturer', 'detailNumber', 'quantity', 'detailID', 'detailName', 'price', 'amount', 'orderNum', 'orderDate', 'priceNum', 'FileDate'],
                            # dtype={"clientID": str, "manufacturer": str, "detailNumber": str, "quantity": str, "detailID": str, 
                            #        "detailName": str, "price": str, "amount": str, "orderNum": str,"orderDate": str, "priceNum": str}, 
                            # na_filter=False, 
                            )
 
    try:
    # if 1==1:
        wb = None
        file_path = Path(filexls)
        file_ext = file_path.suffix.lower()[1:] # расширение файла
        
        if file_ext == 'xlsx':
            engine='openpyxl'
        elif file_ext == 'xls':    
           engine=None
            
        df = pd.read_excel(filexls, 
                           engine = engine,
                           header=None, 
                        #    dtype={"a": str, "b": str, "c": str, 'd':str, "e": str, "f": str, "g": str, "h": str, "i": str, "j": str, "k": str,"l": str,"m": str}, 
                           dtype={0: str, 1: str, 2: str, 3:str, 4: str, 5: str, 6: str, 7: str, 8: str, 9: str, 10: str, 11: str, 12: str}, 
                           na_filter=False, 
                            # na_values=['null'],
                        #    converters={3:str, 4:str},
                           skiprows = firstline-1,                     
        )   

        rowlist = [clientID] * len(df.axes[0])    
        order_df['clientID'] = rowlist        
   
        if manufacturer:
            order_df['manufacturer'] = df[manufacturer-1]
        if detailNumber:    
            order_df['detailNumber'] = df[detailNumber-1]
        if quantity:
            order_df['quantity'] = df[quantity-1]
        if detailID:    
            order_df['detailID'] = df[detailID-1]
        # else:
        #     order_df['detailID'] = ""    
        if detailName:
            order_df['detailName'] = df[detailName-1]
        if price:
            order_df['price'] = df[price-1]
        if amount:
            order_df['amount'] = df[amount-1]

        df = df[0:0] 
        
        # 
        # читаем excel-файл
        # app = xw.App(visible=False) os.path.abspath
        logger.info(f"[prepare_orders_data]. Файл:{(filexls)}.")
        wb = xw.Book((filexls))
        xw.App.visible = False
        sheet = wb.sheets[0]
        
        if orderNum:
            order_df['orderNum']=eu.GetExcelVal(df, sheet, orderNum) 
        if orderDate:
            order_df['orderDate']=eu.GetExcelVal(df, sheet, orderDate)      
        if priceNum:
            order_df['priceNum']=eu.GetExcelVal(df, sheet, priceNum)

        # дата создания файла
        order_df['FileDate']=creation_date(filexls)
            
        wb.close() 
        
        # отсекаем данные где нет данных по: detailNumber, quantity и price
        order_df = order_df[(order_df['detailNumber']!="") & (order_df['quantity']!="") & (order_df['price']!="")]      
         
        logger.info(f"[prepare_orders_data] Конец подготовки данных. Файл:{filexls}. Вычисление заняло {time.perf_counter() - tic2:0.4f}")
        # print(order_df) 
        return order_df 

    except BaseException as err:
        if wb:
            wb.close() 
        # wb.app.quit()    
        # if app:
        #     app.quit()    
        logger.error(f"[prepare_orders_data] Ошибка подготовки данных. Файл:{filexls}. Вычисление заняло {time.perf_counter() - tic2:0.4f}")
        logger.error(err)


# ---------------------------------------------------
# подготовка данных для загрузки с использованием pandas DataFrame
conn = Sql()
if conn.connection:
    logger.info('Успешно подключились к базе данных')
else:
    exit()

crsr = conn.cnxn.cursor()        
    
#  Получение сведений по форматам импорта
sql = """
        SELECT c.[ClientID] 
              ,o.Folder
              ,o.Firstline
              ,o.Manufacturer
              ,o.DetailNumber     --nvarchar(30)   -- 4 Номер детали
              ,o.[Quantity]       --float          -- 8 Количество
              ,o.[DetailID]       --nvarchar(30)   -- 5 ID
              ,o.[DetailName]     --nvarchar(255)  -- 6 Название
              ,o.[Price]          --money          --12 Цена продажи	
              ,o.[Amount]         --money          --13 Сумма продажи
              ,o.OrderNum     
              ,o.OrderDate    
              ,o.PriceNum     
              --,o.Commission 
              ,o.IsActive  
              ,c.Brief
          FROM [tClients] c (nolock)
         inner join [tOrderFileFormat] o (nolock)
                 on o.ClientID = c.ClientID

         where isnull(o.folder, '') <> ''
           ---and c.Brief = 'EmEx'--EmEx ADEO EEZap
      """
                     
prows = crsr.execute(sql).fetchall()    
if not (prows):
    logger.error('Нет активных профилей для загрузки заказов')
    exit()  

tic = time.perf_counter()
for prow in prows:   
    folder = prow.Folder
    isActive = prow.IsActive

    if not isActive:
        logger.info(f'Загрузка заказов по клиенту {prow.Brief} отключена! ')
        continue     

    if folder[-1] != '\\':
        folder += "\\"

    if not os.path.isdir(folder):
        logger.info(f'Не удается найти указанный путь: {folder}')
        continue  
    
    logger.info(f'Обработка заказов в папке: {folder}')    

    file_list = os.listdir(folder)  # определить список всех файлов
    for file in file_list:  
        retval = False
        if fnmatch.fnmatch(file, '*.xls'): #  EMIR FAST                       
            r = prepare_orders_data(prow, folder + file)
            if not r.empty:
                retval = load_orders(conn, r)
                
        # переносим файл в архив
        if retval:
            dst = folder + 'Archive\\'
            if not os.path.isdir(dst):
                os.mkdir(dst)
            shutil.move(folder + file, dst + file)

logger.info(f'Завершили импорт. Вычисление заняло {time.perf_counter()-tic:0.4f}')
