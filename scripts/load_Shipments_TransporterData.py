from asyncio.windows_events import NULL
import os, fnmatch
import pandas as pd
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from dataTest import Sql

'''
Загрузка детализации отгрузок

"qbls162k", "249268", "23.05", "23.0", "23.7", "25.26", ""

Номер груза
Номер инвойса
-В одной отгрузке может быть больше 1 инвойса.
-В такой ситуации нам придется разделить вес и стоимость доставки между ними. Инструкция по ссылке на листе “Калькулятор”:
- https://docs.google.com/spreadsheets/d/1sEzljeN4aMwcOkaEC-Kly_TBxMUMY6A2Ld32Zrp7ckQ/edit?usp=sharing
Физический вес по данным поставщика (условно F1)
Физический вес по данным перевозчика (условно F2)
Объемный вес по данным поставщика (условно V1)
Объемный вес по данным перевозчика (условно V2)
Стоимость груза (условно S1)
-Она может быть указана не всегда. Если указана, записываем, если не указана, не записываем.
-Когда стоимость груза укажут, в папке Shipping Data заново появится этот файл уже со стоимостью доставки,
- мы стандартно грузим его и просто дописываем стоимость доставки нам в систему
'''


def load_shipments_detail(sql: Sql, data, batchsize=500):
    logger.info('Начало загрузки данных в базу SQL')
    cursor = sql.cnxn.cursor()
    cursor.fast_executemany = True

    query = f"""
        set nocount on  ; 
        delete from pShipmentsTransporterData where spid = @@spid
    """
    cursor.execute(query)

    query = f"""
        INSERT INTO pShipmentsTransporterData 
              ([Spid], [TransporterNumber], [Invoice], [SupplierWeightKG], [TransporterWeightKG], [SupplierVolumeKG], [TransporterVolumeKG], [TransporterAmount]) 
        VALUES (@@Spid, ?, ?, ?, ?, ?, ?, ?)         
    """    
    for i in range(0, len(data), batchsize):
        batch = data[i: i+batchsize].values.tolist()        
        logger.info(batch)        
        cursor.executemany(query, batch)

    cursor.execute("exec ShipmentsTransporterFill @IsSave = 1")
    logger.info('Успешно загрузили данные в базу SQL')
    return True   


# 
config = configparser.ConfigParser()  # создаём объекта парсера
config.read("settingstest.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'load_Shipments_Transporter_Data.log', level='DEBUG', rotation="1 MB")
logger.info('Начало импорта')

sql = Sql()
if (sql.connection):
    logger.info('Успешно подключились к базе данных')
else:
    exit();   


# Статусы доставок транспортной компании
directory=r'C:\\Users\\Администратор\\Мой диск\\Booster\\Shipping\\ADQ\\Shipping Data'
# directory = config["LoadPath"]["ShipmentsFile"] 

file_list = os.listdir(directory)  # определить список всех файлов
# Обрабатываем каждый файл в директории
for file in file_list:
    if fnmatch.fnmatch(file, "qbow198c.txt"):  # Проверяем, соответствует ли файл шаблону qbow197c qbow200c
        logger.info(f'Начало обработки файла {file}')
        processed = False
        try:
            dtype_dict = {i: str for i in range(7)}  # Define data types for columns 
            # dtype_dict = {
            #                 0: str, # Example: Column 0 as string
            #                 1: str, # Example: Column 1 as string
            #                 2: str, # Example: Column 2 as string
            #                 3: str, # Example: Column 3 as string
            #                 4: str, # Example: Column 4 as string
            #                 5: str, # Example: Column 5 as string
            #                 6: str  # Example: Column 6 as string
            #             }
            # Считываем CSV-файл в DataFrame с учетом кавычек
            df = pd.read_csv(os.path.join(directory, file), 
                             delimiter=",", 
                             header=None, 
                             quotechar='"', 
                             skipinitialspace=True, 
                             usecols=[0,1,2,3,4,5,6],
                             dtype=dtype_dict
                             )

            # Заполняем NaN значения пустыми строками
            df = df.fillna("")
            # Удаляем кавычки и лишние пробелы
            df[1] = df[1].astype(str).str.replace('"', '').str.strip()
            # Разделяем номера инвойсов по запятым и создаем отдельные строки
            df[1] = df[1].str.split(',')
            df = df.explode(1)
            # Удаляем лишние пробелы после разделения
            df[1] = df[1].str.strip()
           
            df = df.replace('', None)
            
            # for col in [2, 3, 4, 5, 6]:
            for col in range(2, 6):
                df[col] = df[col].str.replace(',', '').astype(float)
                
            # Логируем обработанные данные
            # logger.info(f'Данные после разделения:\n{df}')
            
            load_shipments_detail(sql, data=df, batchsize=500)
            logger.info(f'Завершение обработки файла {file}')

            processed = True
        except BaseException as err:
            processed = False
            logger.error(err)
Sql.close
logger.info('Импорт завершен')