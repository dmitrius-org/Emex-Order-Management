unit ServerModule;

{$I ..\compile.inc}

interface

uses
  Classes, Dialogs, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  uniGUITypes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  FireDAC.Comp.Client, FireDAC.VCLUI.Wait, FireDAC.Comp.UI,
  FireDAC.ConsoleUI.Wait, FireDAC.VCLUI.Error, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, Data.DB, uniThreadTimer

  ,Windows, Messages, Winapi.ShellAPI, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet
  ;

type
  TUniServerModule = class(TUniGUIServerModule)
    FDManager: TFDManager;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDGUIxErrorDialog: TFDGUIxErrorDialog;
    procedure UniGUIServerModuleCreate(Sender: TObject);
    procedure UniGUIServerModuleDestroy(Sender: TObject);
    procedure UniGUIServerModuleBeforeInit(Sender: TObject);
  private
    { Private declarations }

  protected
    procedure FirstInit; override;
  public
    { Public declarations }

  end;

  function UniServerModule: TUniServerModule;

  /// <summary>
  ///  ExploreWeb - Автоматический запуск приложения в браузере
  ///               Для ускорения разработки
  ///</summary>
  procedure ExploreWeb(page:PChar);

implementation

{$R *.dfm}

uses
  UniGUIVars, uSqlUtils;

function UniServerModule: TUniServerModule;
begin
  Result := TUniServerModule(UniGUIServerInstance);
end;

procedure TUniServerModule.FirstInit;
begin
  InitServerModule(Self);
end;


procedure TUniServerModule.UniGUIServerModuleBeforeInit(Sender: TObject);
begin
//{$ifndef UNIGUI_VCL}
//  Self.ExtRoot:='ext-7.2.0';
//  Self.UniRoot:='uni-1.90.0.1530';
//{$endif}
end;

procedure TUniServerModule.UniGUIServerModuleCreate(Sender: TObject);
begin
  Logger.AddLog('TUniServerModule.UniGUIServerModuleCreate', 'Begin');

  Title := 'Emex Manager';

  {$IFDEF UNIGUI_VCL}
  ExploreWeb('http://127.0.0.1:8087');
  {$ENDIF}
  MimeTable.AddMimeType('xlsm', 'application/vnd.ms-excel.sheet.macroEnabled.12');

  FDManager.DriverDefFileName     := UniServerModule.StartPath + 'Drivers.ini';
  FDManager.ConnectionDefFileName := UniServerModule.StartPath + 'Connection.ini';
  FDManager.DriverDefFileAutoLoad := True;
  FDManager.ConnectionDefFileAutoLoad := True;
  FDManager.Active := True;

  Logger.AddLog('TUniServerModule.SessionTimeout', FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['SessionTimeout']);
  if FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['SessionTimeout'].ToInteger > 0 then
    SessionTimeout := FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['SessionTimeout'].ToInteger
  else
    SessionTimeout := 600000; // 10 минут

  Title := FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['ApplicationName'];

  if FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['FrameworkFilesRoot']<> '' then
    FrameworkFilesRoot := FDManager.ConnectionDefs.FindConnectionDef('Connection').Params.Values['FrameworkFilesRoot'];

  Logger.AddLog('TUniServerModule.UniGUIServerModuleCreate', 'End');
end;

procedure TUniServerModule.UniGUIServerModuleDestroy(Sender: TObject);
begin
  FDManager.Close;
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
