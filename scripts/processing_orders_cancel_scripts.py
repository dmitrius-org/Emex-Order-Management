'''
    Выгрузка отказов исходя из настройки "Способ оповещения = Скрипт" на карточке клиента                             
'''
import os
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from connect import Sql
import time
from _utils import *
import getpass
import subprocess
from dotenv import load_dotenv
import os

config = configparser.ConfigParser()  # создаём объект парсера
config.read("settings.ini")  # читаем конфиг

load_dotenv()
DATABASE = os.getenv("DATABASE")
SERVER = os.getenv("SERVER")
USERNAME = os.getenv("USERNAME")
PASSWORD = os.getenv("PASSWORD")

logger.add(config["Log"]["LogFile"] + 'processing_orders_scripts_cancel.log', level='DEBUG', rotation="1 MB")
logger.info('Начало экспорта отказов')
logger.info(f'getuser: { getpass.getuser()}')
logger.info(f'getlogin: { os.getlogin()}')
logger.info(f'getpid: { os.getpid()}')
logger.info(f'getppid: { os.getppid()}')
# ---------------------------------------------------
# подготовка данных для загрузки с использованием pandas DataFrame
conn = Sql(SERVER, DATABASE, USERNAME, PASSWORD)
if conn.connection:
    logger.info('Успешно подключились к базе данных')
else:
    exit()
crsr = conn.cnxn.cursor()      
    
sql = """
set nocount on;

Select distinct
       c.NotificationAddress as NotificationAddress     
      ,c.NotificationScript  as NotificationScript   
  from tClients c with (nolock)
 where c.NotificationMethod = 0 -- автоматическое оповещение
   and c.ResponseType       = 2 -- скрипт                
"""                

file_rows = crsr.execute(sql).fetchall()      
if not (file_rows):
    logger.error('Нет данных для выгрузки')
    exit()    

ticB = time.perf_counter()
for file_row in file_rows:
    tic = time.perf_counter()
    script_path =  file_row.NotificationScript.strip()

    if not script_path:
        logger.warning('Путь к скрипту отсутствует, пропускаем')
        continue

    logger.info(f'Запускаем скрипт: {script_path}')

    try:
        result = subprocess.run(
            script_path,
            shell=True,                # Использовать shell только если ты уверен в источнике скрипта
            check=True,                # Бросает исключение, если код завершения не 0
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True                  # Для получения stdout/stderr как строк
        )

        logger.info(f'Скрипт завершился успешно: {script_path}')
        logger.debug(f'Вывод скрипта:\n{result.stdout}')
        if result.stderr:
            logger.warning(f'Ошибки скрипта:\n{result.stderr}')

    except subprocess.CalledProcessError as e:
        logger.error(f'Ошибка при выполнении скрипта {script_path}')
        logger.error(f'Код возврата: {e.returncode}')
        logger.error(f'stderr: {e.stderr}')
   
logger.info(f'Завершили зкспорт. Вычисление заняло {time.perf_counter()-ticB:0.4f}')
  