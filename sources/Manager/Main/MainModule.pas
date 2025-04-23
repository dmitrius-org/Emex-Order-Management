 unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSSQL, FireDAC.Phys.MSSQLDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, uniGUIForm, uniGUITypes, vcl.Dialogs,
  FireDAC.Moni.Base, FireDAC.Moni.FlatFile,
  FireDAC.Phys.FB,
  FireDAC.Phys.MySQL, FireDAC.Phys.ODBCBase, FireDAC.Moni.Custom,

  uCommonType, uAuditUtils, uAccrualUtils, uEmexUtils, uSqlUtils,
  uGrantUtils, FireDAC.Moni.RemoteClient, Windows, uniGUIBaseClasses,
  uniGUIClasses, uniTimer, FireDAC.Phys.ODBCDef, FireDAC.Phys.ODBC,
  uUtils.WS,

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
    MemTable: TFDMemTable;
    MemTableIsPart: TBooleanField;

    procedure UniGUIMainModuleDestroy(Sender: TObject);
    procedure UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled:Boolean);
    procedure UniGUIMainModuleCreate(Sender: TObject);
    procedure FDConnectionAfterConnect(Sender: TObject);
  private
    { Private declarations }

    /// <summary>
    ///  AppVersion - версия программы
    ///</summary>
    procedure AppVersion();
  public
    { Public declarations }

    /// <summary> AUserName - логин пользователя </summary>
    AUserName: string;
    /// <summary> AUserID - ИД пользователя </summary>
    AUserID : Integer;
    /// <summary> ASql -  Объект для выполнения sql запросов  </summary>
    ASql     : TSql;
    /// <summary> ARetVal - Объект для обработки ошибок </summary>
    ARetVal  : TRetVal;
    /// <summary> AAudit - объект для аудита </summary>
    AAudit   : TAudit;
    /// <summary> AGrant - Объект для хранения прав доступа на систему </summary>
    AGrant: TGrant;
    /// <summary> ASPID - Идентификатор сессии подключения к БД </summary>
    ASPID: Integer;
    /// <summary> WS - Объект WebSocket </summary>
    WS:  tWS;
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
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication, uMainVar, uConstant, uUtils.Logger;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

