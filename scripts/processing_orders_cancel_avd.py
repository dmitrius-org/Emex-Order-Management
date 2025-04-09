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


def orderRefusalsInsert(Acrsr, Afilename, AfilePath):
    Acrsr.execute(""" insert tOrderRefusals (FileName, Flag, UpdDateTime) select ?, ?, GetDate() """, (AfilePath, 4))    
    sql = """
              declare @FileName varchar(60)

              select @FileName = ? 

              insert tUnloadRefusals
                    (OperDate 
                    ,FileName        	         
                    ,OrderNum        
                    ,MakeLogo        
                    ,DetailNumber    
                    ,Reference  
                    ,DetailID     
                    ,Quantity        
                    ,PricePurchase   
                    ,AmountPurchase  
                    ,ClientID
                    ,ClientName)   
              select OperDate 
                    ,FileName        	         
                    ,OrderNum        
                    ,MakeLogo        
                    ,DetailNumber    
                    ,Reference  
                    ,DetailID     
                    ,Quantity        
                    ,Price   
                    ,Amount  
                    ,ClientID
                    ,ClientName    
                from #UnloadRefusals (nolock)
               where FileName = @FileName

          delete pAuditInsert from pAuditInsert (rowlock) where spid=@@spid

          insert pAuditInsert
                (Spid
                ,ObjectID
                ,ObjectTypeID
                ,ActionID
                ,Comment)
                
          select @@Spid 
                ,o.OrderID       	         
                ,3        
                ,5 -- acCancel        
                ,'Выгрузка отказов: Количество=' + convert(varchar(50), p.Quantity) + ', файл: ' + @FileName     
            from #UnloadRefusals p (nolock)
           inner join tOrders o (nolock)
                   on o.ClientID     = p.ClientID
                  and o.DetailNumber = p.DetailNumber 
                  and o.Reference    = p.Reference
                  and o.DetailID     = p.DetailID  
           where p.FileName = @FileName
                  
          exec MassAuditInsert

        """         
    Acrsr.execute(sql, (Afilename))          


logger.add(config["Log"]["LogFile"] + 'processing_orders_cancel_avd.log', level='DEBUG', rotation="1 MB")
logger.info('Начало экспорта отказов')
logger.info(f'SMTP_LOGIN {SMTP_LOGIN}')
logger.info(f'EMAIL_FROM {EMAIL_FROM}')

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

# шаблон файла отказов
templateOrderRefusals = "c:\\scripts\\Template\\TemplateOrderRefusalsAVD.xls"

if not os.path.isfile(templateOrderRefusals):
    logger.info(f'Не удается найти файл: {templateOrderRefusals}')
    exit  
    
