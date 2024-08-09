#              Загрузка курсов с сайта ЦБ
# 
# 

import urllib.request
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from data import Sql

config = configparser.ConfigParser()  # создаём объекта парсера
config.read("settings.ini")  # читаем конфиг

# logger.remove()
logger.add(config["Log"]["LogFile"] + 'test.log', level='DEBUG', rotation="1 MB")
logger.info('info')
logger.info('error:')
logger.info('info')

print('{result:0}')