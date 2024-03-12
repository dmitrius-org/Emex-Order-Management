unit ServerModule;

{$I compile.inc}

interface

uses
  Classes, Dialogs, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  uniGUITypes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.ConsoleUI.Wait, FireDAC.VCLUI.Error, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, Data.DB, uniThreadTimer, Variants,

  Windows, Messages, Winapi.ShellAPI, uTaskUtils
  ;

type
  TUniServerModule = class(TUniGUIServerModule)
    FDManager: TFDManager;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDGUIxErrorDialog: TFDGUIxErrorDialog;
    FDTaskConnection: TFDConnection;
    UniThreadTimer: TUniThreadTimer;
    DBAlert: TFDEventAlerter;
    procedure UniGUIServerModuleCreate(Sender: TObject);
    procedure UniGUIServerModuleDestroy(Sender: TObject);
    procedure UniThreadTimerTimer(Sender: TObject);
    procedure DBAlertAlert(ASender: TFDCustomEventAlerter;
      const AEventName: string; const AArgument: Variant);
    procedure FDTaskConnectionError(ASender, AInitiator: TObject;
      var AException: Exception);
    procedure UniGUIServerModuleException(Sender: TUniGUIMainModule;
      AException: Exception; var Handled: Boolean);
  private
    { Private declarations }

    function dbConnect(): Boolean;
  protected
    procedure FirstInit; override;

  public
    MTask: TMTask;
    procedure TaskEnabled();
  end;

  function UniServerModule: TUniServerModule;

  /// <summary>
  ///  ExploreWeb - Автоматический запуск приложения в браузере
  ///               Для ускорения разработки
  ///</summary>
  procedure ExploreWeb(page:PChar);

implementation

{$R *.dfm}

uses UniGUIVars;


function UniServerModule: TUniServerModule;
begin
  Result := TUniServerModule(UniGUIServerInstance);
end;

