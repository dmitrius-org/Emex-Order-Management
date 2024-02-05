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
  FireDAC.Stan.Async, Data.DB, uniThreadTimer

  ,Windows, Messages, Winapi.ShellAPI
  ;

type
  TUniServerModule = class(TUniGUIServerModule)
    FDManager: TFDManager;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDGUIxErrorDialog: TFDGUIxErrorDialog;
    FDTaskConnection: TFDConnection;
    FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink;
    UniThreadTimer: TUniThreadTimer;
    procedure UniGUIServerModuleCreate(Sender: TObject);
    procedure UniGUIServerModuleDestroy(Sender: TObject);
    procedure UniGUIServerModuleServerStartup(Sender: TObject);
    procedure UniThreadTimerTimer(Sender: TObject);
    procedure UniGUIServerModuleBeforeInit(Sender: TObject);
  private
    { Private declarations }
    function dbConnect(): Boolean;
  protected
    procedure FirstInit; override;
    procedure TaskEnabled();
  public
    { Public declarations }
  end;

  function UniServerModule: TUniServerModule;

  /// <summary>
  ///  ExploreWeb - �������������� ������ ���������� � ��������
  ///               ��� ��������� ����������
  ///</summary>
  procedure ExploreWeb(page:PChar);

implementation

{$R *.dfm}

uses UniGUIVars, uTaskUtils;

var
  MTask: TMTask;

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

      // ��������� ����������� �� ini �����
      Logger.AddLog('TUniServerModule ��������� �����������', 'FDTaskConnection');
      Logger.AddLog('TUniServerModule FDTaskConnection DriverID', FDTaskConnection.Params.Values['DriverID']);
      Logger.AddLog('TUniServerModule DriverID',    FDManager.ConnectionDefs.FindConnectionDef(FDTaskConnection.ConnectionDefName).Params.Values['DriverID']);
      Logger.AddLog('TUniServerModule Server',      FDManager.ConnectionDefs.FindConnectionDef(FDTaskConnection.ConnectionDefName).Params.Values['Server']);
      Logger.AddLog('TUniServerModule Database',    FDManager.ConnectionDefs.FindConnectionDef(FDTaskConnection.ConnectionDefName).Params.Values['Database']);
      Logger.AddLog('TUniServerModule User_name',   FDManager.ConnectionDefs.FindConnectionDef(FDTaskConnection.ConnectionDefName).Params.Values['User_name']);
      Logger.AddLog('TUniServerModule ConnectionDefFileName', FDManager.ConnectionDefFileName);
      FDTaskConnection.Connected := True;

      //Audit.Add(TObjectType.otAuthorization, 0, TFormAction.acLogin, '���� � �������');

    except
      on E: EFDDBEngineException do
      case E.Kind of
        ekUserPwdInvalid:
          Logger.AddLog('TUniMainModule ekUserPwdInvalid', '��� ������������ ��� ������ �������! '+ #13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message);
        ekUserPwdExpired:
          Logger.AddLog('TUniMainModule ekUserPwdExpired', '������ ����������� � ��. ���� �������� ������ ������������ �����! ' +#13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message);
        ekServerGone:
          Logger.AddLog('TUniMainModule ekServerGone', '������ ���������� � ����� ������. ���� ���������� �� �����-�� �������! ' +#13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message);
      else // other issues
        Logger.AddLog('TUniMainModule Other issues', '������ ���������� � ����� ������. ����������� ������! ' +#13#10+#13#10+E.ClassName+' ������� ������, � ����������: '+E.Message);
      end;
      on E : Exception do
        Logger.AddLog('TUniMainModule Exception', E.ClassName+' ������� ������, � ����������: '+#13#10+#13#10+E.Message);
    end;
  finally
    result:=FDTaskConnection.Connected;
    Logger.AddLog('TUniServerModule.dbConnect', 'end');
  end;
end;

procedure TUniServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

procedure TUniServerModule.TaskEnabled;
begin
  UniThreadTimer.Enabled := MTask.IsActive;
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

  Title := 'Scheduler';

  {$IFDEF UNIGUI_VCL}
  ExploreWeb('http://127.0.0.1:8078');
  {$ENDIF}

  MimeTable.AddMimeType('xlsm', 'application/vnd.ms-excel.sheet.macroEnabled.12');

  FDManager.DriverDefFileName     := UniServerModule.StartPath + 'Drivers.ini';
  FDManager.ConnectionDefFileName := UniServerModule.StartPath + 'Connection.ini';
  FDManager.DriverDefFileAutoLoad := True;
  FDManager.ConnectionDefFileAutoLoad := True;
  FDManager.Active := True;

  dbConnect;

  MTask:= TMTask.Create(FDTaskConnection);

  TaskEnabled();

  Logger.AddLog('TUniServerModule.UniGUIServerModuleCreate', 'End');
end;

procedure TUniServerModule.UniGUIServerModuleDestroy(Sender: TObject);
begin
  FDManager.Close;

  FreeAndNil(MTask);
end;

procedure TUniServerModule.UniGUIServerModuleServerStartup(Sender: TObject);
begin
//  Logger.AddLog('TUniServerModule.UniGUIServerModuleServerStartup', 'Begin');
//
//  Logger.AddLog('TTUniServerModule.UniGUIServerModuleServerStartup', 'End');
end;

procedure TUniServerModule.UniThreadTimerTimer(Sender: TObject);
begin
//  try
    MTask.Execute;
//  except
//    on E: Exception do
//      Logger.AddLog('TUniServerModule.UniThreadTimerTimer', E.Message);
//  end;
end;

procedure ExploreWeb(page:PChar);
var Returnvalue: Integer;
begin
  Returnvalue := ShellExecute(0,'open',page, nil, nil, 1);
  if Returnvalue <= 32  then
    begin
      case Returnvalue of
         0: ShowMessage ('������, ������������� ������!');
         2: ShowMessage ('������, ������ ����� �����!');
         3: ShowMessage ('������, ������ ����� ����!');
         11: ShowMessage ('������, ���� EXE ��������������!');
      else
        ShowMessage (PCHAR ('��� ������: '+ InttoStr (ReturnValue) +', ����������, ��������� ������. '));
      end;
    end;
end;

initialization
  RegisterServerModuleClass(TUniServerModule);
end.
