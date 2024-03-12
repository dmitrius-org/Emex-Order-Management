from loguru import logger
import configparser  # импортируем библиотеку для чтения конфигов
import pyodbc
import cgi, cgitb
import sys 

config = configparser.ConfigParser()  # создаём объект парсера
config.read("Connection.ini")  # читаем конфиг

logger.add(config["Log"]["LogFile"] + 'user_register_charck.log', level='DEBUG', rotation="1 MB")
logger.info('Начало проверки регистрации пользователя')

form = cgi.FieldStorage()
# environ="post"
logger.info(form)
tokken = form.getvalue("tokken")

if tokken:
    database_ = config["DataBase"]["database"]
    server_ = config["DataBase"]["server"]
    username_ = config["DataBase"]["username"]
    password_ = config["DataBase"]["password"]

    cnxn = pyodbc.connect("Driver={ODBC Driver 17 for SQL Server};"
                          "Server="+server_+";"
                          "Database="+database_+";"
                          "UID="+username_+";"
                          "PWD="+password_+";"
                          "Trusted_Connection=no;",
                          autocommit=True
                        )
    if cnxn:
        logger.info('Успешно подключились к базе данных')
        
        cursor = cnxn.cursor()      # создаем курсор
        
        query = """
                declare @RetVal int
                exec @RetVal = ClientRegistrationConfirmed @Hash = ? 
                
                Select @RetVal as RetVal
                """                    
        file_rows = cursor.execute(query, (tokken)).fetchone()
        cnxn.close
        
        file_row = file_rows[0]
        
        if file_row==999:
            logger.info('Успешная авторизация')
            
            f = open ('.\success\success.html' , 'r')
            result = f.read()
            f.close
           
            # sys.stdout = open(999, 'w', encoding='windows-1251', closefd=False) 
            print('Status: 200 OK') 
            print('Content-Type: text/html; charset=utf-8') 
            print('')

            print(result)

            exit()  
            
logger.info(file_row)
logger.error('Ошибка авторизации')
print('Content-Type: text/plain')
print('')
print('ERR')
