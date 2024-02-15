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

  uCommonType, uAuditUtils, uEmexUtils, uSqlUtils, uLogger,
  FireDAC.Moni.RemoteClient
  ;

type
  TUniMainModule = class(TUniGUIMainModule)
    FDConnection: TFDConnection;
    Query: TFDQuery;
    FDMoniFlatFileClientLink: TFDMoniFlatFileClientLink;
    procedure UniGUIMainModuleDestroy(Sender: TObject);
    procedure UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled:Boolean);
    procedure UniGUIMainModuleCreate(Sender: TObject);
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

    ASPID: Integer;

    /// <summary> dbUserAuthorization - авторизация пользователя.
    ///  IsSaveSession:Boolean - подключение используя сохраненные данные  </summary>
    function dbUserAuthorization(AU: string; AP: string; IsSaveSession: Boolean = False): Boolean;

    function dbConnect(): Boolean;
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication, uMainVar;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

function TUniMainModule.dbConnect(): Boolean;
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

function TUniMainModule.dbUserAuthorization(AU, AP: string; IsSaveSession: Boolean = False): Boolean;
begin
  UniServerModule.Logger.AddLog('TUniMainModule.dbUserAuthorization', 'Begin');

  Query.SQL.Text := (' Select ClientID, IsActive from tClients (nolock) where Email=:Email and Password = master.dbo.fn_varbintohexstr(HashBytes(''SHA2_512'', :Password)) ');
  Query.ParamByName('Email').AsWideString    := AU;
  Query.ParamByName('Password').AsWideString := AP;
  Query.Open();

  if Query.RecordCount > 0 then
  begin
    if Query.FieldByName('IsActive').AsBoolean then
    begin
      UniServerModule.Logger.AddLog('TUniMainModule.dbUserAuthorization', 'Успешная авторизация');
      AUserID  := Query.FieldByName('ClientID').AsInteger;
      AUserName:=AU;
      Result   := True;

      // настройки  логирования
      CreateDefLogger(UniServerModule.Logger.RootPath + '\log\' + AUserName + '_app_' + FormatDateTime('ddmmyyyy', Now) +'.log');

      Sql.Open('Select AppClientLog, AppSqlLog from tLoggerSettings (nolock) where UserID = dbo.GetUserID() ', [],[]);
      if Sql.Q.RecordCount > 0 then
      begin
        logger.isActive := Sql.Q.FindField('AppClientLog').Value;
        logger.Info('Программа запущена');

        FDMoniFlatFileClientLink.FileName := UniServerModule.Logger.RootPath + '\log\' + AUserName + '_sql_' + FormatDateTime('ddmmyyyy', Now) +'.log';
        FDMoniFlatFileClientLink.Tracing := Sql.Q.FindField('AppSqlLog').Value;
      end;

      Audit.Add(TObjectType.otUser, AUserID, TFormAction.acLogin, 'Вход в систему');
    end
    else
    begin
      if not IsSaveSession then
        raise Exception.Create('Доступ отключен!');
      Result := false;
    end;
  end
  else
  begin
    Result := false;

    if not IsSaveSession then
        raise Exception.Create('Имя пользователя или пароль неверны!');
  end;
  UniServerModule.Logger.AddLog('TUniMainModule.dbUserConnect', 'End');
end;

procedure TUniMainModule.UniGUIMainModuleBeforeLogin(Sender: TObject; var Handled: Boolean);
var S1, S2 : string;
begin
  UniServerModule.Logger.AddLog('UniGUIMainModuleBeforeLogin', 'begin');

  S1 := (Sender as TUniGUISession).UniApplication.Cookies.Values['_loginname2D02D0BF'];
  S2 := (Sender as TUniGUISession).UniApplication.Cookies.Values['_pwd2D02D0BF'];

  if (S1 <> '') and ( S2 <> '') then
  begin
    Handled := dbUserAuthorization (S1, S2, True);

    if not Handled then
    begin
      (Sender as TUniGUISession).UniApplication.Cookies.SetCookie('_loginname2D02D0BF', '', Date - 1);
      (Sender as TUniGUISession).UniApplication.Cookies.SetCookie('_pwd2D02D0BF', '', Date - 1);
    end;

  end;

  UniServerModule.Logger.AddLog('UniGUIMainModuleBeforeLogin', 'end');
end;

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  {$IFDEF RELEASE}
  BackButtonAction := TUniBackButtonAction.bbaWarnUser;
  {$ENDIF}
end;

procedure TUniMainModule.UniGUIMainModuleDestroy(Sender: TObject);
begin
  Audit.Add(TObjectType.otUser, AUserID, TFormAction.acExit, 'Выход из системы');

  logger.Info('Программа остановлена');
  FreeDefLogger;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.
