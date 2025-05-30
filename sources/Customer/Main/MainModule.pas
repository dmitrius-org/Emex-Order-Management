 unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, uniGUIForm, uniGUITypes, vcl.Dialogs,
  FireDAC.Moni.Base, FireDAC.Moni.FlatFile,FireDAC.Phys.FB, FireDAC.Phys.MySQL,
  FireDAC.Phys.ODBCBase, FireDAC.Moni.Custom, FireDAC.Moni.RemoteClient,

  uCommonType, uAuditUtils, uEmexUtils, uSqlUtils, uUtils.WS,

  Quick.Commons,
  Quick.Logger,
  Quick.Logger.ExceptionHook,
  Quick.Logger.Provider.Files, Quick.Logger.Provider.ADODB

  ;

type
  TUniMainModule = class(TUniGUIMainModule)
    FDConnection: TFDConnection;
    Query: TFDQuery;
    FDMoniFlatFileClientLink: TFDMoniFlatFileClientLink;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
    FDMoniSQl: TFDMoniCustomClientLink;
    procedure UniGUIMainModuleDestroy(Sender: TObject);
    procedure UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled:Boolean);
    procedure UniGUIMainModuleCreate(Sender: TObject);
    procedure FDConnectionAfterConnect(Sender: TObject);
    procedure FDConnectionAfterDisconnect(Sender: TObject);
    procedure FDConnectionBeforeDisconnect(Sender: TObject);
    procedure FDConnectionRecover(ASender, AInitiator: TObject;
      AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
    procedure FDConnectionRestored(Sender: TObject);
    procedure FDConnectionLost(Sender: TObject);
    procedure FDConnectionLogin(AConnection: TFDCustomConnection;
      AParams: TFDConnectionDefParams);
    procedure FDConnectionBeforeStartTransaction(Sender: TObject);
    procedure FDMoniSQlOutput(ASender: TFDMoniClientLinkBase; const AClassName,
      AObjName, AMessage: string);
  private
    { Private declarations }

  public
    { Public declarations }
    /// <summary> AUserName - логин пользователя </summary>
    AUserName: string;
    AUserID: Integer;
    /// <summary> ASql -  </summary>
    ASql     : TSql;
    /// <summary> ARetVal -  </summary>
    ARetVal  : TRetVal;
    /// <summary> AAudit -  </summary>
    AAudit   : TAudit;
    /// <summary> ASPID - ИД SQL соединения </summary>
    ASPID: Integer;
    /// <summary> WS - WebSocket </summary>
    WS: tWS;
    /// <summary> AppName - Приложение </summary>
    AAppName:  String;

    ALogger : TLogger;

    GlobalLogFileProvider : TLogFileProvider;
    GlobalLogADODBProvider : TLogADODBProvider;

    const _loginname = '_loginname2D02D0BF';
    const _pwd = '_pwd2D02D0BF';

    /// <summary> CustomerAuthorization - авторизация пользователя.
    ///  IsSaveSession:Boolean - подключение используя сохраненные данные
    /// </summary>
    function CustomerAuthorization(AU: string; AP: string; IsSaveSession: Boolean = False): Boolean;

    function dbConnect(AConnName: string= ''): Boolean;

    procedure CreateGlobalLogFileProvider();
    procedure CreateGlobalLogADODBProvider();

    /// <summary>
    /// CreateLogger - включение логирования
    /// </summary>
    procedure CreateLogger(_AUserID: Integer; _AAppName: string);
  end;

  function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses UniGUIVars, ServerModule, uniGUIApplication, uMainVar,
     uConstant, uUtils.Logger;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

function TUniMainModule.dbConnect(AConnName: string= ''): Boolean;
begin
  UniServerModule.Logger.AddLog('TUniMainModule.dbConnect', 'Begin');
  try
    try
      FDConnection.Close;
      FDConnection.ConnectionDefName:='Connection';
      FDConnection.Params.Values['DriverID'] :=FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['DriverID'];

      // параметры подключения из ini файла
      UniServerModule.Logger.AddLog('TUniMainModule Параметры подключения', 'FDConnection');
      UniServerModule.Logger.AddLog('TUniMainModule FDConnection DriverID', FDConnection.Params.Values['DriverID']);
      UniServerModule.Logger.AddLog('TUniMainModule DriverID',  FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['DriverID']);
      UniServerModule.Logger.AddLog('TUniMainModule Server',    FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['Server']);
      UniServerModule.Logger.AddLog('TUniMainModule Database',  FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['Database']);
      UniServerModule.Logger.AddLog('TUniMainModule User_name', FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['User_name']);
      UniServerModule.Logger.AddLog('TUniMainModule ConnectionDefFileName', FDManager.ConnectionDefFileName);

      FDConnection.Params.Values['ApplicationName'] := FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['ApplicationName'] + ' - ' + AConnName;

      FDConnection.Params.MonitorBy := mbCustom;
      FDConnection.Open;

      ASPID := FDConnection.ExecSQLScalar('Select @@Spid');

    except
      on E: EFDDBEngineException do
      case E.Kind of
        ekUserPwdInvalid:
          raise Exception.Create('Имя технического пользователя или пароль неверны! '+ #13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message);
        ekUserPwdExpired:
          raise Exception.Create('Ошибка подключения к БД. Срок действия пароля пользователя истек! ' +#13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message);
        ekServerGone:
          raise Exception.Create('Ошибка соединения с базой данных. СУБД недоступна по какой-то причине! ' +#13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message);
      else // other issues
        raise Exception.Create('Ошибка соединения с базой данных. Неизвестная ошибка! ' +#13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message);
      end;
      on E : Exception do
        raise Exception.Create(E.ClassName+' поднята ошибка, с сообщением: '+#13#10+#13#10+E.Message);
    end;

  finally
    result:=FDConnection.Connected;
    UniServerModule.Logger.AddLog('TUniMainModule.dbConnect', 'End');
  end;
end;

procedure TUniMainModule.FDConnectionAfterConnect(Sender: TObject);
begin
  FDConnection.ExecSQL(
  '''
    -- таблица для пагинации формы заказов
    if OBJECT_ID('tempdb..#OrderPage') is not null
      drop table #OrderPage

    CREATE TABLE #OrderPage
      (
          OrderID  numeric(18,0)
         ,Page     int
      );

    -- таблица для возврата количества обработанных записей
    if OBJECT_ID('tempdb..#ProcessedRecords') is not null
        drop table #ProcessedRecords;

    CREATE TABLE #ProcessedRecords (
                 Processed  int
                ,Total      int
    );

  ''');
end;

procedure TUniMainModule.FDConnectionAfterDisconnect(Sender: TObject);
begin
  Log('TUniMainModule.FDConnectionAfterDisconnect', etInfo);
end;

procedure TUniMainModule.FDConnectionBeforeDisconnect(Sender: TObject);
begin
  Log('TUniMainModule.FDConnectionBeforeDisconnect', etInfo);
end;

procedure TUniMainModule.FDConnectionBeforeStartTransaction(Sender: TObject);
begin
  Log('TUniMainModule.FDConnectionBeforeStartTransaction', etInfo);
end;

procedure TUniMainModule.FDConnectionLogin(AConnection: TFDCustomConnection;
  AParams: TFDConnectionDefParams);
begin
  Log('TUniMainModule.FDConnectionLogin', etInfo);
end;

procedure TUniMainModule.FDConnectionLost(Sender: TObject);
begin
  Log('TUniMainModule.FDConnectionLost', etInfo);
end;

procedure TUniMainModule.FDConnectionRecover(ASender, AInitiator: TObject;
  AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
begin
  Log('TUniMainModule.FDConnectionRecover', etInfo);
end;

procedure TUniMainModule.FDConnectionRestored(Sender: TObject);
begin
  Log('TUniMainModule.FDConnectionRestored', etInfo);
end;

procedure TUniMainModule.FDMoniSQlOutput(ASender: TFDMoniClientLinkBase;
  const AClassName, AObjName, AMessage: string);
begin
  ALogger.Info(Format('[%s:%s]', [AClassName, AObjName]));
  ALogger.Info(Format('%s', [AMessage]));
end;

procedure TUniMainModule.CreateGlobalLogADODBProvider;
var
  C : TUniClientInfoRec;
begin
  if ALogger.Providers.IndexOf(GlobalLogADODBProvider) > -1 then
    Exit;

  GlobalLogADODBProvider := TLogADODBProvider.Create;
  ALogger.Providers.Add(GlobalLogADODBProvider);

  with GlobalLogADODBProvider do
  begin
    C:=UniSession.UniApplication.ClientInfoRec;
    TimePrecission := True;
    Environment    :='';
    AppName        := AAppName;
    Host           := UniSession.RemoteIP;
    UserID         := AUserID;
    UserName       := AUserName;
    PlatformInfo   := C.BrowserType + ' ' +
                      C.BrowserVersion.ToString;
    OS             := C.OSType;
    IncludedInfo   := [iiAppName,iiHost,iiUserName,iiUserID,iiOSVersion,iiPlatform,iiThreadId];

    DBConfig.Table   := 'tLogMsg';
    DBConfig.Provider:= dbMSSQL;
    DBConfig.Server  := FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['Server'];
    DBConfig.Database:= FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['Database'];
    DBConfig.UserName:= FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['LoggerUserName'];
    DBConfig.Password:= FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['LoggerPassword'];
  end;
end;

procedure TUniMainModule.CreateGlobalLogFileProvider;
begin
  if ALogger.Providers.IndexOf(GlobalLogFileProvider)>-1 then
    Exit;

  GlobalLogFileProvider:= TLogFileProvider.Create;
  ALogger.Providers.Add(GlobalLogFileProvider);

  with GlobalLogFileProvider do
  begin
    FileName := UniServerModule.Logger.RootPath + '\log\' +
                AUserName + '_' +
                FormatDateTime('ddmmyyyy', Now) +'_Logger.log';
    DailyRotate := True;
    MaxFileSizeInMB := 20;
    TimePrecission := True;
    CompressRotatedFiles := False;
    IncludedInfo    := [iiAppName,iiHost,iiUserName,iiOSVersion,iiThreadId,iiProcessId];
  end;
end;

procedure TUniMainModule.CreateLogger(_AUserID: Integer; _AAppName: string);
begin
  Sql.Open('''
  Select cast(iif(CHARINDEX('В файл', LogDestination) > 0, 1, 0) as bit) SaveFile,
         cast(iif(CHARINDEX('В базу данных', LogDestination) > 0, 1, 0) as bit) SaveDB,
         FileLogLevel,
         DBLogLevel,
         LogSql
    from tLoggerSettings (nolock)
   where UserID = :UserID
     and AppName= :AppName
  ''',
  ['UserID', 'AppName'],[_AUserID, _AAppName]);

  if Sql.Q.RecordCount > 0 then
  begin
    // настройки  логирования
    if Sql.Q.FindField('SaveFile').AsBoolean then
    begin
      CreateGlobalLogFileProvider();

      with GlobalLogFileProvider do
      begin
        LogLevel:= ParseLogLevel(Sql.Q.FindField('FileLogLevel').AsString);
        Enabled := True;
      end;
    end;

    if Sql.Q.FindField('SaveDB').AsBoolean then
    begin
      CreateGlobalLogADODBProvider;

      with GlobalLogADODBProvider do
      begin
        LogLevel:= ParseLogLevel(Sql.Q.FindField('DBLogLevel').AsString);
        Enabled := True;
      end;
    end;

    if (Sql.Q.FindField('SaveFile').AsBoolean) or
       (Sql.Q.FindField('SaveDB').AsBoolean)
    then
    begin
      FDMoniSQl.Tracing := Sql.Q.FindField('LogSql').AsBoolean;
    end
    else
      FDMoniSQl.Tracing := False;
  end;

  log('Логирование', uUtils.Logger.etDebug);
  log('AUserID=%s', [_AUserID.ToString], uUtils.Logger.etDebug);
  log('AUserName=%s', [AUserName], uUtils.Logger.etDebug);
  log('AAppName=%s', [AAppName], uUtils.Logger.etDebug);

  if Assigned(GlobalLogFileProvider) then
    log('Логирование в файл=%s', [GlobalLogFileProvider.Enabled.ToString()], uUtils.Logger.etDebug)
  else
    log('Логирование в файл=%s', [False.ToString()], uUtils.Logger.etDebug);

  if Assigned(GlobalLogADODBProvider) then
    log('Логирование в базу=%s', [GlobalLogADODBProvider.Enabled.ToString()], uUtils.Logger.etDebug)
  else
    log('Логирование в базу=%s', [False.ToString()], uUtils.Logger.etDebug);

  log('Логирование в sql=%s', [FDMoniSQl.Tracing.ToString()], uUtils.Logger.etDebug);
end;

function TUniMainModule.CustomerAuthorization(AU, AP: string; IsSaveSession: Boolean = False): Boolean;
begin
  UniServerModule.Logger.AddLog('TUniMainModule.dbUserAuthorization', 'begin');

  dbConnect(AU);

  Query.SQL.Text := '''
   declare @R int
          ,@Password nvarchar(512)
          ,@ClientID numeric(18, 0)

   select @Password = master.dbo.fn_varbintohexstr(HashBytes('SHA2_512', :Password))

   exec @R = CustomerAuthorization
               @UserName = :Email,
               @Password = @Password,
               @ClientID = @ClientID out

   select @R        as R
         ,@ClientID as ClientID
  ''';

  // Важно AsWideString
  Query.ParamByName('Email').AsWideString    := AU;
  Query.ParamByName('Password').AsWideString := AP;
  Query.Open();

  RetVal.Code := Query.FieldByName('r').AsInteger;

  if RetVal.Code = 0 then
  begin
    AUserID  := Query.FieldByName('ClientID').AsInteger;
    AUserName:= AU;
    AAppName := AppCustomer;

    Audit.Add(TObjectType.otSearchAppUser, AUserID, TFormAction.acLogin, 'Вход в систему', AUserID, UniSession.RemoteIP);

    CreateLogger(AUserID, AAppName);

    Log('Программа запущена', uUtils.Logger.etHeader);

    WS :=TWS.Create('customer', AUserID.ToString);

    Result := True;
  end
  else
  begin
    Result := false;

    if not IsSaveSession then raise Exception.Create(RetVal.Message);
  end;
  UniServerModule.Logger.AddLog('TUniMainModule.dbUserAuthorization', 'end');
end;

procedure TUniMainModule.UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled: Boolean);
var S1, S2 : string;
begin
  UniServerModule.Logger.AddLog('TUniMainModule.UniGUIMainModuleBeforeLogin', 'begin');

  S1 := (Sender as TUniGUISession).UniApplication.Cookies.Values[_loginname];
  S2 := (Sender as TUniGUISession).UniApplication.Cookies.Values[_pwd];

  if (S1 <> '') and ( S2 <> '') then
  begin
    Handled := CustomerAuthorization (S1, S2, True);

    if not Handled then
    begin
      (Sender as TUniGUISession).UniApplication.Cookies.SetCookie(_loginname, '', Date - 1);
      (Sender as TUniGUISession).UniApplication.Cookies.SetCookie(_pwd, '', Date - 1);
    end;

  end;

  UniServerModule.Logger.AddLog('TUniMainModule.UniGUIMainModuleBeforeLogin', 'end');
end;

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  {$IFDEF RELEASE}
  BackButtonAction := TUniBackButtonAction.bbaWarnUser;
  {$ENDIF}

  // Инициация объекта для логирования
  if Assigned(ALogger) then
    ALogger.Free;
  ALogger := TLogger.Create;
end;

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject); // Отрабатывает с некоторой задержкой
var FAudit : TAudit;
begin
  WS.Destroy();

  FAudit := TAudit.Create(FDConnection);
  FAudit.Add(TObjectType.otSearchAppUser, AUserID, TFormAction.acExit, 'Выход из системы', AUserID, UniSession.RemoteIP);
  FAudit.Free;

  FDConnection.Close;

  ALogger.Info('Программа остановлена');

  if Assigned(GlobalLogFileProvider) and (GlobalLogFileProvider.RefCount = 0) then
    GlobalLogFileProvider.Free;

  if Assigned(GlobalLogADODBProvider) and (GlobalLogADODBProvider.RefCount = 0) then
    GlobalLogADODBProvider.Free;

  if Assigned(ALogger) then
    ALogger.Free;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
