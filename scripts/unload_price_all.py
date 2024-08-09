import sys 
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from data import Sql
import csv
from _utils import *

# if len (sys.argv) < 2:
    # logger.error('Не задан прайс для выгрузки!')
    # exit()

config = configparser.ConfigParser()  # создаём объекта парсера
config.read("settings.ini")  # читаем конфиг
    
logger.add(config["Log"]["LogFile"] + 'price_export.log', level='DEBUG', rotation="1 MB")
logger.info('Начало экспорта') 

conn = Sql()
if (conn.connection):
    logger.info('Успешно подключились к базе данных')
else:
    exit()
    
crsr = conn.cnxn.cursor()        
    
#  Получение сведений по профилю
sql = """select p.Brief, p.UploadFolder, p.UploadFileName, isnull(d.Brief, ';') as UploadDelimiter
           from tProfilesCustomer p (nolock) 
           left join tDelimiter d (nolock)
                  on d.DelimiterID = p.UploadDelimiterID
          where isnull(p.UploadPriceName, '') <> ''     
            and isnull(p.Brief, '') <> ''
            and p.isActive = 1
      """
                   
prows = crsr.execute(sql).fetchall()    
if not (prows):
    logger.error('Нет активных профилей для выгрузки прайса')
    exit()  

try: 
# if 1==1:
    for prow in prows:   
        ProfilesName = prow.Brief
        logger.info('Начало выгрузки профиля [{0}]'.format(ProfilesName))
        
        export_file_name = getSpecialPath(prow.UploadFolder) + prow.UploadFileName +'.txt'
                            
        rows = crsr.execute('exec DetailPriceCalc @ProfileName = ?', (ProfilesName))

        if not rows.rowcount == 0:
            with open(export_file_name, 'w', newline='') as csvfile:
                logger.info(f'prow.UploadDelimiter {prow.UploadDelimiter}')
                writer = csv.writer(csvfile, delimiter=prow.UploadDelimiter)
                writer.writerow([x[0] for x in crsr.description])  # column headers
                for row in rows:
                    writer.writerow(row)

        crsr.commit()     # коммит для изменений      
        logger.info('Конец выгрузки профиля [{0}], имя файла [{1}]'.format(ProfilesName, export_file_name))     
    
except BaseException as err:
    logger.error(err)           

logger.info('Конец экспорта')
