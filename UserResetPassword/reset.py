from flask import Flask, render_template, request, redirect
import pyodbc
import configparser  # импортируем библиотеку для чтения конфигов
from loguru import logger

app = Flask(__name__, static_url_path="/reset_static", static_folder='reset_static')

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

@app.route('/reset/', methods=['get'])
@app.route('/', methods=['get'])
def index():
  logger.info(f'index')  
  logger.info(f'request: {request}')  
  
  tokken = request.args['tokken'] 
  
  if tokken:    
    query = """
                  declare @RetVal int 
                  select @RetVal = 0
                  select @RetVal = 1
                    from tClients (nolock)
                   where [Hash] = ?
                  
                  Select @RetVal as RetVal
            """       
    rows = conn().execute(query, (str(tokken))).fetchone()
         
    retval = rows[0]     
    if retval==1:    
      return render_template('reset.html')
    else:
      return 'Ошибка 1'
  else:
    return 'Ошибка 2'


@app.route('/reset/', methods=['post'])
@app.route('/', methods=['post'])
def save_password():
  logger.info(f'save_password')  
  logger.info(f'request: {request}')  
  
  tokken = request.args['tokken'] 
  
  passw = request.form.get('pswrd_2')

  query = """   set nocount on;
                declare @RetVal int 
                       ,@MSG    nvarchar(1024) 
                       
                select @RetVal = 0
                
                exec @RetVal = CustomerResetPassword
			                   @Hash      = ?,
			                   @Password  = ?
                 
                if @RetVal> 0 
                  set @MSG = dbo.GetRetMsg (@RetVal)
                  
                Select @RetVal as RetVal,
                       @MSG    as Message    
          """   

  rows = conn().execute(query, (tokken, passw)).fetchone()
         
  retval  = rows[0]
  message = rows[1]
          
  if retval==0:
    return redirect('/')
  else:
    return message

if __name__ == '__main__':
  app.run(debug=False)