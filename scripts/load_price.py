from asyncio.windows_events import NULL
import os, fnmatch
import pandas as pd
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from data import Sql
import time

''' 
Описание файла 48H.txt (первая строка - названия столбцов)
1 столбец: MakeLogo - Зашифрованное название бренда
2 столбец: DetailNum - Номер детали
3 столбец: DetailPrice - Цена
4 столбец: DetailName - Название
5 столбец: PriceLogo - Название прайса (игнорируем)
6 столбец: Quantity - Количество
7 столбец: PackQuantity - Количество в упаковке
8 столбец: Reliability - Вероятность поставки
9 столбец: WeightKG - Вес физический
10 столбец: VolumeKG - Вес объемный
11 столбец: Restr - Неизвестно (игнорируем)
12-38 столбцы включительно - Цена с доставкой до разных мест
'''

config = configparser.ConfigParser()  # создаём объект парсера
config.read("settings.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'import_price.log', level='DEBUG', rotation="1 MB")
logger.info('Начало импорта')

directory = config["LoadPath"]["PriceFile"]

file_list = os.listdir(directory)  # определить список всех файлов
if file_list:
    sql = Sql()
    if sql.connection:
        logger.info('Успешно подключились к базе данных')
    else:
        exit()

for file in file_list:    
    if fnmatch.fnmatch(file, "24h.txt"): #  EMIR FAST 
        tic = time.perf_counter()
        logger.info('Начало обработки файла {0}'.format(file))
        processed = False

        try:
            
            df = pd.read_csv(directory+file, delimiter="\t", encoding='ansi', 
                dtype={"MakeLogo": str, "DetailNum": str, "DetailPrice": float, "DetailName": str, "PriceLogo": str, 
                       "Quantity": float, "PackQuantity": float, "Reliability": float, "WeightKG": float, "VolumeKG": float,
                       "MOSA": float},     
                                        
                usecols=['MakeLogo', 'DetailNum', 'DetailPrice', 'DetailName', 'PriceLogo',
                         'Quantity', 'PackQuantity', 'Reliability', 'WeightKG', 'VolumeKG', 
                         'MOSA']
                )
            #df = df[df['Quantity'] > 0] 
            df = df.fillna("") #  Функция fillna() автоматически найдет и заменит все значения NaN в DataFrame
            toc = time.perf_counter()
            logger.info(f'Загрузили файл {file} в объект DataFrame. Время выполнения  {toc - tic:0.4f}')
            
            sql.load_prices(data=df, batchsize=10000)
            df = df[0:0]            
            toc = time.perf_counter()
            logger.info(f"Завершение обработки файла {file}. Вычисление заняло {toc - tic:0.4f}")
            processed = True

        except BaseException as err:
            processed = False
            logger.error(err)

logger.info('Завершили импорт')
