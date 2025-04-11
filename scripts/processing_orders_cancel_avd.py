'''
    Выгрузка отказов для клиента avd                            
'''

import os
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from connect import Sql
import time
import xlwings as xw
from _utils import *
import getpass
import smtplib
from email.message import EmailMessage
import mimetypes
from datetime import datetime
from dotenv import load_dotenv
import os


config = configparser.ConfigParser()  # создаём объект парсера
config.read("settings.ini")  # читаем конфиг

# Загрузка .env файла
load_dotenv()

SMTP_SERVER = os.getenv("SMTP_SERVER")
SMTP_PORT = int(os.getenv("SMTP_PORT"))
SMTP_LOGIN = os.getenv("SMTP_LOGIN")
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD")
EMAIL_FROM = os.getenv("EMAIL_FROM")
EMAIL_TO_TEST = os.getenv("EMAIL_TO_TEST")

DATABASE = os.getenv("DATABASE")
SERVER = os.getenv("SERVER")
USERNAME = os.getenv("USERNAME")
PASSWORD = os.getenv("PASSWORD")


def load_sql(filename: str) -> str:
    with open(os.path.join('sql', filename), 'r', encoding='utf-8') as f:
        return f.read()
                
def fetch_files_for_export(cursor):
    sql = load_sql("avd_cancel_fetch_files_for_export.sql")
    return cursor.execute(sql).fetchall()

def fetch_file_rows(cursor, filename):
    sql = load_sql("avd_cancel_fetch_file_rows.sql")
    return cursor.execute(sql, (filename,)).fetchall()   


def send_excel_via_email(file_path, order_number):
    order_date = datetime.now().strftime('%d.%m.%y')
    subject = f"Заказ на поставку {order_number} ({order_date}) от ООО «АВД МОТОРС»."

    msg = EmailMessage()
    msg['Subject'] = subject
    msg['From'] = EMAIL_FROM
    msg['To'] = EMAIL_TO_TEST
    # msg.set_content(f'Здравствуйте,\n\nВо вложении находится заказ {order_number}.\n\nС уважением,\nООО «АВД МОТОРС»')

    mime_type, _ = mimetypes.guess_type(file_path)
    mime_type, mime_subtype = mime_type.split('/')

    with open(file_path, 'rb') as f:
        msg.add_attachment(f.read(),
                           maintype=mime_type,
                           subtype=mime_subtype,
                           filename=os.path.basename(file_path))

    try:
        with smtplib.SMTP(SMTP_SERVER, SMTP_PORT) as server:
            server.starttls()
            server.login(SMTP_LOGIN, SMTP_PASSWORD)
            server.send_message(msg)
            logger.info(f'Письмо с заказом {order_number} успешно отправлено на {EMAIL_TO_TEST}')
    except Exception as e:
        logger.error(f'Ошибка при отправке письма: {e}')


def orderRefusalsInsert(cursor, filename, file_path):
    sql = load_sql("order_refusals_insert.sql")
    cursor.execute(sql, (file_path, filename))         


def generate_excel_file(prows, filename, template_path, save_path, excel_app):
    from pathlib import Path

    column_mapping = {
        'N': 'A',
        'Brand': 'B',
        'DetailNumber': 'C',
        'Quantity': 'E',
        'DetailName': 'F',
        'CustomerPriceLogo': 'G',
        'Price': 'H',
        'Amount': 'I',
        'CustomerClientNum': 'J',
        'CustomerClientSign': 'K',
        'CustomerOrder': 'L',
        'OnlyThisBrand': 'N',
        'OrderNum': 'O',
        'DetailID': 'P',
    }

    wb = None
    try:
        # Открытие книги в существующем экземпляре Excel
        wb = excel_app.books.open(os.path.abspath(template_path))
        sheet = wb.sheets[0]
        logger.info(f'Начало экспорта {filename}')
        
        base_row = 5
        for i, prow in enumerate(prows):
            row = base_row + i
            for attr, col in column_mapping.items():
                value = getattr(prow, attr)
                sheet.range(f'{col}{row}').value = value

            # Цвет ячеек на основе количества
            quantity = prow.Quantity
            quantity_org = prow.QuantityOrg
            if quantity == quantity_org:
                sheet.range(f'E{row}').color = (0, 255, 0)
            elif quantity == 0:
                sheet.range(f'E{row}').color = (255, 0, 0)
            else:
                sheet.range(f'E{row}').color = (255, 255, 0)

        # Верхние значения (дата, номер, имя файла)
        sheet['D1'].value = prows[0].OrderDateStr
        sheet['D2'].value = prows[0].OrderNum
        sheet['D3'].value = prows[0].UploadFileName


        today_str = datetime.today().strftime("%d%m%Y")
        full_path = Path(save_path) / today_str / f"{filename}.xls"
        Path(save_path, today_str).mkdir(parents=True, exist_ok=True)
        
        logger.info(f'Сохранение {full_path}')
        wb.save(str(full_path))
        
        return str(full_path)

    except Exception as e:
        logger.error(f"Ошибка при генерации Excel-файла: {e}")
    finally:
        if wb:
            wb.close()
  
            
            
# ---------------------------------------------------            
logger.add(config["Log"]["LogFile"] + 'processing_orders_cancel_avd.log', level='DEBUG', rotation="1 MB")
logger.info('Начало экспорта отказов')
logger.info(f'SMTP_LOGIN {SMTP_LOGIN}')
logger.info(f'EMAIL_FROM {EMAIL_FROM}')

logger.info(f'getuser: { getpass.getuser()}')
logger.info(f'getlogin: { os.getlogin()}')
logger.info(f'getpid: { os.getpid()}')
logger.info(f'getppid: { os.getppid()}')


conn = Sql(SERVER, DATABASE, USERNAME, PASSWORD)
if conn.connection:
    logger.info('Успешно подключились к базе данных')
else:
    exit()
crsr = conn.cnxn.cursor()      

# шаблон файла отказов
templateOrderRefusals = "c:\\scripts\\Template\\TemplateOrderRefusalsAVD.xls"
if not os.path.isfile(templateOrderRefusals):
    logger.info(f'Не удается найти файл: {templateOrderRefusals}')
    exit() 
                
file_rows = file_rows = fetch_files_for_export(crsr)    
if not (file_rows):
    logger.error('Нет данных для выгрузки')
    exit()   
       
ticB = time.perf_counter()

# В основном цикле создаём одно приложение Excel
excel_app = xw.App(visible=False)  # Включите visible=True, если хотите видеть процесс
excel_app.display_alerts = False  # Отключить всплывающие окна

for file_row in file_rows:  
    tic = time.perf_counter()
    filename = file_row.FileName
    
    prows = fetch_file_rows(crsr, filename)
    if not prows:
        logger.error(f'Нет данных для файла {filename}')
        continue

    output_path = getSpecialPath(file_row.NotificationAddress)
    full_excel_path = generate_excel_file(prows, filename, templateOrderRefusals, output_path, excel_app)

    send_excel_via_email(file_path=full_excel_path, order_number=prows[0].OrderNum)
        
    orderRefusalsInsert(crsr, filename, full_excel_path) 

    logger.info(f'Завершили зкспорт {filename}. Вычисление заняло {time.perf_counter()-tic:0.4f}')   
    
logger.info(f'Завершили зкспорт. Вычисление заняло {time.perf_counter()-ticB:0.4f}')
  
# Закрытие приложения Excel после выполнения всех операций
excel_app.quit()
