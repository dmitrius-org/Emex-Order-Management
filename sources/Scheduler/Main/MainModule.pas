﻿ unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, uniGUIForm, uniGUITypes, vcl.Dialogs,
  FireDAC.Moni.Base, FireDAC.Moni.FlatFile,  FireDAC.Phys.FB,
  FireDAC.Phys.MySQL, FireDAC.Phys.ODBCBase, FireDAC.Moni.Custom,
  uCommonType, uAuditUtils, uAccrualUtils, uSqlUtils,
  uGrantUtils, FireDAC.Moni.RemoteClient,

  //uUtils.WS,
  uUtils.Logger,
  Quick.Logger,
  Quick.Logger.ExceptionHook,
  Quick.Logger.Provider.Files,
  Quick.Logger.Provider.ADODB;


type
  TUniMainModule = class(TUniGUIMainModule)
    FDConnection: TFDConnection;
    Query: TFDQuery;
    FDMoniFlatFileClientLink: TFDMoniFlatFileClientLink;
    qSetting: TFDQuery;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
    FDMoniSQl: TFDMoniCustomClientLink;
    procedure UniGUIMainModuleDestroy(Sender: TObject);
    procedure UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled:Boolean);
    procedure UniGUIMainModuleCreate(Sender: TObject);
    procedure FDMoniSQlOutput(ASender: TFDMoniClientLinkBase; const AClassName,
      AObjName, AMessage: string);
  private
    { Private declarations }

  public
    { Public declarations }
    /// <summary> AUserName - логин пользователя </summary>
    AUserName: string;
    AUserID  : integer;
    /// <summary> ASql    - </summary>
    ASql     : TSql;
    /// <summary> ARetVal - </summary>
    ARetVal  : TRetVal;
    /// <summary> AAudit  - </summary>
    AAudit   : TAudit;
    /// <summary> AGrant  - </summary>
    AGrant: TGrant;
    /// <summary> ASPID - Идентификатор сессии подключения к БД </summary>
    ASPID: Integer;
    /// <summary> AppName - Приложение </summary>
    AAppName:  String;
    ALogger : TLogger;

    GlobalLogFileProvider : TLogFileProvider;
    GlobalLogADODBProvider : TLogADODBProvider;

    const _loginname = '_loginname';
    const _pwd = '_pwd';

    function dbConnect(AUser: string; APass: string; ABefore: Boolean = false): Boolean;
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

uses
  UniGUIVars, ServerModule, uniGUIApplication, uMainVar, uConstant;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
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
    FileName        := UniServerModule.Logger.RootPath + '\log\' +
                       AUserName + '_' +
                       FormatDateTime('ddmmyyyy', Now) +'_Logger.log';
    DailyRotate     := True;
    MaxFileSizeInMB := 20;
    TimePrecission  := True;
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

function TUniMainModule.dbConnect(AUser: string; APass: string; ABefore: Boolean = false): Boolean;
begin
  UniServerModule.Logger.AddLog('TUniMainModule.dbConnect', 'Begin');
  try
    result:=False;
    try
      FDConnection.ConnectionDefName:='Connection';
      UniServerModule.Logger.AddLog('TUniMainModule FDConnection DriverID', FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['DriverID']);
      FDConnection.Params.Values['DriverID'] :=FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['DriverID'];

      if (AUser<>'') and (APass<>'') then
      begin
        FDConnection.Params.Add('User_name=' + AUser);
        FDConnection.Params.Add('Password='  + APass);
      end;

      // параметры подключения из ini файла
      UniServerModule.Logger.AddLog('TUniMainModule Параметры подключения', 'FDConnection');
      UniServerModule.Logger.AddLog('TUniMainModule FDConnection DriverID', FDConnection.Params.Values['DriverID']);
      UniServerModule.Logger.AddLog('TUniMainModule DriverID',  FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['DriverID']);
      UniServerModule.Logger.AddLog('TUniMainModule Server',    FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['Server']);
      UniServerModule.Logger.AddLog('TUniMainModule Database',  FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['Database']);
      UniServerModule.Logger.AddLog('TUniMainModule User_name', FDManager.ConnectionDefs.FindConnectionDef(FDConnection.ConnectionDefName).Params.Values['User_name']);
      UniServerModule.Logger.AddLog('TUniMainModule ConnectionDefFileName', FDManager.ConnectionDefFileName);

      {$IFDEF Release}
        FDConnection.Params.MonitorBy := mbCustom;
      {$ENDIF}
      FDConnection.Open;

      AUserName:= AUser;
      ASPID    := FDConnection.ExecSQLScalar('Select @@Spid');
      AUserID  := FDConnection.ExecSQLScalar('select dbo.GetUserID()');
      AAppName := AppScheduler;

      Audit.Add(TObjectType.otUser, AUserID, TFormAction.acLogin, 'Вход в систему');

      CreateLogger(AUserID, AAppName);

      Log('Программа запущена', uUtils.Logger.etHeader);
    except
      on E: EFDDBEngineException do
      case E.Kind of
        ekUserPwdInvalid:
        begin
          if not ABefore then
          begin
           raise Exception.Create('Имя пользователя или пароль неверны!');
          end
        end;
        ekUserPwdExpired:
        if not ABefore then
        begin
          raise Exception.Create('Ошибка подключения к БД. Срок действия пароля пользователя истек!');
        end;
        ekServerGone:
          raise Exception.Create('Ошибка соединения с базой данных. СУБД недоступна по какой-то причине!');
      else
        raise Exception.Create('Ошибка соединения с базой данных. Неизвестная ошибка!');
      end;
      on E : Exception do
        raise Exception.Create(E.ClassName+' поднята ошибка, с сообщением: '+#13#10+#13#10+E.Message);
    end;

  finally
    result:=FDConnection.Connected;
    UniServerModule.Logger.AddLog('TUniMainModule.dbConnect', 'End');
  end;
end;

procedure TUniMainModule.FDMoniSQlOutput(ASender: TFDMoniClientLinkBase;
  const AClassName, AObjName, AMessage: string);
begin
  ALogger.Info(Format('[%s:%s]', [AClassName, AObjName]));
  ALogger.Info(Format('%s', [AMessage]));
end;

procedure TUniMainModule.UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled: Boolean);
var S1, S2 : string;
begin
  UniServerModule.Logger.AddLog('TUniMainModule.UniGUIMainModuleBeforeLogin', 'begin');

  S1 := (Sender as TUniGUISession).UniApplication.Cookies.Values[_loginname];
  S2 := (Sender as TUniGUISession).UniApplication.Cookies.Values[_pwd];

  if (S1 <> '') and ( S2 <> '') then
  begin
    Handled := dbConnect ( S1,  S2, True );

    if Handled = False then
    begin
      (Sender as TUniGUISession).UniApplication.Cookies.SetCookie(_loginname,'',Date-1);
      (Sender as TUniGUISession).UniApplication.Cookies.SetCookie(_pwd,'',Date-1);
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

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject);
var A:TAudit;
begin
  A := TAudit.Create(FDConnection);
  A.Add(TObjectType.otUser, AUserID, TFormAction.acExit, 'Выход из системы');
  A.Destroy;

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
