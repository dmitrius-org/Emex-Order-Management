from asyncio.windows_events import NULL
import os
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from data import Sql
import time
import xlwings as xw
import sys
from utils import *


'''
                                Выгрузка отказов                                
'''

config = configparser.ConfigParser()  # создаём объект парсера
config.read("settings.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'save_orders_cancel.log', level='DEBUG', rotation="1 MB")
logger.info('Начало экспорта отказов')
# ---------------------------------------------------
# подготовка данных для загрузки с использованием pandas DataFrame
conn = Sql()
if conn.connection:
    logger.info('Успешно подключились к базе данных')
else:
    exit()

crsr = conn.cnxn.cursor()      

# шаблон файла отказов
templateOrderRefusals = crsr.execute("Select Val from tSettings (nolock) where Brief = 'TemplateOrderRefusals'").fetchone().Val   

if not os.path.isfile(templateOrderRefusals):
    logger.info(f'Не удается найти файл: {templateOrderRefusals}')
    exit  


uploadingRefusalsCatalog = crsr.execute("Select Val from tSettings (nolock) where Brief = 'UploadingRefusalsCatalog'" ).fetchone().Val   
if not os.path.isdir(uploadingRefusalsCatalog):
    logger.info(f'Не удается найти указанный путь: {uploadingRefusalsCatalog}')
    exit  

sql = """
  select ROW_NUMBER() over( partition by ClientName, PriceLogo, OrderNum order by ClientName, PriceLogo, OrderNum, MakeLogo ) as N, *
    from vUploadingRefusals 
   where 1=1
     and isnull(isCancelToClient, 0) = 0 
   Order by ClientName, PriceLogo, OrderNum, MakeLogo 
"""                     
prows = crsr.execute(sql).fetchall()    
if not (prows):
    logger.error('Нет данных для выгрузки')
    exit()  

try:
  wb = xw.Book(os.path.abspath(templateOrderRefusals))
  logger.info('Открыли шаблон для экспорта')
  xw.App.visible = False
except BaseException as err:
  logger.error(err)
  wb.close()
  wb.app.quit()
  exit

sheet = wb.sheets[0]  

i=0
tic = time.perf_counter()
for prow in prows:   
    sheet['A'+str(10+i)].value = prow.N 
    sheet['C'+str(10+i)].value = prow.MakeLogo
    sheet['D'+str(10+i)].value = prow.DetailNumber
    sheet['E'+str(10+i)].value = prow.Reference
    sheet['F'+str(10+i)].value = 'Нет в наличии!'
    sheet['H'+str(10+i)].value = 0
    sheet['K'+str(10+i)].value = 0.0
    sheet['L'+str(10+i)].value = 0.0

    crsr.execute("delete tTaskRefusals from tTaskRefusals (rowlock) where ID = ?", (prow.ID))   

    i=i+1
   
sheet['A1'].value = prow.ClientName 
sheet['G3'].value = prow.OrderNum 
sheet['D5'].value = prow.PriceLogo 
sheet['G5'].value = prow.AnswerDate 

uploadingRefusalsCatalog = getSpecialPath(uploadingRefusalsCatalog)

# file_path = Path(templateOrderRefusals)
# print(file_path)
# file_ext = file_path.suffix.lower()[1:] # расширение файла
# print(file_ext)       
# if file_ext == 'xlsx':
#     engine='openpyxl'
# elif file_ext == 'xls':    
#     engine=None 
if wb:
    wb.save(uploadingRefusalsCatalog + prow.Reference + '.xls')
    wb.close() 
            
# if app:
#     app.quit() 
logger.info(f'Завершили зкспорт. Вычисление заняло {time.perf_counter()-tic:0.4f}')