sql = """
set nocount on;

if OBJECT_ID('tempdb..#UnloadRefusals') is not null
  drop table #UnloadRefusals
CREATE TABLE #UnloadRefusals
(
 OperDate             datetime -- дата выгрузки ответа
,FileName             varchar(256) 
,OrderDate            DateTime 
,ClientName           varchar(512)
,OrderNum             varchar(128)
,DetailName           varchar(256)
,MakeLogo             varchar(32)
,Brand                varchar(128)
,UploadFileName       varchar(32)
,DetailNumber         varchar(128) 
,CustomerPriceLogo    varchar(32)
,Reference            varchar(128)
,DetailID             varchar(128)
,Quantity             int 
,QuantityOrg          int
,Price                int
,Amount               int
,ClientID             numeric(18, 0)
,NotificationAddress  varchar(512)
,NotificationScript   varchar(512)
,OnlyThisBrand        varchar(30)
,CustomerClientNum    varchar(128)   
,CustomerClientSign   varchar(128)  
,CustomerOrder        varchar(128)  
);

insert #UnloadRefusals
      (OperDate 
      ,FileName        	         
      ,OrderNum 
      ,OrderDate       
      ,MakeLogo        
      ,DetailNumber    
      ,DetailName
      ,CustomerPriceLogo
      ,Reference  
      ,DetailID     
      ,Quantity   
      ,QuantityOrg
      ,Price  
      ,Amount  
      ,ClientID
      ,ClientName    
      ,NotificationAddress     
      ,NotificationScript
      ,UploadFileName
      ,Brand
      ,OnlyThisBrand
      ,CustomerClientNum      
      ,CustomerClientSign    
      ,CustomerOrder           
      )
Select dateadd(dd, 0, p.OperDate) 
      ,p.FileName        	         
      ,p.OrderNum  
      ,p.OrderDate      
      ,p.MakeLogo        
      ,p.DetailNumber 
      ,p.DetailName 
      ,p.CustomerPriceLogo  
      ,p.Reference 
      ,p.DetailID      
      ,p.Quantity   
      ,p.QuantityOrg
      ,p.Price   
      ,p.Amount 
      ,p.ClientID
      ,p.ClientName    
      ,p.NotificationAddress  
      ,p.NotificationScript
      ,p.UploadFileName
      ,p.Brand
      ,p.OnlyThisBrand
      ,p.CustomerClientNum
      ,p.CustomerClientSign   
      ,p.CustomerOrder        
  from (Select cast(GetDate() as Date)	 as OperDate -- Дата ответа
              ,c.ClientID
              ,c.Brief                   as ClientName
              ,'Order' + o.OrderNum + '(' + REPLACE(convert(varchar(10), max(o.OrderDate), 4), '/', '') + ')' as FileName
         	    ,o.OrderNum 
              
         	    ,o.MakeLogo
         	    ,o.DetailNumber
         	    ,o.Reference
              ,o.DetailID
              
              ,max(o.OrderDate)         OrderDate
              ,max(o.CustomerPriceLogo) CustomerPriceLogo
              ,max(o.DetailName)        DetailName 
              ,max(o.Manufacturer)      Brand              
         	    ,sum( iif(o.isCancel=1, 0, 1) *  o.Quantity ) as Quantity
              ,sum(o.Quantity)                              as QuantityOrg
         	    ,max(isnull(o.Price, 0))                      as Price
         	    ,sum(isnull(o.Amount, 0))                     as Amount
              ,max(c.NotificationAddress)                   as NotificationAddress     
              ,max(c.NotificationScript)                    as NotificationScript   
              ,min(cpm.UploadFileName)                      as UploadFileName
              ,case              
                 when SUM(DISTINCT 
                          CASE WHEN o.Flag & 2097152  <> 0 THEN 1 ELSE 0 END * 2097152
                          )&2097152 > 0 
                 then 'Без замен'
                 else ''
               end                                          as OnlyThisBrand
              ,max(isnull(o.CustomerClientNum , '')) as CustomerClientNum     
              ,max(isnull(o.CustomerClientSign, '')) as CustomerClientSign    
              ,max(isnull(o.CustomerOrder     , '')) as CustomerOrder      
          from tClients c with (nolock)
         inner join tOrders o with (nolock)
                 on o.ClientID = c.ClientID
                and o.MakeLogo is not null
         left join vClientProfilesParam cpm (nolock)   
                on cpm.ClientID = c.ClientID
               and cpm.ClientPriceLogo = o.CustomerPriceLogo
         where c.NotificationMethod = 0 -- автоматическое оповещение
           and c.ResponseType       = 2 -- скрипт           
           and not exists (select 1
                             from tMovement m (nolock)
                            where m.OrderID       = o.OrderID
                              and m.Quantity     <> o.Quantity
                            union all
                           select 2
                             from tMovement m (nolock)
                            where m.OrderNumber      = o.EmexOrderID
                              and m.DetailNum        = o.DetailNumber
                              and m.CustomerSubId    = o.CustomerSubId
                              and m.Reference        = o.Reference 
                              and (isnull(m.OrderID, 0) = 0 
                                or m.Quantity <> o.Quantity)
                          ) 
          
         group by c.ClientID, c.Brief, o.OrderNum, o.MakeLogo, o.DetailNumber, o.Reference, o.DetailID 
         ) as p
  outer apply (select top 1 ur.DetailNumber
                 from tUnloadRefusals ur (nolock)
                where ur.ClientID     = p.ClientID
                  and ur.DetailNumber = p.DetailNumber 
                  and ur.Reference    = p.Reference
                  and ur.DetailID     = p.DetailID
                  and ur.Quantity     = p.Quantity
                order by ur.OperDate desc
                ) ur

where ur.DetailNumber is null
  and isnull(p.NotificationAddress, '') <> ''
  and isnull(p.NotificationScript, '')  <> ''
  
select distinct 
       FileName, NotificationAddress, NotificationScript 
  from #UnloadRefusals (nolock)
 where OrderNum ='BRA0000000009'
 order by FileName
"""                