procedure TUniMainModule.AppVersion;
begin
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

    LogLevel := LOG_ALL;
    TimePrecission := True;
    Environment  :='';
    AppName      := AAppName;
    Host         := UniSession.RemoteIP;
    UserID       := AUserID;
    UserName     := AUserName;
    PlatformInfo := C.BrowserType + ' ' +
                    C.BrowserVersion.ToString;
    OS           := C.OSType;
    IncludedInfo := [iiAppName,iiHost,iiUserName,iiUserID,iiOSVersion,iiPlatform];

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
    FileName := UniServerModule.Logger.RootPath + '\log\' + AUserName + '_' + FormatDateTime('ddmmyyyy', Now) +'_Logger.log';
    DailyRotate := True;
    MaxFileSizeInMB := 20;
    LogLevel := LOG_ALL;
    TimePrecission := True;
    CompressRotatedFiles := False;
  end;
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

      FDConnection.Open;

      MemTable.Open;

      AUserName:=AUser;
      ASPID := FDConnection.ExecSQLScalar('Select @@Spid');
      AUserID := FDConnection.ExecSQLScalar('select dbo.GetUserID()');
      AAppName:= AppManager;

      WS := TWS.Create('manager:' + AUserID.ToString);

      AppVersion;

      Audit.Add(TObjectType.otUser, AUserID, TFormAction.acLogin, 'Вход в систему');

      Sql.Open('''
      Select AppClientLog,
             AppSqlLog,
             cast(iif(CHARINDEX('В файл', LogDestination) > 0, 1, 0) as bit) SaveFile,
             cast(iif(CHARINDEX('В базу данных', LogDestination) > 0, 1, 0) as bit) SaveDB
        from tLoggerSettings (nolock)
       where UserID = :UserID
         and AppName= :AppName
      ''',
      ['UserID', 'AppName'],[AUserID, AAppName]);

      if Sql.Q.RecordCount > 0 then
      begin

        if Sql.Q.FindField('AppClientLog').AsBoolean then
        begin
          UniServerModule.Logger.AddLog('TUniMainModule.dbUserAuthorization SaveFile', Sql.Q.FindField('SaveFile').AsString );
          // настройки  логирования
          if Sql.Q.FindField('SaveFile').AsBoolean then
          begin
            CreateGlobalLogFileProvider();

            with GlobalLogFileProvider do
            begin
              Enabled := True;
              UniServerModule.Logger.AddLog('TUniMainModule.dbUserAuthorization GlobalLogFileProvider.logger.Enabled', 'True');
            end;
          end;

          UniServerModule.Logger.AddLog('TUniMainModule.dbUserAuthorization SaveDB', Sql.Q.FindField('SaveDB').AsString );
          if Sql.Q.FindField('SaveDB').AsBoolean then
          begin
            CreateGlobalLogADODBProvider;
            with GlobalLogADODBProvider do
            begin
              Enabled := True;
            end;
          end;
        end;

        FDMoniFlatFileClientLink.FileName := UniServerModule.Logger.RootPath + '\log\' + AUserName + '_sql_' + FormatDateTime('ddmmyyyy', Now) +'.log';
        FDMoniFlatFileClientLink.Tracing := Sql.Q.FindField('AppSqlLog').Value;
      end;

      Log('Программа запущена', etHeader);
    except
      on E: EFDDBEngineException do
      case E.Kind of
        ekUserPwdInvalid:
        begin
          if not ABefore then
          begin
            raise Exception.Create('Имя пользователя или пароль неверны!'{+ #13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message});
          end
        end;
        ekUserPwdExpired:
        if not ABefore then
        begin
          raise Exception.Create('Ошибка подключения к БД. Срок действия пароля пользователя истек!' {+#13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message});
        end;
        ekServerGone:
          raise Exception.Create('Ошибка соединения с базой данных. СУБД недоступна по какой-то причине!' {+#13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message});
      else // other issues
        raise Exception.Create('Ошибка соединения с базой данных. Неизвестная ошибка!' {+#13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message});
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
      -- таблица для возврата количества обработанных записей
      if OBJECT_ID('tempdb..#ProcessedRecords') is not null
          drop table #ProcessedRecords;

      CREATE TABLE #ProcessedRecords (
                   Processed  int
                  ,Total      int
      );

      -- таблица для параметров действия
      if OBJECT_ID('tempdb..#ActionParams') is not null
          drop table #ActionParams;

      CREATE TABLE #ActionParams (
                   ActionID   numeric(18, 0)
                  ,DateValue  datetime -- произвольная дата
      );
  ''');
end;

procedure TUniMainModule.UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled: Boolean);
var S1, S2 : string;
begin
  UniServerModule.Logger.AddLog('TUniMainModule.UniGUIMainModuleBeforeLogin', 'begin');

  S1 := (Sender as TUniGUISession).UniApplication.Cookies.Values['_loginname'];
  S2 := (Sender as TUniGUISession).UniApplication.Cookies.Values['_pwd'];

  if (S1 <> '') and ( S2 <> '') then
  begin
    Handled := dbConnect ( S1,  S2, True );

    if Handled = False then
    begin
      (Sender as TUniGUISession).UniApplication.Cookies.SetCookie('_loginname','',Date-1);
      (Sender as TUniGUISession).UniApplication.Cookies.SetCookie('_pwd','',Date-1);
    end;
  end;

  UniServerModule.Logger.AddLog('TUniMainModule.UniGUIMainModuleBeforeLogin', 'end');
end;

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  {$IFDEF RELEASE}
  BackButtonAction := TUniBackButtonAction.bbaWarnUser;
  {$ENDIF}

  // настройки  логирования

  if Assigned(ALogger) then
    ALogger.Free;
  ALogger := TLogger.Create;


//  if Assigned(GlobalLogFileProvider) and (GlobalLogFileProvider.RefCount = 0) then
//    GlobalLogFileProvider.Free;
//
//  if Assigned(GlobalLogADODBProvider) and (GlobalLogADODBProvider.RefCount = 0) then
//    GlobalLogADODBProvider.Free;
end;

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject);
var FAudit : TAudit;
begin
  WS.Destroy('manager:' + AUserID.ToString);

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
