from flask import Flask, render_template, request
import pyodbc
import configparser  # импортируем библиотеку для чтения конфигов
from loguru import logger

app = Flask(__name__, static_url_path="/confirm_static", static_folder='confirm_static')

config = configparser.ConfigParser()  # создаём объект парсера
config.read("Connection.ini")  # читаем конфиг

# logger.remove
logger.add(config["Log"]["LogFile"] + 'password_reset.log', level='DEBUG', rotation="1 MB")   
logger.info('Начало сброса пароля клиента')

database_ = config["DataBase"]["database"]
server_ = config["DataBase"]["server"]
username_ = config["DataBase"]["username"]
password_ = config["DataBase"]["password"]

def conn(): 
    cnxn = pyodbc.connect("Driver={ODBC Driver 17 for SQL Server};"
                        "Server="+server_+";"
                        "Database="+database_+";"
                        "UID="+username_+";"
                        "PWD="+password_+";"
                        "Trusted_Connection=no;",
                        autocommit=True
                        )
    return cnxn.cursor() # создаем курсор 

@app.route('/confirmed/', methods=['get'])
# @app.route('/', methods=['get'])
def index():
  logger.info(f'index')  
  logger.info(f'request: {request}')  
  
  tokken = request.args['tokken'] 
  
  if tokken:    
        logger.info('Успешно подключились к базе данных')      
        
        query = """
                declare @RetVal int 

                exec @RetVal = ClientRegistrationConfirmed @Hash = ? 
                
                Select @RetVal as RetVal
                """                    
                
        file_rows = conn().execute(query, (tokken)).fetchone()
        conn().close
        
        file_row = file_rows[0]
        
        if file_row==999:
          return render_template('success.html')
        else:
          return 'Ошибка 1'
  else:
    return 'Ошибка 2'

if __name__ == '__main__':
  app.run(debug=False)