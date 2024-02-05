import configparser
# import pyodbc 
import pymssql
#import pymssql
from datetime import datetime
import pandas as pd
from loguru import logger
import time
import utils as u

config = configparser.ConfigParser()  # создаём объект парсера
config.read("settings.ini")  # читаем конфиг

database_ = config["DataBase"]["database"]
server_ = config["DataBase"]["server"]
username_ = config["DataBase"]["username"]
password_ = config["DataBase"]["password"]

def timing_decorator(func):
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        logger.info(f"Время работы функции {func.__name__}: {u.t(end_time - start_time)}.")
        return result
    return wrapper

class Sql:
    """Sql - класс подключения к базе данных
    """
    connection = False

    def __init__(self, database=database_, server=server_, username=username_, password=password_):
        try:
            self.con = pymssql.connect(
                                        host=server,
                                        database=database,
                                        user=username,
                                        password=password,
                                        # Trusted_Connection=no,
                                        autocommit=True,
                                        as_dict=True, 
                                        )
            self.connection = True

        except BaseException as err:
            logger.error("Ошибка подключения к базе данных")
            logger.error(err)
            self.connection = False
    

    # Функция prepare_data подготовка данных для загрузки с использованием pandas DataFrame
    @timing_decorator
    def load_prices(self, data, batchsize=1000):
        logger.info('Начало загрузки данных в базу SQL ...')      
        tic = time.perf_counter()
        
        cursor = self.con.cursor()      # создаем курсор

        # Создаем таблицу для временных данных              
        query = """
            if OBJECT_ID('tempdb..#Price') is not null
                drop table #Price
            create table #Price
            (

             MakeLogo          varchar(30)    -- Зашифрованное название бренда
            ,DetailNum	       varchar(40)    -- Номер детали 
            ,DetailPrice       float          -- Цена
            ,DetailName	       varchar(128)   -- Название
            ,PriceLogo         varchar(30)    -- Название прайса 
            ,Quantity          float          -- Количество
            ,PackQuantity      float          -- Количество в упаковке
            ,Reliability       float          -- Вероятность поставки
            ,WeightKG          float          -- Вес физический кг 
            ,VolumeKG          float          -- Вес объемный кг
            ,MOSA              float          -- цена типа MOSA
            )
         create index ao2 on  [#Price] (MakeLogo)
         create unique CLUSTERED index ao3 on  [#Price] (PriceLogo, DetailNum, MakeLogo)
         """

        cursor.execute(query)  # запуск создания таблицы

        # вставляем данные в целевую таблицу
        for i in range(0, len(data), batchsize):
            toc3 = time.perf_counter() 
            if i+batchsize > len(data):
                batch = data[i: len(data)].values.tolist()
            else:
                batch = data[i: i+batchsize].values.tolist()
            # запускаем вставку батча           
            self.con.bulk_copy("#Price", batch)      
            logger.info(f"batch {i} Время пачки {time.perf_counter() - toc3:0.4f} Время {u.t(time.perf_counter() - tic)}")
          
        data.iloc[0:0] 
        batch = []
        toc = time.perf_counter()    
        logger.info(f'Выполнили загрузку данных во временную таблицу. Время выполнения {u.t(toc - tic)}');
        tic = time.perf_counter()
        
        cursor.execute(" exec PriceUpdate ")
        
        cursor.execute(""" IF OBJECT_ID ('tempdb..#Price', 'U') IS NOT NULL 
                           DROP TABLE #Price """)

        toc = time.perf_counter()
        logger.info(f'Выполнили загрузку в постоянную таблицу. Время выполнения  {u.t(toc - tic)}');
        return True

