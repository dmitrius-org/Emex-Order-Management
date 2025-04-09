# import openpyxl
import xlwings as xw
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
import os
from data import Sql
from _utils import *
import getpass

config = configparser.ConfigParser()  # создаём объект парсера
config.read("settings.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'processing_emex_cancel.log', level='DEBUG', rotation="1 MB")
logger.info('Начало экспорта отказов')

logger.info(f'getuser: { getpass.getuser()}')
logger.info(f'getlogin: { os.getlogin()}')
logger.info(f'getpid: { os.getpid()}')
logger.info(f'getppid: { os.getppid()}')

conn = Sql()
if conn.connection:
    logger.info('Успешно подключились к базе данных')
else:
    exit()


sql = """
  select distinct OrderRefusalsID, FileName
    from tOrderRefusals t (nolock)
   where t.Flag&2=2
     and t.Flag&4=0
"""    
cursor = conn.cnxn.cursor()                   
prows = cursor.execute(sql).fetchall()    
if not (prows):
    logger.error('Нет данных для выгрузки')
    exit()     
     
# цикл по файлам
for file_row in prows:  
    excelfile = file_row.FileName

    logger.info(f'excelfile {excelfile}')
    if not os.path.isfile(excelfile): # проверка существования файла
      logger.error(f'Не удается найти файл: {excelfile} {file_row.OrderRefusalsID}')
      
      cursor.execute("""Update t 
                          set t.Flag     = 8
                          from tOrderRefusals t (updlock)
                        where t.OrderRefusalsID = ?""", (file_row.OrderRefusalsID))  
            
      continue  

    try:
      wb = xw.Book(os.path.abspath(excelfile))
      logger.info(f'Открыли файл для обработки {excelfile}')
      xw.App.visible = False
    except BaseException as err:
      logger.error(err)
      wb.close()
      wb.app.quit()
      continue

    try:
      sheet = wb.sheets[0] 

      rownum = sheet.api.UsedRange.Rows.Count

      cursor.execute('Delete pEmexRefusalsConfirm from pEmexRefusalsConfirm (rowlock) where spid = @@spid')

      for i in range(5, rownum): # The indexing starts at 1   
          sqltext=""" 
          set nocount on        
          declare @Brent         nvarchar(64)
                ,@DetailNumber  nvarchar(64)
                ,@DetailID      numeric(18, 0)
                ,@DetailCount   int  
                ,@r             int = 0
        
          select @Brent         = ?
                ,@DetailNumber  = ?
                ,@DetailID      = ?   

          delete pEmexRefusalsCalc from pEmexRefusalsCalc (rowlock) where spid = @@Spid

          insert pEmexRefusalsCalc
                (Spid, OrderID, isCancel, Quantity)
          select @@Spid
                ,o.OrderID
                ,o.isCancel
                ,o.Quantity
            from tOrders o (nolock)
           inner join tClients c with (nolock)
                   on c.ClientID = o.ClientID 
           where o.DetailNumber = @DetailNumber
             and o.Manufacturer = @Brent
             and cast(o.DetailID as numeric(18, 0)) = @DetailID
            -- and o.ClientID     = 3
             and c.NotificationMethod = 1 -- Ручной
             and c.ResponseType       = 0 -- Эмекс.ру  
             
             and not exists (select 1
                               from tMovement m (nolock)
                              where m.OrderNumber   = o.EmexOrderID
                                and m.DetailNum     = o.DetailNumber
                                and m.CustomerSubId = o.CustomerSubId
                                and m.Reference     = o.Reference 
                                and m.Quantity     <>  o.Quantity
                            )
             
          if exists (select 1 
                      from pEmexRefusalsCalc (nolock)
                      where spid = @@Spid)
            select  @DetailCount  = isnull(( select sum(Quantity)
                                               from pEmexRefusalsCalc (nolock)
                                              where spid                = @@Spid
                                                and isnull(isCancel, 0) = 0
                                            ), 0)
          else
            select @DetailCount = null
          
          select @DetailCount AS DetailCount;
          """

          params = (sheet.cells(i,3).value, sheet.cells(i,5).value, sheet.cells(i,7).value)

          cursor.execute(sqltext, params)
          DetailCount = cursor.fetchone()[0]  
          # print(RefusalsCount)
          if DetailCount is not None:
            sheet.cells(i,10).value = DetailCount
          
          cursor.execute('insert pEmexRefusalsConfirm (Spid, OrderID, Quantity) select Spid, OrderID, Quantity from pEmexRefusalsCalc (nolock) where spid = @@spid')
      # for i in range(5, rownum): 

      # имя обрабатываемого файла
      file_path = os.path.basename(excelfile)
                  
      uploadingRefusalsCatalog = cursor.execute("Select Val from tSettings (nolock) where Brief = 'UploadingRefusalsCatalog'").fetchone().Val   
 
      filexcelfile_out=getSpecialPath(uploadingRefusalsCatalog) + file_path
      wb.save(filexcelfile_out)  
      
      if wb:
        wb.close()
      
      if os.path.isfile(excelfile): 
        os.remove(excelfile)  

      cursor.execute("""
                      Insert tOrderRefusalsDetail 
                            (OrderRefusalsID, OrderID, Quantity, Flag)
                      select ?, p.OrderID, p.Quantity, 0
                        from pEmexRefusalsConfirm p (nolock)
                      where p.Spid = @@spid
                    """, (file_row.OrderRefusalsID))
      
      cursor.execute("""Update t 
                           set t.Flag     = t.Flag|4 
                              ,t.FileName = ?
                          from tOrderRefusals t (updlock)
                        where t.OrderRefusalsID = ?""", (filexcelfile_out, file_row.OrderRefusalsID))  
                
    except BaseException as err:
      logger.error(err)
      if wb:
        wb.close()
cursor.close

logger.info('Завершили для обработки')