function TUniServerModule.dbConnect(): Boolean;
begin
  Logger.AddLog('TUniServerModule.dbConnect', 'begin');
  try
    try
      FDTaskConnection.ConnectionDefName:='TaskConnection';

      FDTaskConnection.Params.Values['DriverID'] :=FDManager.ConnectionDefs.FindConnectionDef(FDTaskConnection.ConnectionDefName).Params.Values['DriverID'];

      // параметры подключения из ini файла
      Logger.AddLog('TUniServerModule Параметры подключения', 'FDTaskConnection');
      Logger.AddLog('TUniServerModule FDTaskConnection DriverID', FDTaskConnection.Params.Values['DriverID']);
      Logger.AddLog('TUniServerModule DriverID',    FDManager.ConnectionDefs.FindConnectionDef(FDTaskConnection.ConnectionDefName).Params.Values['DriverID']);
      Logger.AddLog('TUniServerModule Server',      FDManager.ConnectionDefs.FindConnectionDef(FDTaskConnection.ConnectionDefName).Params.Values['Server']);
      Logger.AddLog('TUniServerModule Database',    FDManager.ConnectionDefs.FindConnectionDef(FDTaskConnection.ConnectionDefName).Params.Values['Database']);
      Logger.AddLog('TUniServerModule User_name',   FDManager.ConnectionDefs.FindConnectionDef(FDTaskConnection.ConnectionDefName).Params.Values['User_name']);
      Logger.AddLog('TUniServerModule ConnectionDefFileName', FDManager.ConnectionDefFileName);
      FDTaskConnection.Connected := True;

    except
      on E: EFDDBEngineException do
      case E.Kind of
        ekUserPwdInvalid:
          Logger.AddLog('TUniMainModule ekUserPwdInvalid', 'Имя пользователя или пароль неверны! '+ #13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message);
        ekUserPwdExpired:
          Logger.AddLog('TUniMainModule ekUserPwdExpired', 'Ошибка подключения к БД. Срок действия пароля пользователя истек! ' +#13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message);
        ekServerGone:
          Logger.AddLog('TUniMainModule ekServerGone', 'Ошибка соединения с базой данных. СУБД недоступна по какой-то причине! ' +#13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message);
      else
        Logger.AddLog('TUniMainModule Other issues', 'Ошибка соединения с базой данных. Неизвестная ошибка! ' +#13#10+#13#10+E.ClassName+' Поднята ошибка, с сообщением: '+E.Message);
      end;
      on E : Exception do
        Logger.AddLog('TUniMainModule Exception', E.ClassName+' поднята ошибка, с сообщением: '+#13#10+#13#10+E.Message);
    end;
  finally
    result:=FDTaskConnection.Connected;
    Logger.AddLog('TUniServerModule.dbConnect', 'end');
  end;
end;

procedure TUniServerModule.DBAlertAlert(ASender: TFDCustomEventAlerter;
  const AEventName: string; const AArgument: Variant);
//var
//	i: Integer;
//	sArgs: String;
begin
//	if VarIsArray(AArgument) then
//  begin
//		sArgs := '';
//		for i := VarArrayLowBound(AArgument, 1) to VarArrayHighBound(AArgument, 1) do
//    begin
//			if sArgs <> '' then
//				sArgs := sArgs + ', ';
//			sArgs := sArgs + VarToStr(AArgument[i]);
//		end;
//	end
//	else if VarIsNull(AArgument) then sArgs := '<NULL>'
//	else if VarIsEmpty(AArgument) then sArgs := '<UNASSIGNED>'
//	else sArgs := VarToStr(AArgument);
//
//	logger.AddLog('Event - [' + AEventName + '] - [' + sArgs + ']');
////  logger.Info(AEventName + ' ' + '');
//
//  if AEventName = 'IsActive' then
//  begin
//    TaskEnabled;
//  end;
end;

procedure TUniServerModule.FDTaskConnectionError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  Logger.AddLog('TUniServerModule.FDTaskConnectionError', AException.Message);
end;

procedure TUniServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

procedure TUniServerModule.TaskEnabled();
begin
  Logger.AddLog('TUniServerModule.TaskEnabled', 'Begin');
  //MTask.IsActive := not MTask.IsActive;

  UniThreadTimer.Enabled := MTask.IsActive;
  Logger.AddLog('TUniServerModule.TaskEnabled Enabled: ', UniThreadTimer.Enabled.ToString());
  Logger.AddLog('TUniServerModule.TaskEnabled', 'End');
end;

procedure TUniServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
  Logger.AddLog('TUniServerModule.UniGUIServerModuleCreate', 'Begin');

  {$IFDEF UNIGUI_VCL}
  ExploreWeb('http://127.0.0.1:8078');
  {$ENDIF}

  //MimeTable.AddMimeType('xlsm', 'application/vnd.ms-excel.sheet.macroEnabled.12');

  FDManager.DriverDefFileName     := UniServerModule.StartPath + 'Drivers.ini';
  FDManager.ConnectionDefFileName := UniServerModule.StartPath + 'Connection.ini';
  FDManager.DriverDefFileAutoLoad := True;
  FDManager.ConnectionDefFileAutoLoad := True;
  FDManager.Active := True;

  Title := FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['ApplicationName'];

  dbConnect;

//  DBAlert.Names.Clear;
//  DBAlert.Names.Add('QUEUE=TaskManager');
// 	DBAlert.Names.Add('SERVICE=TaskManager');
//  DBAlert.Names.Add('CHANGE1=IsActive;select IsActive from tTaskActive (nolock)');
//	DBAlert.Options.Synchronize := True;
//	DBAlert.Register;

  MTask:= TMTask.Create(FDTaskConnection);
 // if MTask.IsActive then
 //   TaskEnabled();

  Logger.AddLog('TUniServerModule.UniGUIServerModuleCreate', 'End');
end;

procedure TUniServerModule.UniGUIServerModuleDestroy(Sender: TObject);
begin
  FreeAndNil(MTask);
  FDManager.Close;
end;

procedure TUniServerModule.UniGUIServerModuleException(
  Sender: TUniGUIMainModule; AException: Exception; var Handled: Boolean);
begin
  Logger.AddLog('TUniServerModule.UniGUIServerModuleException', AException.Message);
end;

procedure TUniServerModule.UniThreadTimerTimer(Sender: TObject);
begin
  try
    //Logger.AddLog('TUniServerModule.UniThreadTimerTimer');
    if MTask.IsActive then
      MTask.Execute;
  except
    on E: Exception do
      Logger.AddLog('TUniServerModule.UniThreadTimerTimer Exception', E.Message);
  end;
end;

procedure ExploreWeb(page:PChar);
var Returnvalue: Integer;
begin
  Returnvalue := ShellExecute(0,'open',page, nil, nil, 1);
  if Returnvalue <= 32  then
    begin
      case Returnvalue of
         0: ShowMessage ('Ошибка, недостаточная память!');
         2: ShowMessage ('Ошибка, ошибка имени файла!');
         3: ShowMessage ('Ошибка, ошибка имени пути!');
         11: ShowMessage ('Ошибка, файл EXE недействителен!');
      else
        ShowMessage (PCHAR ('Код ошибки: '+ InttoStr (ReturnValue) +', пожалуйста, проверьте ошибку. '));
      end;
    end;
end;

initialization
  RegisterServerModuleClass(TUniServerModule);
end.
