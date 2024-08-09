import configparser
import pyodbc
#import pymssql
from datetime import datetime
import pandas as pd
from loguru import logger
import time

config = configparser.ConfigParser()  # создаём объект парсера
config.read("settingstest.ini")  # читаем конфиг

database_ = config["DataBase"]["database"]
server_ = config["DataBase"]["server"]
username_ = config["DataBase"]["username"]
password_ = config["DataBase"]["password"]

def timing_decorator(func):
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        logger.info(f"Время работы функции {func.__name__}: {time.strftime('%H:%M:%S', time.gmtime(end_time - start_time))}.")
        return result
    return wrapper

class Sql:
    """Sql - класс подключения к базе данных
    """
    connection = False

    def __init__(self, database=database_, server=server_, username=username_, password=password_):
        try:
            # ODBC Driver 17 for SQL Server
            # SQL Server Native Client 11.0
            self.cnxn = pyodbc.connect("Driver={ODBC Driver 17 for SQL Server};"
                                        "Server="+server+";"
                                        "Database="+database+";"
                                        "UID="+username+";"
                                        "PWD="+password+";"
                                        "Trusted_Connection=no;",
                                        autocommit=True
                                        )
            self.connection = True
        except BaseException as err:
            logger.error("Ошибка подключения к базе данных")
            logger.error(err)
            self.connection = False
            
    def close(self):
        if self.connection:
            self.cnxn.close()           
     
    def manual(self, query, response=False):
        """Позволяет упростить выполнение SQL-кода"""
        cursor = self.cnxn.cursor()  # создаем курсор выполнения

        if response:
            return pd.read_sql(query, self.cnxn)
        try:
            cursor.execute(query)  # execute
        except pyodbc.ProgrammingError as error:
            logger.error("Warning:\n{}".format(error))
        return "Query complete."

    def dropTmp(self, tables):
        if isinstance(tables, str):
            # если отдельная строка, переведем в список
            tables = [tables]
        for table in tables:
            # проверяем наличие таблицы и удаляем, если существует
            query = ("IF OBJECT_ID ('tempdb.."+table+"', 'U') IS NOT NULL "
                     "DROP TABLE ["+table+"]")

            self.manual(query)


    @timing_decorator
    def load_prices(self, data, batchsize=10000):
        '''Функция prepare_data подготовка данных для загрузки с использованием pandas DataFrame'''
        logger.info('Начало загрузки данных в базу SQL ...')      
        tic = time.perf_counter()
        
        cursor = self.cnxn.cursor()      # создаем курсор
        cursor.fast_executemany = True   # активируем быстрое выполнение

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
            ,Restrictions      nvarchar(64)   -- ограничения

            )
         create index ao2 on  [#Price] (MakeLogo, DetailNum);
         create unique index ao3 on  [#Price] (PriceLogo, DetailNum, MakeLogo)
         """

        cursor.execute(query)  # запуск создания таблицы

        query = """ INSERT INTO #Price 
                           ([MakeLogo], [DetailNum], [DetailPrice], [DetailName], [PriceLogo], [Quantity], [PackQuantity], [Reliability], [WeightKG], [VolumeKG], [Restrictions], [MOSA]) 
                    VALUES (?,?,?,?,?,nullif(?, ''),?,?,?,?,?,?) 
                """

        # вставляем данные в целевую таблицу
        for i in range(0, len(data), batchsize):
            toc3 = time.perf_counter() 
            if i+batchsize > len(data):
                batch = data[i: len(data)].values.tolist()
            else:
                batch = data[i: i+batchsize].values.tolist()

            # запускаем вставку батча   
            try: 
            #   print(batch)        
              cursor.executemany(query, batch)
            except BaseException as err:
                print(batch) 
                logger.error(err)
                return
            # logger.info(f'batch {i} Время пачки {time.perf_counter() - toc3:0.4f} Время {time.perf_counter() - tic:0.4f}')
            
        toc = time.perf_counter()    
        logger.info(f'Выполнили загрузку данных во временную таблицу. Время выполнения {toc - tic:0.4f}')
        tic = time.perf_counter()
        data.iloc[0:0]
        batch = []  
        
        self.manual("exec PriceUpdate")
        
        self.dropTmp('#Price')

        toc = time.perf_counter()
        logger.info(f'Выполнили загрузку в постоянную таблицу. Время выполнения  {toc - tic:0.4f}');
        return True
    

    # Функция load_makes загрузка данных с использованием pandas DataFrame
    @timing_decorator
    def load_makes(self, data, table, batchsize=500):
        logger.info('Начало загрузки данных в базу SQL');
        cursor = self.cnxn.cursor()      # создаем курсор
        cursor.fast_executemany = True   # активируем быстрое выполнение

        # Создаем таблицу для временных данных       
        query = """
         CREATE TABLE [{0}] (       
               [Code]     varchar(10) null,  
               [Name]     varchar(60) null,  
               [Country]  varchar(60) null   
         )
         
         create index ao1 on  [{0}] (Code)
        """.format(table)

        #self.drop(table)
        self.dropTmp(table)
        cursor.execute(query)  # запуск создания таблицы

        query = " INSERT INTO [" + table + "] ([Code], [Name], [Country]) VALUES (?, ?, ?) "

        # вставляем данные в целевую таблицу
        for i in range(0, len(data), batchsize):
            if i+batchsize > len(data):
                batch = data[i: len(data)].values.tolist()
            else:
                batch = data[i: i+batchsize].values.tolist()

            # запускаем вставку батча           
            cursor.executemany(query, batch)

            #self.cnxn.commit()

        self.manual("exec MakesUpdate")

        logger.info('Успешно загрузили данные в базу SQL')
        return True
    
    # Функция load_description наименований деталей с использованием pandas DataFrame
    @timing_decorator
    def load_description(self, data, table, batchsize=500):
        logger.info('Начало загрузки данных в базу SQL');
        cursor = self.cnxn.cursor()      # создаем курсор
        cursor.fast_executemany = True   # активируем быстрое выполнение

        # Создаем таблицу для временных данных       
        query = """
         CREATE TABLE [{0}] (       
               [Make]      nvarchar(10)  ,  
               [Number]    nvarchar(60)  ,  
               [Name_RUS]  nvarchar(256) null,
               [Name_ENG]  nvarchar(256) null   
         )         
         create index ao1 on  [{0}] (Make, Number)
        """.format(table)

        #self.drop(table)
        self.dropTmp(table)
        cursor.execute(query)  # запуск создания таблицы

        query = " INSERT INTO [" + table + "] ([Make], [Number], [Name_RUS], [Name_ENG]) VALUES (?, ?, ?, ?) "

        # вставляем данные в целевую таблицу
        for i in range(0, len(data), batchsize):
            if i+batchsize > len(data):
                batch = data[i: len(data)].values.tolist()
            else:
                batch = data[i: i+batchsize].values.tolist()

            # запускаем вставку батча           
            cursor.executemany(query, batch)

            #self.cnxn.commit()

        self.manual("exec PartDescriptionUpdate")

        logger.info('Успешно загрузили данные в базу SQL')
        return True    
