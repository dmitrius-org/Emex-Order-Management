#              Загрузка курсов с сайта ЦБ
# 
# 
import urllib.request
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from data import Sql

config = configparser.ConfigParser()  # создаём объекта парсера
config.read("settings.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'load_currency_rate.log', level='DEBUG', rotation="1 MB")
logger.info('Начало импорта')

url = config["Currency"]["LoadUrl"]
logger.info('Получение курсов с: ' + url)

webFile = urllib.request.urlopen(url)
data = webFile.read()

if data:
    sql = Sql()
    if sql.connection:
        logger.info('Успешно подключились к базе данных')
    else:
        exit()

    logger.info('Загрузка в базу данных: начало')
    cursor = sql.cnxn.cursor()      # создаем курсор
    cursor.fast_executemany = True   # активируем быстрое выполнение
    cursor.execute('exec LoadCurrencyRate @XMl = ?', (data))
    cursor.commit()
    logger.info('Загрузка в базу данных: конец')

logger.info('Завершили импорт')
