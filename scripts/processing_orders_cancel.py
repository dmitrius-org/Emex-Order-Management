'''
        Выгрузка отказов исходя из настройки "Способ оповещения = автоматический" на карточке клиента                             

'''

import os
from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
from data import Sql
import time
import xlwings as xw
from utils import *


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
                    ,ClientName    
                    )   
                      
              select OperDate 
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
                    ,ClientName    
                from #UnloadRefusals (nolock)
               where FileName = @FileName

          delete pAuditInsert from pAuditInsert (rowlock) where spid=@@spid

          insert pAuditInsert
                (Spid
                ,ObjectID
                ,ObjectTypeID
                ,ActionID
                ,Comment
                )

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
    

config = configparser.ConfigParser()  # создаём объект парсера
config.read("settings.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'processing_orders_cancel.log', level='DEBUG', rotation="1 MB")
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
set nocount on;
--delete  from tUnloadRefusals where clientid = 9

if OBJECT_ID('tempdb..#UnloadRefusals') is not null
  drop table #UnloadRefusals
CREATE TABLE #UnloadRefusals
(
 OperDate             datetime -- дата выгрузки ответа
,FileName             nvarchar(256)  
,ClientName           nvarchar(512)
,OrderNum             nvarchar(128)
,MakeLogo             nvarchar(32)
,DetailNumber         nvarchar(128)
,Reference            nvarchar(128)
,DetailID             nvarchar(128)
,Quantity             int 
,PricePurchase        money
,AmountPurchase       money
,ClientID             numeric(18, 0)
,NotificationAddress  nvarchar(512)
);

insert #UnloadRefusals
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
      ,ClientName    
      ,NotificationAddress      )
Select p.OperDate 
      ,p.FileName        	         
      ,p.OrderNum        
      ,p.MakeLogo        
      ,p.DetailNumber    
      ,p.Reference 
      ,p.DetailID      
      ,p.Quantity        
      ,p.PricePurchase   
      ,p.AmountPurchase  
      ,p.ClientID
      ,p.ClientName    
      ,p.NotificationAddress  
  from (Select cast(GetDate() as Date)	 as OperDate -- Дата ответа
              ,c.ClientID
              ,c.Brief                   as ClientName
              ,c.Brief +' '+ REPLACE(convert(varchar(10), getdate(), 3), '/', '') as FileName
         	  ,o.OrderNum 
         	  ,o.MakeLogo
         	  ,o.DetailNumber
         	  ,o.Reference
              ,o.DetailID
         	  ,sum( iif(o.isCancel=1, 0, 1) *  o.Quantity ) as Quantity
         	  ,max(o.PricePurchase)       as PricePurchase
         	  ,sum(o.AmountPurchase)      as AmountPurchase  
              ,max(c.NotificationAddress) as NotificationAddress           
          from tClients c with (nolock)
         inner join tOrders o with (nolock)
                 on o.ClientID = c.ClientID
                and o.MakeLogo is not null
                and o.DetailNumber = '12018AB470'
         where c.NotificationMethod = 0 -- автоматическое оповещение
           and c.ResponseType       = 1 -- файл           
           and not exists (select 1
                             from tMovement m (nolock)
                            where m.OrderNumber      = o.EmexOrderID
                              and m.DetailNum        = o.DetailNumber
                              and m.CustomerSubId    = o.CustomerSubId
                              and m.Reference        = o.Reference 
                              and m.Quantity        <> o.Quantity
                              )
           and not exists ( select 1
                              from tProtocol t
                             where t.ObjectID = o.Orderid
				               and t.NewStateID=8
			                   and isnull(t.OperDate, '20500101') < '20231218' 
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

select distinct 
       FileName, NotificationAddress 
  from #UnloadRefusals (nolock)

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
            ,MakeLogo
            ,DetailNumber
            ,case 
                when len(Reference) < 10
                then DetailID
                else Reference
             end as Reference    
            ,Quantity
            ,PricePurchase
            ,AmountPurchase
            ,ClientName
        from #UnloadRefusals (nolock)
       where FileName = ?
        order by FileName 
        """     
    prows = crsr.execute(sql2, (filename)).fetchall()    
    # if not (prows):
    #     logger.error('Нет данных для выгрузки')
    #     exit()  

    # создание файла    
    try:
        wb = xw.Book(os.path.abspath(templateOrderRefusals))
        logger.info('Открыли шаблон для экспорта')
        wb.app.display_alerts=False
        wb.app.screen_updating=False
        wb.app.enable_events = False

        xw.App.visible = False
        
        
        logger.info(f'Начало зкспорта {filename}')
        sheet = wb.sheets[0] 

    except BaseException as err:
        logger.error(err)
        if wb:
            wb.close()
            # wb.app.quit()
        
        # if app:
        #   app.quit()  
        # exit()
    i=0
    for prow in prows:         
        # print(prow.DetailNumber, prow.PricePurchase, i)
        sheet.range('A'+str(10+i)).value = prow.N 
        sheet.range('C'+str(10+i)).value = prow.MakeLogo
        sheet.range('D'+str(10+i)).value = prow.DetailNumber
        sheet.range('E'+str(10+i)).value = prow.Reference
            
        if prow.Quantity == 0:
            sheet.range('F'+str(10+i)).value = 'Нет в наличии!'
            sheet.range('H'+str(10+i)).value = 0
            sheet.range('K'+str(10+i)).value = 0.0
            sheet.range('L'+str(10+i)).value = 0.0   
        else:
            sheet.range('F'+str(10+i)).value = '' 
            sheet.range('H'+str(10+i)).value = prow.Quantity
            sheet.range('K'+str(10+i)).value = prow.PricePurchase
            sheet.range('L'+str(10+i)).value = prow.AmountPurchase

        i=i+1
    # end for prow in prows:    

    # сохранение файла
    if wb:
        logger.info((file_row.NotificationAddress) ) 
        sheet['A1'].value = prow.ClientName 
        sheet['G3'].value = '' #prow.OrderNum 
        sheet['D5'].value = '' #prow.PriceLogo 
        sheet['G5'].value = prow.OperDate 

        sheet['H9'].value = '=SUM(H10:H' + str(10+i) + ')'    
        sheet['L9'].value = '=SUM(L10:L' + str(10+i) + ')'     
        # print(getSpecialPath(uploadingRefusalsCatalog))
        wb.save(getSpecialPath(file_row.NotificationAddress) + filename + '.xls')
        wb.close()
        # wb.app.quit() 

   
        
        orderRefusalsInsert(crsr, filename, getSpecialPath(file_row.NotificationAddress) + filename + '.xls') 

        logger.info(f'Завершили зкспорт {filename}. Вычисление заняло {time.perf_counter()-tic:0.4f}')   
    
logger.info(f'Завершили зкспорт. Вычисление заняло {time.perf_counter()-ticB:0.4f}')
  