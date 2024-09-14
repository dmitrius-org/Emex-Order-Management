from asyncio.windows_events import NULL
import os, fnmatch
import pandas as pd
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from data import Sql

'''
Описание файла Shipments.txt

25.07.2024 21:51:39;QAKV108C;Прошел границу РФ;3
25.07.2024 21:51:39;QAKV109C;Поступил на Склад в РФ;5
'''

config = configparser.ConfigParser()  # создаём объекта парсера
config.read("settings.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'load_shipments.log', level='DEBUG', rotation="1 MB")
logger.info('Начало импорта')

sql = Sql()
if (sql.connection):
    logger.info('Успешно подключились к базе данных')
else:
    exit();   


# Статусы доставок транспортной компании
directory=r'C:\\Users\\Администратор\\Мой диск\\Booster\\Shipping\ADQ\\Log\\'
# directory = config["LoadPath"]["ShipmentsFile"] 

file_list = os.listdir(directory)  # определить список всех файлов
for file in file_list:    
    if fnmatch.fnmatch(file, "Shipments.txt"):       
        logger.info('Начало обработки файла {0}'.format(file));
        processed = False
        try:
            
            df = pd.read_csv(directory+file, delimiter=";", encoding='oem', header=None, usecols=[0,1,2,3], keep_default_na=False);
            df = df.fillna("")
            
            logger.info('Загрузили файл {0} в объект DataFrame'.format(file));         
            sql.load_shipments(data=df, table='#shipments', batchsize=500)
            
            logger.info('Завершение обработки файла {0}'.format(file))
            processed = True; 
        except BaseException as err:
            processed = False
            logger.error(err)
                  
#sql.drop(table_names)
# print (sql.query);
logger.info('Завершили импорт')

