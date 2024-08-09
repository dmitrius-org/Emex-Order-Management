from asyncio.windows_events import NULL
import os, fnmatch
import pandas as pd
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from data import Sql

'''
Описание файла Makes.txt (нет строки с названием столбцов, сразу идут данные)

1 столбец: Бренд в зашифрованном виде
2 столбец: Бренд в расшифрованном виде
'''

config = configparser.ConfigParser()  # создаём объекта парсера
config.read("settings.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'makes_import.log', level='DEBUG', rotation="1 MB")
logger.info('Начало импорта')

sql = Sql()
if (sql.connection):
    logger.info('Успешно подключились к базе данных')
else:
    exit();   

directory = config["LoadPath"]["MakesFile"] 

file_list = os.listdir(directory)  # определить список всех файлов
for file in file_list:    
    if fnmatch.fnmatch(file, "*.txt"):       
        logger.info('Начало обработки файла {0}'.format(file));
        processed = False
        try:
            
            df = pd.read_csv(directory+file, delimiter=",", encoding='ansi', header=None, usecols=[0,1,2], keep_default_na=False);
            df = df.fillna("")
            
            logger.info('Загрузили файл {0} в объект DataFrame'.format(file));         
            sql.load_makes(data=df, table='#makes', batchsize=500)
            
            logger.info('Завершение обработки файла {0}'.format(file))
            processed = True; 
        except BaseException as err:
            processed = False
            logger.error(err)
                  
#sql.drop(table_names)
# print (sql.query);
logger.info('Завершили импорт')

