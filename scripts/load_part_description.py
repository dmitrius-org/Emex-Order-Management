from asyncio.windows_events import NULL
import os, fnmatch
import pandas as pd
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from data import Sql

'''
Описание файла:

MAKE	NUMBER	NAME_RUS	NAME_ENG	0
!7	MX01094107	ФИЛЬТР ВОЗДУШНЫЙ	ELEMENT.AIR CLEANER	1
!7	MX01094108	ФИЛЬТР ВОЗДУШНЫЙ	ELEMENT.AIR CLEANER	1
'''

config = configparser.ConfigParser()  # создаём объекта парсера
config.read("settings.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'load_part_description.log', level='DEBUG', rotation="1 MB")
logger.info('Начало импорта')

sql = Sql()
if (sql.connection):
    logger.info('Успешно подключились к базе данных')
else:
    exit();   

directory = config["LoadPath"]["DescriptionFile"] 

file_list = os.listdir(directory)  # определить список всех файлов
for file in file_list:    
    if fnmatch.fnmatch(file, "*.txt"):       
        logger.info('Начало обработки файла {0}'.format(file));
        processed = False
        try:
            
            df = pd.read_csv(directory+file, delimiter="\t", encoding='ansi', header=None, usecols=[0,1,2,3], keep_default_na=False);
            df = df.fillna("")
            
            logger.info('Загрузили файл {0} в объект DataFrame'.format(file));         
            sql.load_description(data=df, table='#Description', batchsize=500)
            
            logger.info('Завершение обработки файла {0}'.format(file))
            processed = True; 
        except BaseException as err:
            processed = False
            logger.error(err)
                  
#sql.drop(table_names)
# print (sql.query);
logger.info('Завершили импорт')