file_rows = crsr.execute(sql).fetchall()      
if not (file_rows):
    logger.error('Нет данных для выгрузки')
    exit()      

ticB = time.perf_counter()
for file_row in file_rows:  
    tic = time.perf_counter()
    filename = file_row.FileName
    
    sql2 = """
      select ROW_NUMBER() over( partition by FileName order by FileName) as N
            ,FileName
            ,OperDate
            ,OrderNum
            ,convert(varchar(8), OrderDate, 3) OrderDateStr
            ,UploadFileName
            ,MakeLogo
            ,DetailNumber
            ,DetailName
            ,CustomerPriceLogo
            ,DetailID    
            ,Quantity
            ,QuantityOrg
            ,Price
            ,Amount
            ,Brand
            ,OnlyThisBrand
            ,CustomerClientNum  -- № Клиента
            ,CustomerClientSign -- Пометки Клиента
            ,CustomerOrder      -- Заказ
        from #UnloadRefusals (nolock)
       where FileName = ?
       order by FileName 
    """     
    prows = crsr.execute(sql2, (filename)).fetchall()    
    if not (prows):
        logger.error('Нет данных для выгрузки')
        exit()  

    # создание файла    
    try:
        wb = xw.Book(os.path.abspath(templateOrderRefusals))

        logger.info(f'Начало зкспорта {filename}')
        sheet = wb.sheets[0] 
    except BaseException as err:
        logger.error(err)
        if wb:
            wb.close()
            
    i=0
    n = 5
    for prow in prows:         
        sheet.range('A'+str(n+i)).value = prow.N 
        sheet.range('B'+str(n+i)).value = prow.Brand
        sheet.range('C'+str(n+i)).value = prow.DetailNumber
        
        sheet.range('E'+str(n+i)).value = prow.Quantity
        if prow.Quantity == prow.QuantityOrg:
            sheet.range('E' + str(n + i)).color =  (0, 255, 0)  # зелёный (по умолчанию)
        elif prow.Quantity == 0:  
            sheet.range('E' + str(n + i)).color = (255, 0, 0)  # красный 
        else:
            sheet.range('E' + str(n + i)).color = (255, 255, 0)  # жёлтый
        
        sheet.range('F'+str(n+i)).value = prow.DetailName
        sheet.range('G'+str(n+i)).value = prow.CustomerPriceLogo
        sheet.range('H'+str(n+i)).value = prow.Price
        sheet.range('I'+str(n+i)).value = prow.Amount
        sheet.range('J'+str(n+i)).value = prow.CustomerClientNum
        sheet.range('K'+str(n+i)).value = prow.CustomerClientSign
        sheet.range('L'+str(n+i)).value = prow.CustomerOrder
        sheet.range('N'+str(n+i)).value = prow.OnlyThisBrand
        sheet.range('O'+str(n+i)).value = prow.OrderNum
        sheet.range('P'+str(n+i)).value = prow.DetailID
        
        i=i+1
    # end for prow in prows:    

    # сохранение файла
    if wb:
        sheet['D1'].value = prow.OrderDateStr
        sheet['D2'].value = prow.OrderNum 
        sheet['D3'].value = prow.UploadFileName 
    #     sheet['H9'].value = '=SUM(H10:H' + str(10+i) + ')'       
        logger.info(f'Сохранение {filename}')
        wb.save(getSpecialPath(file_row.NotificationAddress) + filename + '.xls')
        wb.close()
        
        
        send_excel_via_email(
            file_path=getSpecialPath(file_row.NotificationAddress) + filename + '.xls',
            order_number=prow.OrderNum 
        )
        
        # orderRefusalsInsert(crsr, filename, getSpecialPath(file_row.NotificationAddress) + filename + '.xls') 

        logger.info(f'Завершили зкспорт {filename}. Вычисление заняло {time.perf_counter()-tic:0.4f}')   
    
logger.info(f'Завершили зкспорт. Вычисление заняло {time.perf_counter()-ticB:0.4f}')
  