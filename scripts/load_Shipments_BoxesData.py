from asyncio.windows_events import NULL
import os, fnmatch, re
import pandas as pd
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from dataTest import Sql



"""
Данные по каждой коробке записываются в новые строки
Строка состоит из пунктов, значение каждого из которых в кавычках, они разделены запятыми:

Номер груза
Номер коробки
Физический вес по данным поставщика
Физический вес по данным перевозчика
Объемный вес по данным поставщика
Объемный вес по данным перевозчика
Ширина по данным поставщика (ширина по данным перевозчика)
Длина по данным поставщика (длина по данным перевозчика)
Высота по данным поставщика (Высота по данным перевозчика)
Ссылки на картинки (внутри кавычек может быть одна ссылка или больше. Если их больше, они будут записаны через пробел)
"""

def load_boxes_detail(sql: Sql, data, batchsize=500):
    logger.info('Начало загрузки данных в базу SQL')
    cursor = sql.cnxn.cursor()
    cursor.fast_executemany = True

    query = f"""
        delete from pShipmentsBoxesData where spid = @@spid
    """
    cursor.execute(query)

    query = f"""
        INSERT INTO pShipmentsBoxesData
              ([Spid], [TransporterNumber], [BoxNumber], [SupplierPhysicalWeight], [TransporterPhysicalWeight], [SupplierVolumetricWeight], [TransporterVolumetricWeight], [SupplierWidth], [SupplierLength], [SupplierHeight], [ImageLinks], [TransporterWidth], [TransporterLength], [TransporterHeight])
        VALUES (@@Spid, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """
    for i in range(0, len(data), batchsize):
        batch = data[i: i+batchsize].values.tolist()
        logger.info(batch)
        cursor.executemany(query, batch)

    cursor.execute("exec ShipmentsBoxesFill @IsSave = 1")
    logger.info('Успешно загрузили данные в базу SQL')
    return True

config = configparser.ConfigParser()
config.read("settingstest.ini")

logger.add(config["Log"]["LogFile"] + 'load_Boxes_Data.log', level='DEBUG', rotation="1 MB")
logger.info('Начало импорта')

sql = Sql()
if sql.connection:
    logger.info('Успешно подключились к базе данных')
else:
    exit()

# Статусы доставок транспортной компании
directory=r'C:\\Users\\Администратор\\Мой диск\\Booster\\Shipping\\ADQ\\Shipping Data'
# directory = config["LoadPath"]["ShipmentsFile"] 

file_list = os.listdir(directory)  # определить список всех файлов
# Обрабатываем каждый файл в директории
for file in file_list:
    logger.info(f'Начало обработки файла {file}') 
    if fnmatch.fnmatch(file, "qbow197c_boxes.txt"):  # Проверяем, соответствует ли файл шаблону qbow198c_boxes qbow200c
        logger.info(f'Начало обработки файла {file}')
        try:
            df = pd.read_csv(os.path.join(directory, file), delimiter=",", header=None, quotechar='"', skipinitialspace=True)
            # logger.info(f'Завершение обработки файла\n{df}')
            # Обработка данных
            df = df.fillna("")
            # df = df.applymap(lambda x: x.strip('"').strip() if isinstance(x, str) else x)
            df = df.apply(lambda col: col.str.strip('"').str.strip() if col.dtype == "object" else col)
            logger.info(f'Убрали кавычки\n{df}')
            
            def split_values(value):
                match = re.match(r"(\d+\.\d+)\s*\(\s*(\d+\.\d+)\s*\)", value)
                if match:
                    return match.groups()
                return (value, None)

            # Разделение значений в 6-м столбце
            df[[6, 'TransporterWidth']] = df[6].apply(lambda x: pd.Series(split_values(x)))            
            df[[7, 'TransporterLength']] = df[7].apply(lambda x: pd.Series(split_values(x)))     
            df[[8, 'TransporterHeight']] = df[8].apply(lambda x: pd.Series(split_values(x)))  
            
            logger.info(f'Завершение обработки файла\n{df}')
            logger.info(f'Завершение обработки файла\n{df['TransporterWidth']}')
            
            
            # Разделение ссылок на изображения
            # df[9] = df[9].str.split(' ')
            # df = df.explode(9)

            load_boxes_detail(sql, data=df, batchsize=500)
            logger.info(f'Завершение обработки файла\n{file}')

        except BaseException as err:
            logger.error(err)

sql.close()
logger.info('Импорт завершен')
